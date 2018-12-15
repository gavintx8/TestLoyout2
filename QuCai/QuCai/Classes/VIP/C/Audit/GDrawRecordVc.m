//
//  GDrawRecordVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDrawRecordVc.h"
#import "GFilterDrawView.h"
#import "GDrawModel.h"
#import "GDrawCell.h"

static NSString *const  kGDrawCell = @"kGDrawCell";

@interface GDrawRecordVc ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic,weak) GFilterDrawView *filterView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *bdateString;
@property (nonatomic, strong) NSString *edateString;
@property (nonatomic, strong) NSString *statusString;

@property (nonatomic, strong) NSString *timeTag;
@property (nonatomic, strong) NSString *statusTag;

@end

@implementation GDrawRecordVc

- (void) onCreate {
    
    [self setupNav];
    
    self.bdateString = [GTool GetCurrentDate];
    self.edateString = [GTool GetCurrentDate];
    self.statusString = @"";
    
    [self createUI];
    
    [self initRefreshControl];
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"提款记录";
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = TXT_SIZE_15;
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

- (void)rightBtnClick {
    
    NSArray *arr = [[NSArray alloc] init];
    
    GFilterDrawView *filterView = [[GFilterDrawView alloc] initWithSubOptions:[arr copy]
                                                            withContainerView:self.tabBarController.view withFilterBlock:^(NSString *bdate, NSString *edate, NSString *status, NSString *timeTag, NSString *statusTag) {
                                                                self.bdateString = bdate;
                                                                self.edateString = edate;
                                                                self.statusString = status;
                                                                self.timeTag = timeTag;
                                                                self.statusTag = statusTag;
                                                                [self initRefreshControl];
                                                            }];
    self.filterView = filterView;
    [self.filterView setTimeDefaultValue:self.timeTag and:self.bdateString and:self.edateString];
    [self.filterView setStatusDefaultValue:self.statusTag and:self.statusString];
    [self.filterView show];
}

- (void)loadData {
    self.page = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self getRechargeRecord];
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
                    
                    [self getRechargeRecord];
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

- (void)getRechargeRecord{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pageNo"] = @"1";
    dic[@"pageSize"] = @"5";
    dic[@"bdate"] = self.bdateString;
    dic[@"edate"] = self.edateString;
    dic[@"status"] = self.statusString;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetWithDrawInfo RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        self.tempArray = [[NSMutableArray alloc] init];
        if (responseObject != nil) {
            NSMutableArray *arrs = [[NSMutableArray alloc] init];
            for (int i = 1; i < [responseObject count]; i++) {
                NSDictionary *dict = responseObject[i];
                GDrawModel *model = [[GDrawModel alloc] init];
                model.amount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"amount"]];
                model.amount_paid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"amount_paid"]];
                model.rmk = [NSString stringWithFormat:@"%@",[dict objectForKey:@"rmk"]];
                NSDictionary *dictTime = [dict objectForKey:@"add_time"];
                model.add_time = [GTool UTCchangeDate:[NSString stringWithFormat:@"%@",[dictTime objectForKey:@"time"]]];
                model.status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
                model.remark = [NSString stringWithFormat:@"%@",[dict objectForKey:@"remark"]];
                model.card_num = [NSString stringWithFormat:@"%@",[dict objectForKey:@"card_num"]];
                model.administrative_fee = [NSString stringWithFormat:@"%@",[dict objectForKey:@"administrative_fee"]];
                model.poundage = [NSString stringWithFormat:@"%@",[dict objectForKey:@"poundage"]];
                
                [arrs addObject:model];
            }
            self.tempArray = arrs;
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)createUI{
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_HEIGHT+20);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)initRefreshControl {
    
    kWeakSelf(wkself);
    
    [self.tableView setRefreshWithHeaderBlock:^{
        [wkself loadData];
    } footerBlock:^{
        [wkself loadMore];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView setupEmptyDataText:@"暂无记录" verticalOffset:-40 emptyImage:[UIImage imageNamed:@"nodata"] tapBlock:^{
        [wkself loadData];
    }];
}

#pragma mark -—————————— UITableView Delegate And DataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:kGDrawCell];
    if (!cell) {
        cell = [[GDrawCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGDrawCell];
    }
    GDrawModel *model = self.tempArray[indexPath.row];
    [cell setDrawModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)loadMore {
    
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pageNo"] = @(self.page);
    dic[@"pageSize"] = @"5";
    dic[@"bdate"] = self.bdateString;
    dic[@"edate"] = self.edateString;
    dic[@"status"] = self.statusString;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetWithDrawInfo RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if (responseObject != nil) {
            for (int i = 1; i < [responseObject count]; i++) {
                NSDictionary *dict = responseObject[i];
                GDrawModel *model = [[GDrawModel alloc] init];
                model.amount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"amount"]];
                model.amount_paid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"amount_paid"]];
                model.rmk = [NSString stringWithFormat:@"%@",[dict objectForKey:@"rmk"]];
                NSDictionary *dictTime = [dict objectForKey:@"add_time"];
                model.add_time = [GTool UTCchangeDate:[NSString stringWithFormat:@"%@",[dictTime objectForKey:@"time"]]];
                model.status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
                model.remark = [NSString stringWithFormat:@"%@",[dict objectForKey:@"remark"]];
                model.card_num = [NSString stringWithFormat:@"%@",[dict objectForKey:@"card_num"]];
                model.administrative_fee = [NSString stringWithFormat:@"%@",[dict objectForKey:@"administrative_fee"]];
                model.poundage = [NSString stringWithFormat:@"%@",[dict objectForKey:@"poundage"]];
                
                [self.tempArray addObject:model];
            }
            if([responseObject count] < 5){
                [SVProgressHUD showInfoWithStatus:@"没有更多记录了"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有更多记录了"];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}

@end
