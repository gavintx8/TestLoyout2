//
//  GCategoryVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/28.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GCategoryVc.h"
#import "GTableView.h"
#import "GLeftTableviewCell.h"
#import "GRightTableViewCell.h"
#import "GNewActivityVc.h"
#import "GLotteryVc.h"
#import "GOpenAccountVc.h"
#import "GTransferAccounts.h"
#import "GHelpVc.h"
#import "GEEContainerVc.h"

static NSString * const kIdentifer = @"LEFTTABLEVIEWCELL";
static NSString * const kRidentifer = @"RIGHTTABLEVIEWCELL";


@interface GCategoryVc ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) GTableView *oneTableView;
@property (nonatomic, strong) GTableView *twoTableView;

@property (nonatomic, copy) NSMutableArray *oneDataArray;
@property (nonatomic, copy) NSMutableArray *twoDataArray;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) GLeftTableviewCell *gLeftTableviewCell;
@property (nonatomic, strong) GRightTableViewCell *gRightTableViewCell;

@property (nonatomic, assign) NSInteger leftCurrentIndex;
@property (nonatomic, assign) NSInteger qpFlag;
@property (nonatomic, assign) NSInteger qpTypeFlag;
@end

@implementation GCategoryVc

- (void)onCreate {
    
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(jumpToCategory:) name:@"jumpToCategory" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(jumpToCategory2:) name:@"jumpToCategoryKYQP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(jumpToCategory3:) name:@"jumpToCategoryAGQP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(jumpToCategory4:) name:@"jumpToCategoryTY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(jumpToCategory5:) name:@"jumpToCategoryQP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self   selector:@selector(jumpToCategory6:) name:@"jumpToCategoryDZ" object:nil];
    
    self.navigationItem.title = TABBAR_CATEGORY;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createUI];
}



- (void)onWillShow {

    self.twoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"leftCurrentIndex"] != nil) {
        self.leftCurrentIndex = [[userDefaults objectForKey:@"leftCurrentIndex"] intValue];
        
        if(self.leftCurrentIndex == 0){
            [self jumpToCategory:nil];
        }else if(self.leftCurrentIndex == 1){
            [self jumpToCategory6:nil];
        }else  if(self.leftCurrentIndex == 3){
            [self jumpToCategory5:nil];
        }else if(self.leftCurrentIndex == 301){
            [self jumpToCategory2:nil];
        }else if(self.leftCurrentIndex == 302){
            [self jumpToCategory3:nil];
        }else if(self.leftCurrentIndex == 4){
            [self jumpToCategory4:nil];
        }
    }
}

- (void)onWillDisappear {
    
}

- (void)onDidAppear {
    
}

