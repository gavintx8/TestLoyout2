//
//  GHomeController.m
//  QuCai
//
//  Created by mac on 2017/10/17.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHomeController.h"
#import "GHomePaveModel.h"
#import "BAKit_BAGridView.h"
#import "BAGridView_Config.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"
#import "UIView+YNPageExtend.h"
#import "YNPageTableView.h"
#import "JXCategoryView.h"
#import "GHotTableView.h"
#import "GZRenTableView.h"
#import "GDZCollectionView.h"
#import "MFBannerView.h"
#import "MFTextBannerCell.h"
#import "HHContentTableView.h"
#import "GLotteryVc.h"
#import "GTransferAccounts.h"
#import "GNewActivityVc.h"
#import "XXAlertView.h"
#import "GKPhotoBrowser.h"
#import "GOpenAccountVc.h"
#import "GGameEnterCell.h"

static NSString *const TextBannerCellIdentifier = @"TextBannerCellIdentifier";

@interface GHomeController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,JXCategoryViewDelegate,MFBannerViewDataSource,MFBannerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;
@property (nonatomic, strong) UIButton *firstMoreBtn;

@property (nonatomic, strong) NSArray *imagesURLStrings;
@property (nonatomic, strong) NSMutableArray <GHomePaveModel *> *picArray;
@property (nonatomic, strong) NSMutableArray *annAry;

@property(nonatomic, strong) BAGridView_Config *ba_GridViewConfig;
@property(nonatomic, strong) BAGridView *gridView;
@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView2;

@property (nonatomic, weak) MFBannerView *bannerView;
@property (nonatomic, copy) NSArray *datas;

@end

@implementation GHomeController

- (void)onCreate {
    
    self.view.backgroundColor = Them_Color;
    [self createUI];
    [self loadData];
    [self loadBannerData];
}

- (void)onWillShow {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:@"localPicsAry"] == nil) {
        [self loadData];
    }
    if ([def objectForKey:@"localGonGaoAry"] == nil) {
        [self loadData];
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)onWillDisappear{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)onDidAppear {
    [self setupNav];
}

- (void)loadData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @"1";
    dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
    
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kMobilePicture RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSMutableArray *temArray = [NSMutableArray array];
        if (responseObject != nil) {
            
            self.picArray = [GHomePaveModel mj_objectArrayWithKeyValuesArray:responseObject];
            
            for (int i = 0; i < self.picArray.count; i++) {
                if ([self.picArray[i].src1 isEqualToString:[[SZUser shareUser] readSrc1Link]]) {
                    [temArray addObject:[GTool stringChineseFamat:self.picArray[i].img1]];
                }
            }
            if (0 != temArray.count) {
                self.cycleScrollView.imageURLStringsGroup = temArray;
                
                [[NSUserDefaults standardUserDefaults] setObject:temArray forKey:@"localPicsAry"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    } failure:^(NSError *error) {
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary = [NSMutableArray array];
        ary = [def objectForKey:@"localPicsAry"];
        self.cycleScrollView.imageURLStringsGroup = ary;
    }];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
    self.annAry = [NSMutableArray array];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kAnnouncement RequestWay:kPOST withParamters:dic1 withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if (responseObject != nil) {
            NSMutableArray *ary = responseObject;
            for (int i = 0; i < ary.count; i++) {
                NSDictionary *dict = ary[i];
                if ([[dict objectForKey:@"src1"] isEqualToString:[[SZUser shareUser] readSrc1Link]]) {
                    [self.annAry addObject:ary[i][@"rmk"]];
                }
            }
            if (0 != self.annAry.count) {
                self.cycleScrollView2.titlesGroup = [self.annAry copy];
                
                [[NSUserDefaults standardUserDefaults] setObject:self.annAry forKey:@"localGonGaoAry"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    } failure:^(NSError *error) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        self.annAry = [def objectForKey:@"localGonGaoAry"];
    }];
}

