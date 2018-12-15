//
//  GPayVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//
#define FiltrateViewScreenW ScreenW * 1

#import "GPayVc.h"
#import "GFiltrateItem.h"
#import "GPayBankItem.h"
#import "GFooterWyView.h"
#import "GPayBankCell.h"
#import "GFooterBankHkView.h"
#import "GFooterScanView.h"
#import "GPaySuccessVc.h"
#import "ContactServiceVc2.h"
#import "GJournalAccountCapitalVc.h"
#import "GFooterEmptyView.h"
#import "GHelpTableViewVc.h"
#import "GPayBankItem.h"
#import "GPayWebVc.h"

@interface GPayVc ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* 筛选父View */
@property (strong , nonatomic)UIView *filtrateConView;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray<GFiltrateItem *> *filtrateItem;
@property (nonatomic , strong) NSMutableArray<GFiltrateItem *> *filtrateItem2;

@property (nonatomic , strong) NSString *sid;
@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSArray *typeList;
@property (nonatomic , strong) NSArray *bankList;
@property (nonatomic , strong) NSArray *channelList;

@end

static NSString *const GPayBankCellID = @"GPayBankCellID";
static NSString * const GFooterWYViewID = @"GFooterWYViewID";
static NSString * const GFooterEmptyViewID = @"GFooterEmptyViewID";
static NSString * const GFooterDepositViewID = @"GFooterDepositViewID";
static NSString * const GFooterScanViewID = @"GFooterScanViewID";

@implementation GPayVc