- (void)createUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _oneDataArray = [NSMutableArray array];
    _twoDataArray = [NSMutableArray array];
    
    self.oneTableView = [[GTableView alloc] initWithFrame:CGRectMake(0, 0, 77, SCREEN_HEIGHT)];
    self.oneTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.oneTableView];
    
    if(KIsiPhoneX){
        self.twoTableView = [[GTableView alloc] initWithFrame:CGRectMake(77, 0, SCREEN_WIDTH-77, SCREEN_HEIGHT-170)];
    }else{
        self.twoTableView = [[GTableView alloc] initWithFrame:CGRectMake(77, 0, SCREEN_WIDTH-77, SCREEN_HEIGHT-110)];
    }
    self.twoTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.twoTableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-77, 50)];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    self.twoTableView.tableFooterView = footerView;
    
    self.oneTableView.cellHeight = 55;
    self.twoTableView.cellHeight = 85;
    
    [self loadData];
    [self loadData1:0];
    
    [self.oneTableView clickCellWithBlock:^(NSIndexPath *index) {
        self.leftCurrentIndex = index.row;
        
        if (index.row == 2) {
            GLotteryVc *gLotteryVc = [[GLotteryVc alloc] init];
            [self.navigationController pushViewController:gLotteryVc animated:YES];
        } else if(index.row == 5) {
            // 优惠
            GNewActivityVc *gNewActivityVc = [[GNewActivityVc alloc] init];
            [self.navigationController pushViewController:gNewActivityVc animated:NO];
        } else if (index.row == 6) {
            GHelpVc *helpVc = [[GHelpVc alloc] init];
            helpVc.navTitle = @"帮助中心";
            [self.navigationController pushViewController:helpVc animated:YES];
        } else if (index.row == 7) {
            GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
            gOpenAccountVc.navTitle = @"关于我们";
            gOpenAccountVc.htmlName = @"about.html";
            [self.navigationController pushViewController:gOpenAccountVc animated:YES];
        } else {
            NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.twoTableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)index.row] forKey:@"leftCurrentIndex"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self loadData1:index.row];
            
            GLeftTableviewCell *cell = [self.oneTableView cellForRowAtIndexPath:index];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            [cell.label setTextColor:BG_Nav];
            [cell.lineView setBackgroundColor:BG_Nav];
        }
    }];
    
    [self.twoTableView clickCellWithBlock:^(NSIndexPath *index) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
            if(self.leftCurrentIndex == 1){
                if (index.row == 0) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"SW电子";
                    geeConVc.geeType = GEETypeSW;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                } else if (index.row == 2) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"MG电子";
                    geeConVc.geeType = GEETypeMG;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                } else if (index.row == 3) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"HABA电子";
                    geeConVc.geeType = GEETypeHB;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                } else if (index.row == 7) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"PS电子";
                    geeConVc.geeType = GEETypePS;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                }else if (index.row == 8) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"JDB电子";
                    geeConVc.geeType = GEETypeJDB;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                }else{
                    GLoginVC *gLogin = [[GLoginVC alloc] init];
                    [self presentViewController:gLogin animated:YES completion:nil];
                }
            }else if (self.leftCurrentIndex == 3 || self.leftCurrentIndex == 301 || self.leftCurrentIndex == 302) {
                
                NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
                NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
                
                if(self.qpFlag == 0){
                    [self.twoDataArray removeAllObjects];
                    // 棋牌
                    if (0 == index.row) {
                        
                        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                        
                        NSArray *arr = [dataArrs objectAtIndex:0];
                        for (int i=0;i<arr.count ; i++) {
                            NSDictionary *dict = [arr objectAtIndex:i];
                            [gamePicArray addObject:[dict objectForKey:@"image"]];
                            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                        }
                        
                        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                        self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        self.qpTypeFlag = 0;
                    } else if (index.row == 1) {
                        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                        
                        NSArray *arr = [dataArrs objectAtIndex:1];
                        for (int i=0;i<arr.count ; i++) {
                            NSDictionary *dict = [arr objectAtIndex:i];
                            [gamePicArray addObject:[dict objectForKey:@"image"]];
                            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                        }
                        
                        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                        self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        self.qpTypeFlag = 1;
                    }else if (index.row == 2) {
                        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                        
                        NSArray *arr = [dataArrs objectAtIndex:2];
                        for (int i=0;i<arr.count ; i++) {
                            NSDictionary *dict = [arr objectAtIndex:i];
                            [gamePicArray addObject:[dict objectForKey:@"image"]];
                            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                        }
                        
                        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                        self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        self.qpTypeFlag = 2;
                    }
                    self.qpFlag = 1;
                }
                else{
                    GLoginVC *gLogin = [[GLoginVC alloc] init];
                    [self presentViewController:gLogin animated:YES completion:nil];
                }
            }else{
                GLoginVC *gLogin = [[GLoginVC alloc] init];
                [self presentViewController:gLogin animated:YES completion:nil];
            }
        } else {
            NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"CategoryList" ofType:@"plist"];
            NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
            
            GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
            gTransferAccounts.leftindex = self.leftCurrentIndex;
            if (0 == self.leftCurrentIndex) {
                // 真人
                NSArray *arr = [dataArrs objectAtIndex:0];
                
                gTransferAccounts.platformName = [[arr objectAtIndex:index.row] objectForKey:@"platformName"];
                gTransferAccounts.gameType = [[arr objectAtIndex:index.row] objectForKey:@"gameType"];
                gTransferAccounts.gameID = [[arr objectAtIndex:index.row] objectForKey:@"gameID"];
                gTransferAccounts.fromName = [[arr objectAtIndex:index.row] objectForKey:@"fromName"];
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            } else if (self.leftCurrentIndex== 1) {
                // 电子
                NSArray *arr = [dataArrs objectAtIndex:1];
                if (1 == index.row || index.row == 4|| index.row == 5|| index.row == 6) {
                    
                    gTransferAccounts.platformName = [[arr objectAtIndex:index.row] objectForKey:@"platformName"];
                    gTransferAccounts.gameType = [[arr objectAtIndex:index.row] objectForKey:@"gameType"];
                    gTransferAccounts.gameID = [[arr objectAtIndex:index.row] objectForKey:@"gameID"];
                    gTransferAccounts.fromName = [[arr objectAtIndex:index.row] objectForKey:@"fromName"];
                    [self.navigationController pushViewController:gTransferAccounts animated:YES];
                } else if (index.row == 0) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"SW电子";
                    geeConVc.geeType = GEETypeSW;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                } else if (index.row == 2) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"MG电子";
                    geeConVc.geeType = GEETypeMG;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                } else if (index.row == 3) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"HABA电子";
                    geeConVc.geeType = GEETypeHB;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                } else if (index.row == 7) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"PS电子";
                    geeConVc.geeType = GEETypePS;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                }else if (index.row == 8) {
                    GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                    geeConVc.navTitle = @"JDB电子";
                    geeConVc.geeType = GEETypeJDB;
                    [self.navigationController pushViewController:geeConVc animated:YES];
                }
            } else if (self.leftCurrentIndex == 4) {
                //体育
                NSArray *arr = [dataArrs objectAtIndex:2];
                
                gTransferAccounts.platformName = [[arr objectAtIndex:index.row] objectForKey:@"platformName"];
                gTransferAccounts.gameType = [[arr objectAtIndex:index.row] objectForKey:@"gameType"];
                gTransferAccounts.gameID = [[arr objectAtIndex:index.row] objectForKey:@"gameID"];
                gTransferAccounts.fromName = [[arr objectAtIndex:index.row] objectForKey:@"fromName"];
                [self.navigationController pushViewController:gTransferAccounts animated:YES];
            } else if (self.leftCurrentIndex == 3 || self.leftCurrentIndex == 301 || self.leftCurrentIndex == 302) {
                
                NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
                NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
                
                if(self.qpFlag == 0){
                    [self.twoDataArray removeAllObjects];
                    // 棋牌
                    if (0 == index.row) {
                        
                        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                        
                        NSArray *arr = [dataArrs objectAtIndex:0];
                        for (int i=0;i<arr.count ; i++) {
                            NSDictionary *dict = [arr objectAtIndex:i];
                            [gamePicArray addObject:[dict objectForKey:@"image"]];
                            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                        }
                        
                        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                        self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        self.qpTypeFlag = 0;
                    } else if (index.row == 1) {
                        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                        
                        NSArray *arr = [dataArrs objectAtIndex:1];
                        for (int i=0;i<arr.count ; i++) {
                            NSDictionary *dict = [arr objectAtIndex:i];
                            [gamePicArray addObject:[dict objectForKey:@"image"]];
                            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                        }
                        
                        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                        self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        self.qpTypeFlag = 1;
                    }else if (index.row == 2) {
                        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                        
                        NSArray *arr = [dataArrs objectAtIndex:2];
                        for (int i=0;i<arr.count ; i++) {
                            NSDictionary *dict = [arr objectAtIndex:i];
                            [gamePicArray addObject:[dict objectForKey:@"image"]];
                            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                        }
                        
                        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                        self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                        self.qpTypeFlag = 2;
                    }
                    self.qpFlag = 1;
                }
                else{
                    GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                    NSArray *arr = [dataArrs objectAtIndex:self.qpTypeFlag];
                    NSDictionary *dict = [arr objectAtIndex:index.row];
                    gTransferAccounts.platformName = [dict objectForKey:@"platformName"];
                    gTransferAccounts.gameType = [dict objectForKey:@"gameType"];
                    gTransferAccounts.gameID = [dict objectForKey:@"gameID"];
                    gTransferAccounts.fromName = [dict objectForKey:@"fromName"];
                    [self.navigationController pushViewController:gTransferAccounts animated:YES];
                }
            }
        }
    }];
}