- (void)setupNav {
    if(KIsiPhoneX){
        UIImage *bgImage = [UIImage imageNamed:@"logoX"];
        bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    }else{
        UIImage *bgImage = [UIImage imageNamed:@"logo"];
        bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)createUI{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    //1
    
    self.cycleScrollView = [[SDCycleScrollView alloc] init];
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(165);
    }];
    
    //2
    
    [self.contentView addSubview:self.gridView];
    self.ba_GridViewConfig.gridViewType = BAGridViewTypeImageTitle;
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = Them_Color;
    [self.contentView addSubview:lineLabel2];
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gridView.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(10);
    }];
    
    //3
    
    self.cycleScrollView2 = [[SDCycleScrollView alloc] init];
    self.cycleScrollView2.delegate = self;
    self.cycleScrollView2.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.cycleScrollView2.onlyDisplayText = YES;
    self.cycleScrollView2.titleLabelBackgroundColor = [UIColor whiteColor];
    self.cycleScrollView2.titleLabelTextColor = [UIColor blackColor];
    self.cycleScrollView2.layer.cornerRadius = 16;
    self.cycleScrollView2.layer.masksToBounds = YES;
    [self.cycleScrollView2 disableScrollGesture];
    [self.contentView addSubview:self.cycleScrollView2];
    [self.cycleScrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gridView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    UIView *moreView = [[UIView alloc] init];
    moreView.layer.cornerRadius = 16;
    moreView.layer.masksToBounds = YES;
    [moreView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:moreView];
    [moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cycleScrollView2);
        make.right.mas_equalTo(self.cycleScrollView2.mas_right);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    self.firstMoreBtn = [[UIButton alloc] init];
    [self.firstMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.firstMoreBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.firstMoreBtn.titleLabel.font = TXT_SIZE_14;
    [self.firstMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.firstMoreBtn setBackgroundColor:[UIColor whiteColor]];
    [moreView addSubview:self.firstMoreBtn];
    [self.firstMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moreView);
        make.right.mas_equalTo(moreView.mas_right).offset(-15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    self.firstMoreBtn.tag = 2002;
    [self.firstMoreBtn addTarget:self action:@selector(actionBtnClickMore:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *coverLabel = [[UILabel alloc] init];
    coverLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:coverLabel];
    [coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moreView);
        make.left.equalTo(moreView.mas_left);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = Them_Color;
    [moreView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moreView);
        make.left.mas_equalTo(moreView.left).offset(16);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(20);
    }];
    
    //4
    
    NSUInteger count = 3;
    CGFloat categoryViewHeight = 50;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 450;
    
    _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight + 315, width, height)];
    self.scrollView2.pagingEnabled = YES;
    self.scrollView2.contentSize = CGSizeMake(width*count, height);
    self.scrollView2.bounces = NO;
    self.scrollView2.showsHorizontalScrollIndicator = NO;
    self.scrollView2.scrollEnabled = NO;
    [self.contentView addSubview:self.scrollView2];
    [self.scrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(365);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView2.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    GHotTableView *powerListView = [[GHotTableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView2.bounds.size.width, self.scrollView2.bounds.size.height)];
    powerListView.dataSourceImg = @[@"index_hot_01", @"index_hot_02", @"index_hot_03", @"index_hot_04", @"index_hot_05"].mutableCopy;
    powerListView.dataSourceTitle = @[@"PS电子", @"YOUPLAY电子", @"MG电子", @"PT电子", @"VG棋牌"].mutableCopy;
    powerListView.dataSourceDesc = @[@"大型游戏平台，创新体验！", @"首创“多人模式”，探讨闯关之旅！", @"专业游戏平台，千万奖池等您来！", @"知名游戏平台，上千款主题游戏！", @"知名棋牌平台，百万注册！"].mutableCopy;

    powerListView.hotBlock = ^(NSInteger index) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
            if(index == 0){
                GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                geeConVc.navTitle = @"PS电子";
                geeConVc.geeType = GEETypePS;
                [self.navigationController pushViewController:geeConVc animated:YES];
            }else if(index == 2){
                GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                geeConVc.navTitle = @"MG电子";
                geeConVc.geeType = GEETypeMG;
                [self.navigationController pushViewController:geeConVc animated:YES];
            }else if(index == 4){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryAGQP" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",302] forKey:@"leftCurrentIndex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                GLoginVC *gLogin = [[GLoginVC alloc] init];
                [self presentViewController:gLogin animated:YES completion:nil];
            }
        }else{
            if(index == 0){
                GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                geeConVc.navTitle = @"PS电子";
                geeConVc.geeType = GEETypePS;
                [self.navigationController pushViewController:geeConVc animated:YES];
            }else if(index == 1){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"YOUPLAY电子";
                gTransferAccounts.gameType = @"YOPLAY";
                gTransferAccounts.gameID = @"YP800";
                gTransferAccounts.fromName = @"AGIN国际厅/YOPLAY电子/AG体育";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 2){
                GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                geeConVc.navTitle = @"MG电子";
                geeConVc.geeType = GEETypeMG;
                [self.navigationController pushViewController:geeConVc animated:YES];
            }else if(index == 3){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"PT电子";
                gTransferAccounts.gameType = @"PT";
                gTransferAccounts.gameID = @"";
                gTransferAccounts.fromName = @"PT电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 4){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryAGQP" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",302] forKey:@"leftCurrentIndex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        
    };
    [self.scrollView2 addSubview:powerListView];
    
    GZRenTableView *hobbyListView = [[GZRenTableView alloc] initWithFrame:CGRectMake(self.scrollView2.bounds.size.width, 0, self.scrollView2.bounds.size.width, self.scrollView2.bounds.size.height)];
    hobbyListView.dataSourceImg = @[@"index_casino_01", @"index_casino_02", @"index_casino_03", @"index_casino_05", @"index_casino_04"].mutableCopy;
    hobbyListView.dataSourceTitle = @[@"AG国际厅", @"Cagayan88", @"BBIN视讯", @"申博视讯", @"OG视讯"].mutableCopy;
    hobbyListView.dataSourceDesc = @[@"美女主播 热线传情", @"美女主播 多元化玩法", @"老牌旗舰 玩法齐全", @"多款百家乐 一次拥有", @"感受刺激 体验心跳"].mutableCopy;
    hobbyListView.zrenBlock = ^(NSInteger index) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
            GLoginVC *gLogin = [[GLoginVC alloc] init];
            [self presentViewController:gLogin animated:YES completion:nil];
        }else{
            GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
            if(index == 0){
                gTransferAccounts.platformName = @"AG国际厅";
                gTransferAccounts.gameType = @"AGIN";
                gTransferAccounts.gameID = @"";
                gTransferAccounts.fromName = @"AGIN国际厅/YOPLAY电子/AG体育/捕鱼";
            }else if(index == 1){
                gTransferAccounts.platformName = @"Cagayan88";
                gTransferAccounts.gameType = @"CG";
                gTransferAccounts.gameID = @"";
                gTransferAccounts.fromName = @"Cagayan88";
            }else if(index == 2){
                gTransferAccounts.platformName = @"BBIN视讯";
                gTransferAccounts.gameType = @"BBIN";
                gTransferAccounts.gameID = @"1";
                gTransferAccounts.fromName = @"BBIN视讯/电子";
            }else if(index == 3){
                gTransferAccounts.platformName = @"申博视讯";
                gTransferAccounts.gameType = @"SB";
                gTransferAccounts.gameID = @"3";
                gTransferAccounts.fromName = @"申博视讯";
            }else if(index == 4){
                gTransferAccounts.platformName = @"OG视讯";
                gTransferAccounts.gameType = @"OG";
                gTransferAccounts.gameID = @"";
                gTransferAccounts.fromName = @"OG视讯";
            }
            [self.navigationController pushViewController:gTransferAccounts animated:YES];
        }
            
    };
    [self.scrollView2 addSubview:hobbyListView];
    
    GDZCollectionView *partnerListView = [[GDZCollectionView alloc] initWithFrame:CGRectMake(self.scrollView2.bounds.size.width*2, 0, self.scrollView2.bounds.size.width, self.scrollView2.bounds.size.height + 145)];
    partnerListView.dataSourceImg = @[@"index_games_02", @"index_games_03", @"index_games_04", @"index_games_05", @"index_games_06", @"index_games_07"].mutableCopy;
    partnerListView.dataSourceTitle = @[@"篮球巨星", @"狼贼夺宝", @"天子", @"大航海时代", @"幸运龙", @"鲤鱼门"].mutableCopy;
    partnerListView.dzBlock = ^(NSInteger index) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
            GLoginVC *gLogin = [[GLoginVC alloc] init];
            [self presentViewController:gLogin animated:YES completion:nil];
        }else{
            if(index == 0){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"篮球巨星";
                gTransferAccounts.gameType = @"MG";
                gTransferAccounts.gameID = @"45539";
                gTransferAccounts.fromName = @"MG电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 1){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"狼贼夺宝";
                gTransferAccounts.gameType = @"HABA";
                gTransferAccounts.gameID = @"SGCoyoteCrash";
                gTransferAccounts.fromName = @"HABA电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 2){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"天子";
                gTransferAccounts.gameType = @"PS";
                gTransferAccounts.gameID = @"PSS-ON-00019";
                gTransferAccounts.fromName = @"PS电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 3){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"大航海时代";
                gTransferAccounts.gameType = @"MG";
                gTransferAccounts.gameID = @"28692";
                gTransferAccounts.fromName = @"MG电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 4){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"幸运龙";
                gTransferAccounts.gameType = @"JDB";
                gTransferAccounts.gameID = @"8001";
                gTransferAccounts.fromName = @"JDB电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 5){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"鲤鱼门";
                gTransferAccounts.gameType = @"HABA";
                gTransferAccounts.gameID = @"SGTheKoiGate";
                gTransferAccounts.fromName = @"HABA电子";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }else if(index == 123){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryDZ" object:nil];
            }else if(index == 321){
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.platformName = @"AG捕鱼";
                gTransferAccounts.gameType = @"AGIN";
                gTransferAccounts.gameID = @"";
                gTransferAccounts.fromName = @"AGIN国际厅/YOPLAY电子/体育/捕鱼";
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            }
        }
    };
    [self.scrollView2 addSubview:partnerListView];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 315, kScreenWidth, categoryViewHeight)];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.titleSelectedColor = BG_Nav;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"热门游戏", @"真人视讯", @"电子游戏"];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = BG_Nav;
    lineView.backgroundColor = Them_Color;
    lineView.indicatorLineWidth = 70;
    self.categoryView.indicators = @[lineView];
    
    self.categoryView.contentScrollView = self.scrollView2;
    [self.contentView addSubview:self.categoryView];
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(10, categoryViewHeight - 1, width - 20, 1)];
    separatorView.backgroundColor = Them_Color;
    [self.categoryView addSubview:separatorView];
    
    //5
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = Them_Color;
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView2.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(245);
    }];
    
    UIView *bannerBGView = [[UIView alloc] init];
    bannerBGView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:bannerBGView];
    [bannerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(180);
    }];
    
    UILabel *preferentialLabel = [GUIHelper getLabel:@"最新优惠" andFont:[UIFont systemFontOfSize:16.f] andTextColor:[UIColor blackColor]];
    [bannerBGView addSubview:preferentialLabel];
    [preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bannerBGView.mas_top).offset(10);
        make.left.equalTo(bannerBGView.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *moreButton = [GUIHelper getButtonWithImage:[UIImage imageNamed:@"index_rightmore"]];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    moreButton.titleLabel.font = TXT_SIZE_14;
    [moreButton setTitleColor:[UIColor colorWithHexStr:@"#8F8F8F"] forState:UIControlStateNormal];
    [bannerBGView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(preferentialLabel);
        make.right.mas_equalTo(bannerBGView.mas_right).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    moreButton.tag = 2001;
    [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -moreButton.imageView.sz_size.width, 0, moreButton.imageView.sz_size.width)];
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, moreButton.titleLabel.bounds.size.width+10, 0, -moreButton.titleLabel.bounds.size.width)];
    [moreButton addTarget:self action:@selector(actionBtnClickMore:) forControlEvents:UIControlEventTouchUpInside];
    
    MFBannerView *bannerView = [[MFBannerView alloc] init];
    bannerView.isInfiniteLoop = YES;
    bannerView.autoScrollInterval = 3.0;
    bannerView.dataSource = self;
    bannerView.delegate = self;
    [bannerView registerClass:[MFTextBannerCell class] forCellWithReuseIdentifier:TextBannerCellIdentifier];
    [bannerBGView addSubview:bannerView];
    _bannerView = bannerView;
    
    self.bannerView.frame = CGRectMake(0, 35, CGRectGetWidth(self.view.frame), 140);
    self.bannerView.layout.scrollDirection = MFBannerViewScrollDirectionHorizontal;
    self.bannerView.layout.itemMainDimensionCenter = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.bannerView.layout.layoutType = MFBannerLayoutCoverflow;
        [self.bannerView setNeedUpdateLayout];
    });
    
    NSString *label_text = @"关于天下网络  |  隐私说明  |  会员制度  |  联系我们";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label_text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text.length)];
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.attributedText = attributedString;
    bottomLabel.textColor = Title_Gray;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom).offset(15);
        make.centerX.equalTo(bottomView);
        make.height.mas_equalTo(20);
    }];
    [bottomLabel yb_addAttributeTapActionWithStrings:@[@"关于天下网络",@"隐私说明",@"会员制度",@"联系我们"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        if(index == 0){
            GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
            gOpenAccountVc.navTitle = @"关于我们";
            gOpenAccountVc.htmlName = @"about.html";
            [self.navigationController pushViewController:gOpenAccountVc animated:YES];
        }else if(index == 1){
            GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
            gOpenAccountVc.navTitle = @"隐私说明";
            gOpenAccountVc.htmlName = @"ysbf_rule.html";
            [self.navigationController pushViewController:gOpenAccountVc animated:YES];
        }else if(index == 2){
            GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
            gOpenAccountVc.navTitle = @"会员制度";
            gOpenAccountVc.htmlName = @"member_rule.html";
            [self.navigationController pushViewController:gOpenAccountVc animated:YES];
        }else if(index == 3){
            self.tabBarController.selectedIndex = 2;
        }
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView);
    }];
}

