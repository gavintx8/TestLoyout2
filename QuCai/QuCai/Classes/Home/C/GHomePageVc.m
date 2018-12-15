//
//  GHomePageVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHomePageVc.h"
#import "VerticalBannerCell.h"
#import "JMBootstrapButtonConfig.h"
#import "JMButton.h"
#import "GTheSecondModuleCollectionViewCell.h"
#import "GTabBarVc.h"
#import "GCategoryVc.h"
#import "GKPhotoBrowser.h"
#import "GNewActivityVc.h"
#import <AFHTTPSessionManager.h>
#import "GHomePaveModel.h"
#import "GHomepageModelS.h"
#import "GLotteryVc.h"
#import "GTransferAccounts.h"
#import "GEEContainerVc.h"

@interface GHomePageVc () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIView *alertAdView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView3;
@property (nonatomic, strong) SZNetWorkingManager *sZNetWorkingManager;
@property (nonatomic, strong) UIView *theFirstModuleView;
@property (nonatomic, strong) UIView *theSecondModuleView;
@property (nonatomic, strong) UICollectionView *theSecondModuleCollectionView;
@property (nonatomic, strong) UILabel *platformRecommendLabel;
@property (nonatomic, strong) UIButton *firstMoreBtn;
@property (nonatomic, strong) UIButton *secondMoreBtn;
@property (nonatomic, strong) NSMutableArray <GHomePaveModel *> *picArray;
@property (nonatomic, strong) NSMutableArray <GHomepageModelS *> *picArrayS;
@property (nonatomic, strong) UITableView *bannerTableView;
@property (nonatomic, strong) VerticalBannerCell* cell;

@end

@implementation GHomePageVc

- (void)onCreate {
    [self creatUI];
    [self loadDataF];
}

- (void)onWillShow {
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if ([def objectForKey:@"localPicsAry"] == nil) {
        [self loadDataF];
    }
    if ([def objectForKey:@"localGonGaoAry"] == nil) {
        [self initAlertView];
    }
}

- (void) onDidAppear {
    [self setupNav];
}

- (void)onWillDisappear {
    
}

- (void) setupNav {
    
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

- (void)loadDataF {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @"1";
    dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
    
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kMobilePicture RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSMutableArray *temArray = [NSMutableArray array];
        if (responseObject != nil) {
            
            self.picArray = [GHomePaveModel mj_objectArrayWithKeyValuesArray:responseObject];
            
            for (int i = 0; i < self.picArray.count; i++) {
                if ([self.picArray[i].src1 isEqualToString:[[SZUser shareUser] readSrc1Link]]) {
                    [temArray addObject:self.picArray[i].img1];
                }
            }
            if (0 != temArray.count) {
                self.cycleScrollView3.imageURLStringsGroup = temArray;
                
                [[NSUserDefaults standardUserDefaults] setObject:temArray forKey:@"localPicsAry"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    } failure:^(NSError *error) {
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary = [NSMutableArray array];
        ary = [def objectForKey:@"localPicsAry"];
        self.cycleScrollView3.imageURLStringsGroup = ary;
    }];
}

- (void)creatUI {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self initScrollViewImgV];
    [self initAlertView];
    [self theFirstModule];
    [self secondModule];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(840);
    }];
}