- (void)loadData{
    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@"真人",@"电子",@"彩票",@"棋牌",@"体育",@"优惠",@"帮助",@"关于", nil];
    for (int i = 0; i < 8; i++) {
        GLeftTableviewCell *cell = [self.oneTableView dequeueReusableCellWithIdentifier:kIdentifer];
        if (!cell) {
            cell = [[GLeftTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifer];
        }
        cell.label.text = ary[i];
        [_oneDataArray addObject:cell];
    }
    [self.oneTableView setUpTheDataSourceWithArray:_oneDataArray];
}

- (void)loadData1:(NSInteger)inte{
    [_twoDataArray removeAllObjects];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"CategoryList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    if (0 == inte) {
        //真人
        NSMutableArray *personPicArray = [[NSMutableArray alloc] init];
        NSMutableArray *personLabel1Array = [[NSMutableArray alloc] init];
        NSMutableArray *personLabel2Array = [[NSMutableArray alloc] init];
        
        NSArray *arr = [dataArrs objectAtIndex:0];
        for (int i=0;i<arr.count ; i++) {
            NSDictionary *dict = [arr objectAtIndex:i];
            [personPicArray addObject:[dict objectForKey:@"image"]];
            [personLabel1Array addObject:[dict objectForKey:@"title"]];
            [personLabel2Array addObject:[dict objectForKey:@"secondtitle"]];
        }
        
        [self setupTableViewCell:arr.count picAry:personPicArray title1Ary:personLabel1Array title2Ary:personLabel2Array];
    } else if (1 == inte) {
        // 电子
        NSMutableArray *electricPicArray = [[NSMutableArray alloc] init];
        NSMutableArray *electricLabel1Array = [[NSMutableArray alloc] init];
        
        NSArray *arr = [dataArrs objectAtIndex:1];
        for (int i=0;i<arr.count ; i++) {
            NSDictionary *dict = [arr objectAtIndex:i];
            [electricPicArray addObject:[dict objectForKey:@"image"]];
            [electricLabel1Array addObject:[dict objectForKey:@"title"]];
        }
        
        [self setupTableViewCell:arr.count picAry:electricPicArray title1Ary:electricLabel1Array title2Ary:nil];
    } else if (4 == inte) {
        // 体育
        NSMutableArray *sportsPicArray = [[NSMutableArray alloc] init];
        NSMutableArray *sportsLabel1Array = [[NSMutableArray alloc] init];
        NSMutableArray *sportsLabel2Array = [[NSMutableArray alloc] init];
        
        NSArray *arr = [dataArrs objectAtIndex:2];
        for (int i=0;i<arr.count;i++) {
            NSDictionary *dict = [arr objectAtIndex:i];
            [sportsPicArray addObject:[dict objectForKey:@"image"]];
            [sportsLabel1Array addObject:[dict objectForKey:@"title"]];
            [sportsLabel2Array addObject:[dict objectForKey:@"secondtitle"]];
        }
        
        [self setupTableViewCell:arr.count picAry:sportsPicArray title1Ary:sportsLabel1Array title2Ary:sportsLabel2Array];
    } else if (2 == inte) {
        // 彩票
    } else if (3 == inte) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
        NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        // 棋牌
        NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
        NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
        
        NSArray *arr = [dataArrs objectAtIndex:3];
        for (int i=0;i<arr.count ; i++) {
            NSDictionary *dict = [arr objectAtIndex:i];
            [gamePicArray addObject:[dict objectForKey:@"image"]];
            [gameLabel1Array addObject:[dict objectForKey:@"title"]];
        }
        
        [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
        self.qpFlag = 0;
    } else if (5 == inte) {
        //优惠
    } else if (6 == inte) {
        // 帮助
    } else if (7 == inte) {
        // 关于
    }
    [self.twoTableView setUpTheDataSourceWithArray:_twoDataArray];
}