- (void)actionBtnClickMore:(UIButton *)btn {
    if(btn.tag == 2001){
        GNewActivityVc *gNewActivityVc = [[GNewActivityVc alloc] init];
        [self.navigationController pushViewController:gNewActivityVc animated:NO];
    }else if(btn.tag == 2002){
        
        NSString *content = @"";
        for(int i=0;i<self.annAry.count;i++){
            if(i == 0){
                content = [NSString stringWithFormat:@"%d.%@",i + 1,self.annAry[i]];
            }else{
                content = [NSString stringWithFormat:@"%@\n\n%d.%@",content,i + 1,self.annAry[i]];
            }
        }
        [[XXAlertView sharedAlertView] showAlertViewWithTextString:content andType:2];
        
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [[XXAlertView sharedAlertView] showAlertViewWithTextString:self.annAry[index] andType:1];
}

#pragma mark - BAGridView

- (BAGridView_Config *)ba_GridViewConfig {
    if (!_ba_GridViewConfig) {
        _ba_GridViewConfig = [[BAGridView_Config alloc] init];
    }
    return _ba_GridViewConfig;
}

- (BAGridView *)gridView
{
    if (!_gridView)
    {
        self.ba_GridViewConfig.scrollEnabled = NO;
        self.ba_GridViewConfig.showLineView = NO;
        self.ba_GridViewConfig.ba_gridView_lineColor = BAKit_Color_Red_pod;
        self.ba_GridViewConfig.ba_gridView_rowCount = 5;
        self.ba_GridViewConfig.ba_gridView_itemHeight = 100;
        self.ba_GridViewConfig.ba_gridView_itemImageInset = 2;
        self.ba_GridViewConfig.ba_gridView_titleFont = [UIFont systemFontOfSize:14];
        self.ba_GridViewConfig.ba_gridView_backgroundColor = [UIColor whiteColor];
        self.ba_GridViewConfig.dataArray = self.gridDataArray;
        
        _gridView = [BAGridView ba_creatGridViewWithGridViewConfig:self.ba_GridViewConfig block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            if(indexPath.row == 0){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategory" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"leftCurrentIndex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else if(indexPath.row == 1){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryDZ" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:@"leftCurrentIndex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else if(indexPath.row == 2){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryQP" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",3] forKey:@"leftCurrentIndex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else if(indexPath.row == 3){
                GLotteryVc *lotteryVc = [[GLotteryVc alloc] init];
                lotteryVc.judgeStr = @"0";
                [self.navigationController pushViewController:lotteryVc animated:YES];
            }else if(indexPath.row == 4){
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryTY" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",4] forKey:@"leftCurrentIndex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
    }
    return _gridView;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;

        NSArray *imageNameArray = @[@"icon_inter",@"icon_slots",@"icon_chess",@"icon_lottery",@"icon_sports"];
        
        NSArray *titleArray = @[@"真人视讯", @"电子游戏", @"棋牌游戏", @"彩票游戏", @"体育游戏"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            if (imageNameArray.count > 0)
            {
                model.imageName = imageNameArray[i];
            }
            model.placdholderImageName = @"";
            model.titleString = titleArray[i];
            
            [self.gridDataArray addObject:model];
        }
    }
    return _gridDataArray;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if(index == 1){
        [self.scrollView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(450);
        }];
    }else if(index == 2){
        [self.scrollView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((((kScreenWidth - 60)/2)*9/16 + 40)*3 + 130 + 45);
        }];
    }else{
        [self.scrollView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(450);
        }];
    }
}