#pragma mark - —————————— theFirstModule ——————————
- (void)theFirstModule {
    
    self.theFirstModuleView = [[UIView alloc] init];
    [self.contentView addSubview:self.theFirstModuleView];
    [self.theFirstModuleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertAdView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(350/2 + 48 + 90);
    }];

    self.platformRecommendLabel = [GUIHelper getLabel:@"平台推荐" andFont:TXT_SIZE_15 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [self.theFirstModuleView addSubview:self.platformRecommendLabel];
    [self.platformRecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.theFirstModuleView.mas_top).offset(21);
        make.left.equalTo(self.theFirstModuleView.mas_left).offset(12);
    }];
    
    UILabel *nearLabel = [GUIHelper getLabel:@"精彩荟萃,激情无限" andFont:TXT_SIZE_11 andTextColor:[UIColor colorWithHexStr:@"#a4a4a4"]];
    [self.theFirstModuleView addSubview:nearLabel];
    [nearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.platformRecommendLabel);
        make.left.equalTo(self.platformRecommendLabel.mas_right).offset(18);
    }];
    
    
    self.firstMoreBtn = [GUIHelper getButtonWithImage:[UIImage imageNamed:@"left_more"]];
    [self.firstMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
    self.firstMoreBtn.titleLabel.font = TXT_SIZE_14;
    [self.firstMoreBtn setTitleColor:BG_Nav forState:UIControlStateNormal];
    [self.theFirstModuleView addSubview:self.firstMoreBtn];
    [self.firstMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.platformRecommendLabel);
        make.right.mas_equalTo(self.theFirstModuleView.mas_right).offset(-14);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    [self.firstMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.firstMoreBtn.imageView.sz_size.width, 0, self.firstMoreBtn.imageView.sz_size.width)];
    [self.firstMoreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.firstMoreBtn.titleLabel.bounds.size.width+10, 0, -self.firstMoreBtn.titleLabel.bounds.size.width)];
    [self.firstMoreBtn addTarget:self action:@selector(firstBtnClickMore:) forControlEvents:UIControlEventTouchUpInside];
    self.firstMoreBtn.tag = 1;
    
    CGFloat W = (SCREEN_WIDTH - 0) / 4;
    CGFloat H = 75;
    NSInteger rank = 4;
    CGFloat rankMargin = (self.view.frame.size.width - rank * W) / (rank);
    CGFloat rowMargin = 23;
    
    CGFloat lastY = 0;
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"HomeList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    for (int i = 0; i < 10; i++) {
        
        JMBootstrapButtonConfig *buttonConfig = [JMBootstrapButtonConfig buttonConfig];
        buttonConfig.titleFont = TXT_SIZE_13;
        buttonConfig.bootstrapType = JMBootstrapTypeNone;
        buttonConfig.titleColor = [UIColor colorWithHexStr:@"#787878"];
        buttonConfig.styleType = JMButtonStyleTypeTop;
        buttonConfig.padding = 12.5;
        buttonConfig.imageSize = CGSizeMake(46, 46);
        
        NSDictionary *dict = dataArrs[i];
        buttonConfig.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        buttonConfig.title = [dict objectForKey:@"title"];
        
        CGFloat X = (i % rank) * (W + rankMargin) ;
        NSUInteger Y = (i / rank) * (H +rowMargin);
        
        JMButton *btn = [[JMButton alloc] initWithFrame:CGRectMake(X-25/2, Y + 58, W + 25, H) ButtonConfig:buttonConfig];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.theFirstModuleView addSubview:btn];
        
        lastY = Y + H;
    }
    UIView *lineView = [GUIHelper getViewWithColor:[UIColor colorWithHexStr:@"#f5f5f5"]];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.theFirstModuleView);
        make.top.equalTo(self.theFirstModuleView.mas_bottom).offset(32);
        make.height.mas_equalTo(10);
    }];
}

- (void)firstBtnClickMore:(UIButton *)btn {
    
    if (1 == btn.tag) {
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategory" object:nil];
    } else {
        GNewActivityVc *gNewActivityVc = [[GNewActivityVc alloc] init];
        [self.navigationController pushViewController:gNewActivityVc animated:NO];
    }
}