- (void)setupTableViewCell:(NSInteger )inte picAry:(NSMutableArray *)picAry title1Ary:(NSMutableArray *)title1Ary title2Ary:(NSMutableArray *)title2Ary {
    for (int i = 0; i < inte; i++) {
        
        GRightTableViewCell *cell = [self.twoTableView dequeueReusableCellWithIdentifier:kRidentifer];
        if (!cell) {
            cell = [[GRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRidentifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imv1.image = [UIImage imageNamed:picAry[i]];
        cell.enterGameButton.tag = i;
        if (title1Ary.count != 0) {
            cell.label1.text = title1Ary[i];
        }
        
        if (title1Ary != nil ) {
            cell.label2.text = title2Ary[i];
        }
        
        [_twoDataArray addObject:cell];
        
        
        [cell clickEnterGameWithBlock:^(NSInteger index) {
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
                if(self.leftCurrentIndex == 1){
                    if (index == 0) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"SW电子";
                        geeConVc.geeType = GEETypeSW;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    } else if (index == 2) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"MG电子";
                        geeConVc.geeType = GEETypeMG;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    } else if (index == 3) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"HABA电子";
                        geeConVc.geeType = GEETypeHB;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    } else if (index == 7) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"PS电子";
                        geeConVc.geeType = GEETypePS;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    }else if (index == 8) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"JDB电子";
                        geeConVc.geeType = GEETypeJDB;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    }else{
                        GLoginVC *gLogin = [[GLoginVC alloc] init];
                        [self presentViewController:gLogin animated:YES completion:nil];
                    }
                }else if (self.leftCurrentIndex == 3) {
                    
                    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
                    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
                    
                    if(self.qpFlag == 0){
                        [self.twoDataArray removeAllObjects];
                        // 棋牌
                        if (0 == index) {
                            
                            NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                            NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                            
                            NSArray *arr = [dataArrs objectAtIndex:0];
                            for (int i=0;i<arr.count ; i++) {
                                NSDictionary *dict = [arr objectAtIndex:i];
                                [gamePicArray addObject:[dict objectForKey:@"image"]];
                                [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                            }
                            
                            [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                            self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                            self.qpTypeFlag = 0;
                        } else if (index == 1) {
                            NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                            NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                            
                            NSArray *arr = [dataArrs objectAtIndex:1];
                            for (int i=0;i<arr.count ; i++) {
                                NSDictionary *dict = [arr objectAtIndex:i];
                                [gamePicArray addObject:[dict objectForKey:@"image"]];
                                [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                            }
                            
                            [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                            self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                            self.qpTypeFlag = 1;
                        }else if (index == 2) {
                            NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                            NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                            
                            NSArray *arr = [dataArrs objectAtIndex:2];
                            for (int i=0;i<arr.count ; i++) {
                                NSDictionary *dict = [arr objectAtIndex:i];
                                [gamePicArray addObject:[dict objectForKey:@"image"]];
                                [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                            }
                            
                            [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                            self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                            self.qpTypeFlag = 2;
                        }
                        self.qpFlag = 1;
                    }
                    else{
                        GLoginVC *gLogin = [[GLoginVC alloc] init];
                        [self presentViewController:gLogin animated:YES completion:nil];
                    }
                }else{
                    GLoginVC *gLogin = [[GLoginVC alloc] init];
                    [self presentViewController:gLogin animated:YES completion:nil];
                }
            } else {
                NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"CategoryList" ofType:@"plist"];
                NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
                
                GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                gTransferAccounts.leftindex = self.leftCurrentIndex;
                if (0 == self.leftCurrentIndex) {
                    // 真人
                    NSArray *arr = [dataArrs objectAtIndex:0];
                    
                    gTransferAccounts.platformName = [[arr objectAtIndex:index] objectForKey:@"platformName"];
                    gTransferAccounts.gameType = [[arr objectAtIndex:index] objectForKey:@"gameType"];
                    gTransferAccounts.gameID = [[arr objectAtIndex:index] objectForKey:@"gameID"];
                    gTransferAccounts.fromName = [[arr objectAtIndex:index] objectForKey:@"fromName"];
                    [self.navigationController pushViewController:gTransferAccounts animated:YES];
                } else if (self.leftCurrentIndex== 1) {
                    // 电子
                    NSArray *arr = [dataArrs objectAtIndex:1];
                    if (1 == index || index == 4|| index == 5|| index == 6) {
                        
                        gTransferAccounts.platformName = [[arr objectAtIndex:index] objectForKey:@"platformName"];
                        gTransferAccounts.gameType = [[arr objectAtIndex:index] objectForKey:@"gameType"];
                        gTransferAccounts.gameID = [[arr objectAtIndex:index] objectForKey:@"gameID"];
                        gTransferAccounts.fromName = [[arr objectAtIndex:index] objectForKey:@"fromName"];
                        [self.navigationController pushViewController:gTransferAccounts animated:YES];
                    } else if (index == 0) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"SW电子";
                        geeConVc.geeType = GEETypeSW;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    } else if (index == 2) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"MG电子";
                        geeConVc.geeType = GEETypeMG;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    } else if (index == 3) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"HABA电子";
                        geeConVc.geeType = GEETypeHB;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    } else if (index == 7) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"PS电子";
                        geeConVc.geeType = GEETypePS;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    }else if (index == 8) {
                        GEEContainerVc *geeConVc = [[GEEContainerVc alloc] init];
                        geeConVc.navTitle = @"JDB电子";
                        geeConVc.geeType = GEETypeJDB;
                        [self.navigationController pushViewController:geeConVc animated:YES];
                    }
                } else if (self.leftCurrentIndex == 4) {
                    //体育
                    NSArray *arr = [dataArrs objectAtIndex:2];
                    
                    gTransferAccounts.platformName = [[arr objectAtIndex:index] objectForKey:@"platformName"];
                    gTransferAccounts.gameType = [[arr objectAtIndex:index] objectForKey:@"gameType"];
                    gTransferAccounts.gameID = [[arr objectAtIndex:index] objectForKey:@"gameID"];
                    gTransferAccounts.fromName = [[arr objectAtIndex:index] objectForKey:@"fromName"];
                    [self.navigationController pushViewController:gTransferAccounts animated:YES];
                } else if (self.leftCurrentIndex == 3) {
                    
                    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
                    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
                    
                    if(self.qpFlag == 0){
                        [self.twoDataArray removeAllObjects];
                        // 棋牌
                        if (0 == index) {
                            
                            NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                            NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                            
                            NSArray *arr = [dataArrs objectAtIndex:0];
                            for (int i=0;i<arr.count ; i++) {
                                NSDictionary *dict = [arr objectAtIndex:i];
                                [gamePicArray addObject:[dict objectForKey:@"image"]];
                                [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                            }
                            
                            [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                            self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                            self.qpTypeFlag = 0;
                        } else if (index == 1) {
                            NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                            NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                            
                            NSArray *arr = [dataArrs objectAtIndex:1];
                            for (int i=0;i<arr.count ; i++) {
                                NSDictionary *dict = [arr objectAtIndex:i];
                                [gamePicArray addObject:[dict objectForKey:@"image"]];
                                [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                            }
                            
                            [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                            self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                            self.qpTypeFlag = 1;
                        }else if (index == 2) {
                            NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
                            NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
                            
                            NSArray *arr = [dataArrs objectAtIndex:2];
                            for (int i=0;i<arr.count ; i++) {
                                NSDictionary *dict = [arr objectAtIndex:i];
                                [gamePicArray addObject:[dict objectForKey:@"image"]];
                                [gameLabel1Array addObject:[dict objectForKey:@"title"]];
                            }
                            
                            [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
                            self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                            self.qpTypeFlag = 2;
                        }
                        self.qpFlag = 1;
                    }
                    else{
                        GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
                        NSArray *arr = [dataArrs objectAtIndex:self.qpTypeFlag];
                        NSDictionary *dict = [arr objectAtIndex:index];
                        gTransferAccounts.platformName = [dict objectForKey:@"platformName"];
                        gTransferAccounts.gameType = [dict objectForKey:@"gameType"];
                        gTransferAccounts.gameID = [dict objectForKey:@"gameID"];
                        gTransferAccounts.fromName = [dict objectForKey:@"fromName"];
                        [self.navigationController pushViewController:gTransferAccounts animated:YES];
                    }
                }
            }
        }];
    }
    [self.twoTableView reloadData];
}

- (void)jumpToCategory:(NSNotification *)notification{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.oneTableView selectRowAtIndexPath:indexPat animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.leftCurrentIndex = 0;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"leftCurrentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self loadData1:0];
    
    [self setMenuColor:@"0"];
}

- (void)jumpToCategory2:(NSNotification *)notification{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.oneTableView selectRowAtIndexPath:indexPat animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.leftCurrentIndex = 3;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",3] forKey:@"leftCurrentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.twoDataArray removeAllObjects];
    NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
    NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSArray *arr = [dataArrs objectAtIndex:0];
    for (int i=0;i<arr.count ; i++) {
        NSDictionary *dict = [arr objectAtIndex:i];
        [gamePicArray addObject:[dict objectForKey:@"image"]];
        [gameLabel1Array addObject:[dict objectForKey:@"title"]];
    }
    [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
    self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.qpTypeFlag = 0;
    self.qpFlag = 1;
    
    [self setMenuColor:@"3"];
}

- (void)jumpToCategory3:(NSNotification *)notification{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.oneTableView selectRowAtIndexPath:indexPat animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.leftCurrentIndex = 3;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",3] forKey:@"leftCurrentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.twoDataArray removeAllObjects];
    NSMutableArray *gamePicArray = [[NSMutableArray alloc] init];
    NSMutableArray *gameLabel1Array = [[NSMutableArray alloc] init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"QPList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSArray *arr = [dataArrs objectAtIndex:1];
    for (int i=0;i<arr.count ; i++) {
        NSDictionary *dict = [arr objectAtIndex:i];
        [gamePicArray addObject:[dict objectForKey:@"image"]];
        [gameLabel1Array addObject:[dict objectForKey:@"title"]];
    }
    [self setupTableViewCell:arr.count picAry:gamePicArray title1Ary:gameLabel1Array title2Ary:nil];
    self.gRightTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.qpTypeFlag = 1;
    self.qpFlag = 1;
    
    [self setMenuColor:@"3"];
}

- (void)jumpToCategory4:(NSNotification *)notification{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:4 inSection:0];
    [self.oneTableView selectRowAtIndexPath:indexPat animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.leftCurrentIndex = 4;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",4] forKey:@"leftCurrentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self loadData1:4];
    
    [self setMenuColor:@"4"];
}

- (void)jumpToCategory5:(NSNotification *)notification{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.oneTableView selectRowAtIndexPath:indexPat animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.leftCurrentIndex = 3;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",3] forKey:@"leftCurrentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self loadData1:3];
    
    [self setMenuColor:@"3"];
}

- (void)jumpToCategory6:(NSNotification *)notification{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.oneTableView selectRowAtIndexPath:indexPat animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.leftCurrentIndex = 1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:@"leftCurrentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self loadData1:1];
    
    [self setMenuColor:@"1"];
}

- (void)setMenuColor:(NSString *)index{
    NSArray *arrs = @[@"0", @"1", @"3", @"4"];
    for(int i=0;i<arrs.count;i++){
        if([arrs[i] isEqualToString:index]){
            NSIndexPath* indexPat = [NSIndexPath indexPathForRow:index.integerValue inSection:0];
            GLeftTableviewCell *cell = [self.oneTableView cellForRowAtIndexPath:indexPat];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            [cell.label setTextColor:BG_Nav];
            [cell.lineView setBackgroundColor:BG_Nav];
        }else{
            NSString *str = arrs[i];
            NSIndexPath* indexPat = [NSIndexPath indexPathForRow:str.integerValue inSection:0];
            GLeftTableviewCell *cell = [self.oneTableView cellForRowAtIndexPath:indexPat];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = Them_Color;
            [cell.label setTextColor:[UIColor colorWithHexStr:@"#000000"]];
            [cell.lineView setBackgroundColor:Them_Color];
        }
    }
}

@end