#pragma mark - LazyLoad

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10; //竖间距
        layout.itemSize = CGSizeMake((FiltrateViewScreenW - 6 * 5) / 2 - 15, 40);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(0, DCMargin, SCREEN_WIDTH, ScreenH);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[GPayBankCell class] forCellWithReuseIdentifier:GPayBankCellID];//cell
        [_collectionView registerClass:[GFooterWyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID];
        [_collectionView registerClass:[GFooterBankHkView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterDepositViewID];
        [_collectionView registerClass:[GFooterScanView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterScanViewID];
        [_collectionView registerClass:[GFooterEmptyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID];
    }
    return _collectionView;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 15, 0, 15);
}

- (NSMutableArray<GFiltrateItem *> *)filtrateItem
{
    if (!_filtrateItem) {
        _filtrateItem = [NSMutableArray array];
    }
    return _filtrateItem;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"存款";
    
    [self setupNav];
    
    [self setUpInit];
    self.sid = @"21";
    [self setUpFiltrateData];
    [self getPaymentChannel];
//    self.type = @"5";
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setupNav {
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"top_Back_nor"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"top_Back_pre"] forState:UIControlStateHighlighted];
    button.sz_size = CGSizeMake(70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.hidesBottomBarWhenPushed = YES;
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"存款记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = TXT_SIZE_15;
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
    self.navigationController.navigationBar.barTintColor = BG_Nav;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClick {
    GJournalAccountCapitalVc *rechargeVc = [[GJournalAccountCapitalVc alloc] init];
    [self.navigationController pushViewController:rechargeVc animated:YES];
}

- (void)loadData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            if (self.payType == GPayTypeSMZF) {
                [self.collectionView reloadData];
                [SVProgressHUD dismiss];
            }else if(self.payType == GPayTypeYHHK){
                [self getBankList];
            }else{
                [self getReChangePay];
            }
        }else{
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
            dicInfo[@"tname"] = [SZUser shareUser].readUser.userName;
            dicInfo[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
            NSString *pwd = [SZUser shareUser].readUser.password;
            dicInfo[@"tpwd"] = pwd;
            dicInfo[@"savelogin"] = @"1";
            dicInfo[@"isImgCode"] = @"0";
            
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kLogin RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                SZUser *user = [SZUser shareUser];
                if ([responseObject[@"status"] isEqualToString:@"ok"]) {
                    
                    user.userKey = responseObject[@"userKey"];
                    user.userName = responseObject[@"userName"];
                    if (responseObject[@"balance"] == nil) {
                        user.balance = @"0.00";
                    } else {
                        user.balance = responseObject[@"balance"];
                        [[SZUser shareUser] saveBalance2:[NSString stringWithFormat:@"%@",responseObject[@"balance"]]];
                    }
                    user.integral = responseObject[@"integral"];
                    user.password = pwd;
                    [[SZUser shareUser] deleteUser];
                    [[SZUser shareUser] saveLogin];
                    [[SZUser shareUser] saveUser];
                    
                    if (self.payType == GPayTypeSMZF) {
                        [self.collectionView reloadData];
                        [SVProgressHUD dismiss];
                    }else if(self.payType == GPayTypeYHHK){
                        [self getBankList];
                    }else{
                        [self getReChangePay];
                    }
                    
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)getPaymentChannel{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            NSMutableDictionary *dicCh = [NSMutableDictionary dictionary];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kPaymentChannel RequestWay:kPOST withParamters:dicCh withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                if (responseObject == nil) {
                    self.status = @"error";
                }else{
                    self.channelList = responseObject[@"MBchannel"];
                    self.filtrateItem2 = [[NSMutableArray<GFiltrateItem *> alloc] init];
                    NSMutableArray<GPayBankItem *> *contentPay = [[NSMutableArray<GPayBankItem *> alloc] init];
                    for(int i = 0;i < self.channelList.count;i++){
                        for(int j = 0;j < self.filtrateItem[0].content.count;j++){
                            GPayBankItem *item = self.filtrateItem[0].content[j];
                            if ([[NSString stringWithFormat:@"%@",self.channelList[i]] isEqualToString:item.sid]) {
                                [contentPay addObject:item];
                            }
                        }
                    }
                    GFiltrateItem *gitem = [[GFiltrateItem alloc] init];
                    gitem.content = [contentPay copy];
                    [self.filtrateItem2 addObject:gitem];
                    if (self.filtrateItem2.count > 0) {
                        self.filtrateItem2[0].content[0].isSelect = YES;
                        self.type = self.filtrateItem2[0].content[0].type;
                        self.sid = self.filtrateItem2[0].content[0].sid;
                        NSString *sid = self.filtrateItem2[0].content[0].sid;
                        if ([sid isEqualToString:@"22"]) {
                            [self.collectionView reloadData];
                            [SVProgressHUD dismiss];
                        }else if([sid isEqualToString:@"28"]){
                            [self getBankList];
                        }else{
                            [self getReChangePay];
                        }
                    }
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }else{
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
            dicInfo[@"tname"] = [SZUser shareUser].readUser.userName;
            dicInfo[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
            NSString *pwd = [SZUser shareUser].readUser.password;
            dicInfo[@"tpwd"] = pwd;
            dicInfo[@"savelogin"] = @"1";
            dicInfo[@"isImgCode"] = @"0";
            
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kLogin RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                SZUser *user = [SZUser shareUser];
                if ([responseObject[@"status"] isEqualToString:@"ok"]) {
                    
                    user.userKey = responseObject[@"userKey"];
                    user.userName = responseObject[@"userName"];
                    if (responseObject[@"balance"] == nil) {
                        user.balance = @"0.00";
                    } else {
                        user.balance = responseObject[@"balance"];
                        [[SZUser shareUser] saveBalance2:[NSString stringWithFormat:@"%@",responseObject[@"balance"]]];
                    }
                    user.integral = responseObject[@"integral"];
                    user.password = pwd;
                    [[SZUser shareUser] deleteUser];
                    [[SZUser shareUser] saveLogin];
                    [[SZUser shareUser] saveUser];
                    
                    NSMutableDictionary *dicCh = [NSMutableDictionary dictionary];
                    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kPaymentChannel RequestWay:kPOST withParamters:dicCh withToken:nil success:^(BOOL isSuccess, id responseObject) {
                        
                        if (responseObject == nil) {
                            self.status = @"error";
                        }else{
                            self.channelList = responseObject[@"MBchannel"];
                            self.filtrateItem2 = [[NSMutableArray<GFiltrateItem *> alloc] init];
                            NSMutableArray<GPayBankItem *> *contentPay = [[NSMutableArray<GPayBankItem *> alloc] init];
                            for(int i = 0;i < self.channelList.count;i++){
                                for(int j = 0;j < self.filtrateItem[0].content.count;j++){
                                    GPayBankItem *item = self.filtrateItem[0].content[j];
                                    if ([[NSString stringWithFormat:@"%@",self.channelList[i]] isEqualToString:item.sid]) {
                                        [contentPay addObject:item];
                                    }
                                }
                            }
                            GFiltrateItem *gitem = [[GFiltrateItem alloc] init];
                            gitem.content = [contentPay copy];
                            [self.filtrateItem2 addObject:gitem];
                            if (self.filtrateItem2.count > 0) {
                                self.filtrateItem2[0].content[0].isSelect = YES;
                                self.type = self.filtrateItem2[0].content[0].type;
                                self.sid = self.filtrateItem2[0].content[0].sid;
                                NSString *sid = self.filtrateItem2[0].content[0].sid;
                                if ([sid isEqualToString:@"22"]) {
                                    [self.collectionView reloadData];
                                    [SVProgressHUD dismiss];
                                }else if([sid isEqualToString:@"28"]){
                                    [self getBankList];
                                }else{
                                    [self getReChangePay];
                                }
                            }
                        }
                    } failure:^(NSError *error) {
                        [SVProgressHUD showErrorWithStatus:kNetError];
                    }];
                    
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)getReChangePay{
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    dicInfo[@"type"] = self.type;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetPlatformPay RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"error"]) {
            self.status = @"error";
        }else{
            self.status = @"success";
            self.typeList = responseObject[@"typeList"];
        }
        
        [self.collectionView reloadData];
        [[self.collectionView collectionViewLayout] invalidateLayout];
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)getBankList{
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    dicInfo[@"type"] = self.type;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBankList RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if (responseObject == nil) {
            self.status = @"error";
        }else{
            self.status = @"success";
            self.bankList = responseObject;
        }
        
        [self.collectionView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

#pragma mark - initialize
- (void)setUpInit
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    _filtrateConView = [UIView new];
    _filtrateConView.backgroundColor = [UIColor whiteColor];
    
    _filtrateConView.frame = CGRectMake(0, 55, FiltrateViewScreenW, ScreenH);
    [self.view addSubview:_filtrateConView];
    
    [_filtrateConView addSubview:self.collectionView];
}

#pragma mark - 筛选Item数据
- (void)setUpFiltrateData
{
    _filtrateItem = [GFiltrateItem mj_objectArrayWithFilename:@"FiltrateItem.plist"];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.filtrateItem2[0].content.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPayBankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPayBankCellID forIndexPath:indexPath];
    
    if([_filtrateItem2[0].content[indexPath.row].type isEqualToString:@"14"]){
        cell.iv.hidden = YES;
    }else{
        cell.iv.hidden = YES;
    }
    cell.contentItem = _filtrateItem2[0].content[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        
        return nil;
    }else {
        
        switch ([self.sid intValue]) {
            case 21:{
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                        NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                        gPaywebVc.htmlcontent = html;
                        gPaywebVc.navTitle = @"网银支付";
                        [self.navigationController pushViewController:gPaywebVc animated:YES];
                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"WYZF" and:@"WYZF"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 27: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"银联扫码";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }

                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"yl" and:@"YLSM"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 23: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"微信支付";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }
                        
                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"wx" and:@"WXZF"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 24: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"支付宝支付";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }
                    
                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"ali" and:@"ZFBZF"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 25: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"财付通支付";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }
                        
                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"cft" and:@"CFTZF"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 26: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"京东支付";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }
                        
                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"jd" and:@"JDZF"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 22:{
                GFooterScanView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterScanViewID forIndexPath:indexPath];
                footerView.clikeCall = ^(NSInteger tag) {
                    ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                    [self.navigationController pushViewController:csVc animated:YES];
                };
                footerView.clikeNextCall = ^(NSDictionary *dict) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"提交成功！如有疑问，请及时联系在线客服确认存款信息，谢谢！" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"联系在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertController addAction:okAction];
                    [alertController addAction:cancelAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                };
                footerView.clikeHelpCall = ^(NSString *value) {
                    GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                    tbCtl.helpType = GHelpTypeDeposit;
                    tbCtl.navTitle = @"存款流程";
                    [self.navigationController pushViewController:tbCtl animated:YES];
                };
                return footerView;
            }
            case 28:{
                GFooterBankHkView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterDepositViewID forIndexPath:indexPath];
                footerView.clikeCall = ^(NSInteger tag) {
                    ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                    [self.navigationController pushViewController:csVc animated:YES];
                };
                footerView.clikeNextCall = ^(NSString *ref_id,NSString *amount) {
                    GPaySuccessVc *successVc = [[GPaySuccessVc alloc] init];
                    successVc.ref_id = ref_id;
                    successVc.amount = amount;
                    if(self.bankList.count > 0){
                        NSDictionary *dict = self.bankList[0];
                        successVc.bankDict = dict;
                    }
                    [self.navigationController pushViewController:successVc animated:YES];
                };
                footerView.clikeHelpCall = ^(NSString *value) {
                    GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                    tbCtl.helpType = GHelpTypeDeposit;
                    tbCtl.navTitle = @"存款流程";
                    [self.navigationController pushViewController:tbCtl animated:YES];
                };
                return footerView;
            }
                break;
            case 29: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"快捷支付";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }

                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"kj" and:@"KJZF"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 30: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"微信条码";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }

                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"wxtm" and:@"WXTM"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
            case 31: {
                if ([self.status isEqualToString:@"success"]) {
                    GFooterWyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterWYViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    footerView.clikeNextCall = ^(NSDictionary *dict) {
                        
                        if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"1"]){
                            GPayWebVc *gPaywebVc = [[GPayWebVc alloc] init];
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            gPaywebVc.htmlcontent = html;
                            gPaywebVc.navTitle = @"支付宝条码";
                            [self.navigationController pushViewController:gPaywebVc animated:YES];
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"2"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qrcode"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }else if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"res_type"]] isEqualToString:@"4"]){
                            NSString *html = [NSString stringWithFormat:@"%@",[dict objectForKey:@"html"]];
                            if (@available(iOS 10.0, *)) {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:html] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                                }];
                            } else {}
                        }
                        
                    };
                    footerView.clikeHelpCall = ^(NSString *value) {
                        GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
                        tbCtl.helpType = GHelpTypeDeposit;
                        tbCtl.navTitle = @"存款流程";
                        [self.navigationController pushViewController:tbCtl animated:YES];
                    };
                    [footerView updateTypeList:self.typeList and:@"alitm" and:@"ZFBTM"];
                    return footerView;
                }else{
                    GFooterEmptyView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterEmptyViewID forIndexPath:indexPath];
                    footerView.clikeCall = ^(NSInteger tag) {
                        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
                        [self.navigationController pushViewController:csVc animated:YES];
                    };
                    
                    if([self.status isEqualToString:@"error"]){
                        [footerView setHidden:NO];
                    }else{
                        [footerView setHidden:YES];
                    }
                    
                    return footerView;
                }
            }
                break;
        }
        return nil;
    }
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.status = @"";
    [self.collectionView reloadData];
    for (NSInteger j = 0; j < _filtrateItem2[0].content.count; j++) {
        if (indexPath.row == j) {
            _filtrateItem2[0].content[j].isSelect = YES;
        }else{
            _filtrateItem2[0].content[j].isSelect = NO;
        }
    }
    self.type = _filtrateItem2[0].content[indexPath.row].type;
    self.sid = _filtrateItem2[0].content[indexPath.row].sid;
    switch ([_filtrateItem2[0].content[indexPath.row].sid intValue]) {
        case 21:{
            self.payType = GPayTypeWYZF;
        }
            break;
        case 27:{
            self.payType = GPayTypeYLSM;
        }
            break;
        case 23:{
            self.payType = GPayTypeWXZF;
        }
            break;
        case 24:{
            self.payType = GPayTypeZFBZF;
        }
            break;
        case 25:{
            self.payType = GPayTypeCFTZF;
        }
            break;
        case 26:{
            self.payType = GPayTypeJDZF;
        }
            break;
        case 22:{
            self.payType = GPayTypeSMZF;
            [_collectionView registerClass:[GFooterScanView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterScanViewID];
        }
            break;
        case 28:{
            self.payType = GPayTypeYHHK;
            [_collectionView registerClass:[GFooterBankHkView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFooterDepositViewID];
        }
            break;
        case 29:{
            self.payType = GPayTypeKJZF;
        }
            break;
        case 30:{
            self.payType = GPayTypeWXTM;
        }
            break;
        case 31:{
            self.payType = GPayTypeZFBTM;
        }
            break;
    }
    [self loadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    switch (self.payType) {
        case GPayTypeWYZF:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeYLSM:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeWXZF:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeZFBZF:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeCFTZF:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeJDZF:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeSMZF:
            return CGSizeMake(self.collectionView.dc_width, 680);
            break;
        case GPayTypeYHHK:
            return CGSizeMake(self.collectionView.dc_width, 650);
            break;
        case GPayTypeKJZF:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeWXTM:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
        case GPayTypeZFBTM:
            return CGSizeMake(self.collectionView.dc_width, 600);
            break;
    }
}

@end