#pragma mark - bannerView

- (void)loadBannerData {
    
    NSMutableArray *datas = [NSMutableArray array];
//    for (int i = 0; i < 2; ++i) {
//        if (i == 0) {
//            [datas addObject:@"http://192.168.0.140/AG1/imgs/1544168479884txyh_m_youhui_01.jpg"];
//            continue;
//        }
//        [datas addObject:@"index_yh_02"];
//    }
    [datas addObject:@"http://192.168.0.140/AG1/imgs/1544168479746txyh_m_youhui_01.jpg"];
    [datas addObject:@"http://192.168.0.140/AG1/imgs/1544168479816txyh_m_youhui_02.jpg"];
    [datas addObject:@"http://192.168.0.140/AG1/imgs/1544168479884txyh_m_youhui_03.jpg"];
    self.datas = datas;
    [self.bannerView reloadData];
}

#pragma mark - MFBannerViewDataSource

- (NSInteger)numberOfItemsInBannerView:(MFBannerView *)bannerView {
    
    return self.datas.count;
}

- (UICollectionViewCell *)bannerView:(MFBannerView *)bannerView cellForItemAtIndex:(NSInteger)index {
    
    MFTextBannerCell *bannerCell = [bannerView dequeueReusableCellWithReuseIdentifier:TextBannerCellIdentifier forIndex:index];
//    bannerCell.imv.image = [UIImage imageNamed:self.datas[index]];
    [bannerCell.imv sd_setImageWithURL:[NSURL URLWithString:self.datas[index]]];
    bannerCell.layer.allowsEdgeAntialiasing = YES;
    return bannerCell;
}

