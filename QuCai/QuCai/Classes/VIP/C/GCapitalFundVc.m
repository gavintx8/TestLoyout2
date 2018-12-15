//
//  GCapitalFundVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GCapitalFundVc.h"
#import "GFundHeadView.h"
#import "GDrawMoneyVc.h"
#import "GPayVc.h"
#import "GPlatCell.h"

static const CGFloat cellHeight = 60;

@interface GCapitalFundVc ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)GFundHeadView *headerView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArrs;

@end

@implementation GCapitalFundVc

- (void) onCreate {
    self.navigationItem.title = @"总资产";
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#35AEA0"];
    [self initLoadData];

    [self createTableView];
    [self setUpBottomButton];
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)onWillDisappear{
    [SVProgressHUD dismiss];
}

- (void)initLoadData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FundPlatList" ofType:@"plist"];
    self.dataArrs = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<self.dataArrs.count; i++) {
        NSDictionary *dic = self.dataArrs[i];
        GPlatModel *model = [[GPlatModel alloc] init];
        model.image_url = [NSString stringWithFormat:@"%@",[dic objectForKey:@"image"]];
        model.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
        model.money = @"加载中...";
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    
    [self loadData];
}

- (void)loadData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {

        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            NSInteger index = 0;
            [self searchBalance:index];
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
                    
                    NSInteger index = 0;
                    [self searchBalance:index];
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)searchBalance:(NSInteger)indexB{
    
    NSDictionary *dic = self.dataArrs[indexB];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"BType"] = [NSString stringWithFormat:@"%@",[dic objectForKey:@"BType"]];
    indexB++;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dict withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSDictionary *dict = [[NSDictionary alloc] init];
        dict = responseObject;
        
        GPlatModel *model = self.dataArray[indexB-1];
        model.money = [NSString stringWithFormat:@"%@",[dict objectForKey:@"balance"]];
        
        if (indexB == self.dataArrs.count) {
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [self searchBalance:indexB];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)createTableView
{
    _headerView = [[GFundHeadView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 280)];
    [self.view addSubview:_headerView];
    WEAKSELF
    [self.headerView setClikeCall:^(NSInteger tag) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.headerView setClikeCall2:^(NSInteger tag) {
        [weakSelf initLoadData];
    }];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setBackgroundColor:[UIColor colorWithHexStr:@"#35AEA0"]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    if(KIsiPhoneX){
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-80);
        }];
    }else{
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-50);
        }];
    }
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"kGPlatCell";
    GPlatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GPlatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    GPlatModel *model = self.dataArray[indexPath.row];
    [cell setData:model and:@""];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
//    UILabel *label = [[UILabel alloc] init];
//    [label setText:@"资金明细"];
//    [label setFont:[UIFont systemFontOfSize:14.f]];
//    [label setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
//    [headerView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headerView);
//        make.left.equalTo(headerView).offset(20);
//        make.height.mas_equalTo(30);
//    }];
//
//    UIButton *quotaButton = [[UIButton alloc] init];
//    [quotaButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
//    [quotaButton setTitle:@"刷新额度" forState:UIControlStateNormal];
//    quotaButton.titleLabel.font = [UIFont systemFontOfSize: 14.f];
//    [quotaButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [headerView addSubview:quotaButton];
//    [quotaButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headerView);
//        make.right.equalTo(headerView).offset(-20);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(100);
//    }];
//    [quotaButton addTarget:self action:@selector(quotaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 30;
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}

//- (void)quotaButtonClick:(UIButton *)button{
//    [self initLoadData];
//}

#pragma mark - 底部重置确定按钮
- (void)setUpBottomButton
{
    CGFloat buttonW = SCREEN_WIDTH/2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    if(KIsiPhoneX){
        buttonY = buttonY - 30;
    }
    NSArray *titles = @[@"提款",@"存款"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = i;
        if (i == 0) {
            [button setTitleColor:BG_Nav forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            [GTool dc_chageControlCircularWith:button AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:BG_Nav canMasksToBounds:YES];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:BG_Nav];
            [GTool dc_chageControlCircularWith:button AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:BG_Nav canMasksToBounds:YES];
        }
        CGFloat buttonX = i*buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = PFR16Font;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        GDrawMoneyVc *drawVc = [[GDrawMoneyVc alloc] init];
        [self.navigationController pushViewController:drawVc animated:YES];
    }else if (button.tag == 1){
        GPayVc *payVc = [[GPayVc alloc] init];
        [self.navigationController pushViewController:payVc animated:YES];
    }
}

@end
