//
//  GJournalAccountCapitalVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GJournalAccountCapitalVc.h"
#import "GFilterJournalView.h"
#import "GJournalModel.h"
#import "GJournalCell.h"

static NSString *const  kGJournalCell = @"kGJournalCell";

@interface GJournalAccountCapitalVc ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic,weak) GFilterJournalView *filterView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *bdateString;
@property (nonatomic, strong) NSString *edateString;
@property (nonatomic, strong) NSString *typeString;

@property (nonatomic, strong) NSString *timeTag;
@property (nonatomic, strong) NSString *typeTag;

@end

@implementation GJournalAccountCapitalVc

- (void) onCreate {
    
    [self setupNav];
    
    self.bdateString = [NSString stringWithFormat:@"%@ 00:00:00",[GTool GetCurrentDate]];
    self.edateString = [NSString stringWithFormat:@"%@ 23:59:59",[GTool GetCurrentDate]];
    self.typeString = @"0";
    
    [self createUI];
    
    [self initRefreshControl];
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"资金流水";
    
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
    
    GFilterJournalView *filterView = [[GFilterJournalView alloc] initWithSubOptions:[arr copy]
                                                                  withContainerView:self.view withFilterBlock:^(NSString *bdate, NSString *edate, NSString *type,NSString *timeTag,NSString *typeTag) {
                                                                      self.bdateString = bdate;
                                                                      self.edateString = edate;
                                                                      self.typeString = type;
                                                                      self.typeTag = typeTag;
                                                                      self.timeTag = timeTag;
                                                                      [self initRefreshControl];
                                                                  }];
    self.filterView = filterView;
    [self.filterView setTimeDefaultValue:self.timeTag and:self.bdateString and:self.edateString];
    [self.filterView setTypeDefaultValue:self.typeTag and:self.typeString];
    [self.filterView show];
}

- (void)loadData {
    self.page = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self getJournalInfo];
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
                    
                    [self getJournalInfo];
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

- (void)getJournalInfo{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pageNo"] = @"1";
    dic[@"pageSize"] = @"5";
    dic[@"startTime"] = self.bdateString;
    dic[@"endTime"] = self.edateString;
    dic[@"type"] = self.typeString;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kQueryByTreasurePage RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        self.tempArray = [[NSMutableArray alloc] init];
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]] isEqualToString:@"success"]) {
            NSMutableArray *arrs = [[NSMutableArray alloc] init];
            NSArray *arrData = [responseObject objectForKey:@"data"];
            for (int i = 0; i < [arrData count]; i++) {
                NSDictionary *dict = arrData[i];
                GJournalModel *model = [[GJournalModel alloc] init];
                model.money = [NSString stringWithFormat:@"%@",[dict objectForKey:@"new_money"]];
                model.amount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"amount"]];
                model.rmk = [NSString stringWithFormat:@"%@",[dict objectForKey:@"rmk"]];
                NSDictionary *dictTime = [dict objectForKey:@"addtime"];
                model.addtime = [GTool UTCchangeDate:[NSString stringWithFormat:@"%@",[dictTime objectForKey:@"time"]]];
                model.t_type = [NSString stringWithFormat:@"%@",[dict objectForKey:@"t_type"]];
                
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
    self.tableView.rowHeight = 60;
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
    
    GJournalCell *cell = [tableView dequeueReusableCellWithIdentifier:kGJournalCell];
    if (!cell) {
        cell = [[GJournalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGJournalCell];
    }
    GJournalModel *model = self.tempArray[indexPath.row];
    [cell setJournalModel:model];
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
    dic[@"startTime"] = self.bdateString;
    dic[@"endTime"] = self.edateString;
    dic[@"type"] = self.typeString;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kQueryByTreasurePage RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]] isEqualToString:@"success"]) {
            NSArray *arrData = [responseObject objectForKey:@"data"];
            for (int i = 0; i < [arrData count]; i++) {
                NSDictionary *dict = arrData[i];
                GJournalModel *model = [[GJournalModel alloc] init];
                model.money = [NSString stringWithFormat:@"%@",[dict objectForKey:@"new_money"]];
                model.amount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"amount"]];
                model.rmk = [NSString stringWithFormat:@"%@",[dict objectForKey:@"rmk"]];
                NSDictionary *dictTime = [dict objectForKey:@"addtime"];
                model.addtime = [GTool UTCchangeDate:[NSString stringWithFormat:@"%@",[dictTime objectForKey:@"time"]]];
                model.t_type = [NSString stringWithFormat:@"%@",[dict objectForKey:@"t_type"]];
                
                [self.tempArray addObject:model];
            }
            if(arrData.count < 5){
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