- (MFBannerLayout *)layoutForBannerView:(MFBannerView *)bannerView {
    
    MFBannerLayout *layout = [[MFBannerLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(bannerView.frame)*0.8, CGRectGetHeight(bannerView.frame)*0.8);
    layout.itemSpacing = 15.0;
    return layout;
}

#pragma mark - MFBannerViewDelegate

- (void)bannerView:(MFBannerView *)bannerView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    NSString *urlPath = @"";
    if(index == 0){
        urlPath = @"http://192.168.0.140/AG1/imgs/1544168480328txyh_m_youhui_js_01.jpg";
    }else if(index == 1){
        urlPath = @"http://192.168.0.140/AG1/imgs/1544168480448txyh_m_youhui_js_02.jpg";
    }else if(index == 2){
        urlPath = @"http://192.168.0.140/AG1/imgs/1544168480564txyh_m_youhui_js_03.jpg";
    }
    if (![urlPath isEqualToString:@""]) {
        NSString *imageUrl = [GTool stringChineseFamat:urlPath];
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:imageUrl];
        
        NSMutableArray *photos = [NSMutableArray new];
        [photos addObject:photo];
        GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
        browser.showStyle = GKPhotoBrowserShowStyleNone;
        browser.loadStyle = GKPhotoBrowserLoadStyleDeterminate;
//        [self presentViewController:browser animated:NO completion:nil];
        [self.navigationController pushViewController:browser animated:YES];
    }
}

@end