#pragma mark -------------------platform recomment----------------------
- (void)btnClick:(JMButton *)sender {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        if (sender.tag == 4) {
            GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
            geeConVc.navTitle = @"MG电子";
            geeConVc.geeType = GEETypeMG;
            [self.navigationController pushViewController:geeConVc animated:YES];
            
        }else if (sender.tag == 6) {
            GLotteryVc *lotteryVc = [[GLotteryVc alloc] init];
            lotteryVc.judgeStr = @"1";
            [self.navigationController pushViewController:lotteryVc animated:YES];
        }else if (sender.tag == 7) {
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryKYQP" object:nil];
        }else if (sender.tag == 8) {
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryAGQP" object:nil];
        }else if (sender.tag == 9) {
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryTY" object:nil];
        }else {
            GLoginVC *gLogin = [[GLoginVC alloc] init];
            [self presentViewController:gLogin animated:YES completion:nil];
        }
    } else {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"HomeList" ofType:@"plist"];
        NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        
        GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
        
        if (sender.tag == 4) {
            GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
            geeConVc.navTitle = @"MG电子";
            geeConVc.geeType = GEETypeMG;
            [self.navigationController pushViewController:geeConVc animated:YES];
            
        }else if (sender.tag == 6) {
            GLotteryVc *lotteryVc = [[GLotteryVc alloc] init];
            lotteryVc.judgeStr = @"1";
            [self.navigationController pushViewController:lotteryVc animated:YES];
        }else if (sender.tag == 7) {
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryKYQP" object:nil];
        }else if (sender.tag == 8) {
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryAGQP" object:nil];
        }else if (sender.tag == 9) {
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToCategoryTY" object:nil];
        }else{
            NSDictionary *dict = dataArrs[sender.tag];
            
            gTransferAccounts.platformName = [dict objectForKey:@"platformName"];
            gTransferAccounts.gameType = [dict objectForKey:@"gameType"];
            gTransferAccounts.gameID = [dict objectForKey:@"gameID"];
            gTransferAccounts.fromName = [dict objectForKey:@"fromName"];
            [self.navigationController pushViewController:gTransferAccounts animated:YES];
        }
    }
}

#pragma mark - —————————— secondModule ——————————

- (void)secondModule {
    
    self.theSecondModuleView = [[UIView alloc] init];
    [self.contentView addSubview:self.theSecondModuleView];
    [self.theSecondModuleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.theFirstModuleView.mas_bottom).offset(42);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(220);
    }];
    
    UILabel *choiceGoodLabel = [GUIHelper getLabel:@"精选大促" andFont:TXT_SIZE_15 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [self.theSecondModuleView addSubview:choiceGoodLabel];
    [choiceGoodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.theSecondModuleView.mas_top).offset(21);
        make.left.equalTo(self.theSecondModuleView.mas_left).offset(12);
    }];
    
    UILabel *hotLabel = [GUIHelper getLabel:@"各种优惠为您撑腰" andFont:TXT_SIZE_11 andTextColor:[UIColor colorWithHexStr:@"#a4a4a4"]];
    [self.theSecondModuleView addSubview:hotLabel];
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(choiceGoodLabel);
        make.left.equalTo(choiceGoodLabel.mas_right).offset(18);
    }];
    
    self.secondMoreBtn = [GUIHelper getButtonWithImage:[UIImage imageNamed:@"left_more"]];
    [self.secondMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
    self.secondMoreBtn.titleLabel.font = TXT_SIZE_14;
    [self.secondMoreBtn setTitleColor:BG_Nav forState:UIControlStateNormal];
    [self.theSecondModuleView addSubview:self.secondMoreBtn];
    [self.secondMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(choiceGoodLabel);
        make.right.mas_equalTo(self.theSecondModuleView.mas_right).offset(-14);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    [self.secondMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.firstMoreBtn.imageView.sz_size.width, 0, self.firstMoreBtn.imageView.sz_size.width)];
    [self.secondMoreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.firstMoreBtn.titleLabel.bounds.size.width+10, 0, -self.firstMoreBtn.titleLabel.bounds.size.width)];
    [self.secondMoreBtn addTarget:self action:@selector(firstBtnClickMore:) forControlEvents:UIControlEventTouchUpInside];
    self.secondMoreBtn.tag = 2;
    
    UIImageView *leftImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"1"]];
    leftImv.tag = 1;
    [self.theSecondModuleView addSubview:leftImv];
    [leftImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(choiceGoodLabel.mas_bottom).offset(12);
        make.left.equalTo(self.theSecondModuleView.mas_left).offset(18);
        make.width.mas_equalTo(W(160));
        make.height.mas_equalTo(H(180));
    }];
    [self addGestureRecognizer:leftImv];
    
    UIImageView *rightTopImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"2"]];
    rightTopImv.tag = 2;
    [self.theSecondModuleView addSubview:rightTopImv];
    [rightTopImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImv);
        make.right.equalTo(self.theSecondModuleView.mas_right).offset(-18);
        make.width.mas_equalTo(W(160));
        make.height.mas_equalTo(H(350/4));
    }];
    [self addGestureRecognizer:rightTopImv];
    
    UIImageView *rightBottomImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"3"]];
    rightBottomImv.tag = 3;
    [self.theSecondModuleView addSubview:rightBottomImv];
    [rightBottomImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightTopImv.mas_bottom).offset(5);
        make.right.equalTo(self.theSecondModuleView.mas_right).offset(-18);
        make.width.mas_equalTo(W(160));
        make.height.mas_equalTo(H(350/4));
    }];
    [self addGestureRecognizer:rightBottomImv];
}

- (void)addGestureRecognizer:(UIImageView *)imv {
    
    imv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [imv addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer addTarget:self action:@selector(jumpToActivityDetail:)];
}

- (void)jumpToActivityDetail:(UITapGestureRecognizer *)tap {
    
    NSString *urlPath = @"";
    if (tap.self.view.tag == 1) {
        urlPath = @"https://line.xwiht.cn/TAS/imgs/1537764674785SJ-WDXY-DT.png";
    } else if (tap.self.view.tag == 2) {
        urlPath = @"https://line.xwiht.cn/TAS/imgs/1538131096501SJ-APP-DT.png";
    } else if (tap.self.view.tag == 3) {
        urlPath = @"https://line.xwiht.cn/TAS/imgs/1537071321966JS-RFL-DT.png";
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
        [self presentViewController:browser animated:NO completion:nil];
    }
}

- (void)initAlertView {
    
    self.alertAdView = [[UIView alloc] init];
    [self.contentView addSubview:self.alertAdView];
    [self.alertAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.cycleScrollView3.mas_bottom);
        make.height.mas_equalTo(H(40));
    }];
    
    UIImageView *noticeImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"icon_notice"]];
    [self.alertAdView addSubview:noticeImv];
    [noticeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertAdView.mas_left).offset(4);
        make.centerY.equalTo(self.alertAdView.mas_centerY).offset(-4);
        make.height.width.mas_equalTo(H(20));
    }];
    
    UIView *lineView = [GUIHelper getViewWithColor:[UIColor colorWithHexStr:@"#efeff4"]];
    [self.alertAdView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.alertAdView);
        make.height.mas_equalTo(9);
    }];
    
    self.bannerTableView = [[UITableView alloc] init];
    [self.alertAdView addSubview:self.bannerTableView];
    [self.bannerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.alertAdView);
        make.bottom.equalTo(self.alertAdView.mas_bottom).offset(-9);
        make.left.equalTo(noticeImv.mas_right).offset(6);
    }];
    self.bannerTableView.delegate = self;
    self.bannerTableView.dataSource = self;
    self.bannerTableView.separatorInset = UIEdgeInsetsZero;
    self.bannerTableView.estimatedRowHeight = 0;
    self.bannerTableView.rowHeight = UITableViewAutomaticDimension;
    [self.bannerTableView registerClass:[VerticalBannerCell class] forCellReuseIdentifier:VerticalBannerCell.cellId];
    self.bannerTableView.backgroundColor = [UIColor greenColor];
}

- (void)initScrollViewImgV {
    
    self.containerScrollView = [[UIScrollView alloc] init];
    self.containerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, H(150));
    [self.contentView addSubview:self.containerScrollView];
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(H(150));
    }];

    SDCycleScrollView *cycleScrollView3 = [[SDCycleScrollView alloc] init];
    self.cycleScrollView3 = cycleScrollView3;
    cycleScrollView3.delegate = self;
    cycleScrollView3.currentPageDotColor = [UIColor whiteColor];
    [self.containerScrollView addSubview:cycleScrollView3];
    [cycleScrollView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(H(150));
    }];
}

#pragma mark -—————————— UITableView Delegate And DataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VerticalBannerCell* cell = [tableView dequeueReusableCellWithIdentifier:[VerticalBannerCell cellId] ];
    self.cell = cell;
    if (!cell) {
        cell = [[VerticalBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[VerticalBannerCell cellId]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
