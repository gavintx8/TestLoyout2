//
//  GHelpVc.m
//  QuCai
//
//  Created by tx gavin on 2017/6/24.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHelpVc.h"
#import "GTitleIconAction.h"
#import "GHelpMenuView.h"
#import "GHelpMenuCell.h"
#import "GHelpDetailVc.h"
#import "GHelpTableViewVc.h"
#import "GOpenAccountVc.h"

static NSString *const  kGHelpMenuVcCell = @"kGHelpMenuVcCell";

@interface GHelpVc ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *helpArrs;
}

@property (nonatomic, strong) NSArray *helpMenus;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation GHelpVc

- (NSArray *)mineMenus{
    if (!_helpMenus) {
        _helpMenus = @[
                       [GTitleIconAction titleIconWith:@"登录注册" icon:[UIImage imageNamed:@"help_icon_01"] controller:nil tag:0],
                       [GTitleIconAction titleIconWith:@"存款流程" icon:[UIImage imageNamed:@"help_icon_02"] controller:nil tag:1],
                       [GTitleIconAction titleIconWith:@"提款流程" icon:[UIImage imageNamed:@"help_icon_03"] controller:nil tag:2],
                       [GTitleIconAction titleIconWith:@"转账流程" icon:[UIImage imageNamed:@"help_icon_04"] controller:nil tag:3],
                       [GTitleIconAction titleIconWith:@"账户安全" icon:[UIImage imageNamed:@"help_icon_05"] controller:nil tag:4],
                       [GTitleIconAction titleIconWith:@"会员制度" icon:[UIImage imageNamed:@"help_icon_06"] controller:nil tag:5],
                       [GTitleIconAction titleIconWith:@"银行卡相关" icon:[UIImage imageNamed:@"help_icon_07"] controller:nil tag:6],
                       [GTitleIconAction titleIconWith:@"其它问题" icon:[UIImage imageNamed:@"help_icon_08"] controller:nil tag:7],
                       ];
    }
    return _helpMenus;
}

- (void)onCreate {
    
    self.navigationItem.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildScrollView];
    
}

- (void)onWillShow {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)buildScrollView{
    self.mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(54);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    UIView *contentView = [[UIView alloc]init];
    [self.mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];
    
    UIView *hotView = [[UIView alloc] init];
    hotView.backgroundColor = self.view.backgroundColor;
    [contentView addSubview:hotView];
    [hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(10);
        make.width.equalTo(contentView);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *hotLabel = [[UILabel alloc] init];
    [hotLabel setText:@"热门分类"];
    hotLabel.textAlignment = NSTextAlignmentCenter;
    [hotLabel setTextColor:[UIColor colorWithRed:133.0/255 green:144.0/255 blue:145.0/255 alpha:1]];
    [hotLabel setFont:[UIFont systemFontOfSize:15.f]];
    [hotView addSubview:hotLabel];
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(hotView);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(35);
    }];
    
    UILabel *lineLeftLabel = [[UILabel alloc] init];
    [lineLeftLabel setBackgroundColor:[UIColor colorWithRed:133.0/255 green:144.0/255 blue:145.0/255 alpha:1]];
    [hotView addSubview:lineLeftLabel];
    [lineLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hotView);
        make.left.equalTo(hotView.mas_left).offset(20);
        make.right.equalTo(hotLabel.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lineRightLabel = [[UILabel alloc] init];
    [lineRightLabel setBackgroundColor:[UIColor colorWithRed:133.0/255 green:144.0/255 blue:145.0/255 alpha:1]];
    [hotView addSubview:lineRightLabel];
    [lineRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hotView);
        make.left.mas_equalTo(hotLabel.mas_right).offset(20);
        make.right.mas_equalTo(hotView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    GHelpMenuView *mineMenuView = [[GHelpMenuView alloc] initMenu:self.mineMenus helpMenuBlock:^(NSInteger index) {
        
        if(index == 5){
            GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
            gOpenAccountVc.navTitle = @"会员制度";
            gOpenAccountVc.htmlName = @"member_rule.html";
            [self.navigationController pushViewController:gOpenAccountVc animated:YES];
        }else{
            GHelpTableViewVc *tbCtl = [[GHelpTableViewVc alloc] init];
            switch (index) {
                case 0:
                    tbCtl.helpType = GHelpTypeLogin;
                    tbCtl.navTitle = @"登录注册";
                    break;
                case 1:
                    tbCtl.helpType = GHelpTypeDeposit;
                    tbCtl.navTitle = @"存款流程";
                    break;
                case 2:
                    tbCtl.helpType = GHelpTypeDrawn;
                    tbCtl.navTitle = @"提款流程";
                    break;
                case 3:
                    tbCtl.helpType = GHelpTypeTransfer;
                    tbCtl.navTitle = @"转账流程";
                    break;
                case 4:
                    tbCtl.helpType = GHelpTypeAccount;
                    tbCtl.navTitle = @"账户安全";
                    break;
                case 6:
                    tbCtl.helpType = GHelpTypeBank;
                    tbCtl.navTitle = @"银行卡相关";
                    break;
                case 7:
                    tbCtl.helpType = GHelpTypeOther;
                    tbCtl.navTitle = @"其他问题";
                    break;
            }
            [self.navigationController pushViewController:tbCtl animated:YES];
        }
        
    } WithLine:NO];
    [contentView addSubview:mineMenuView];
    [mineMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotView.mas_bottom);
        make.leading.trailing.equalTo(contentView);
        make.height.mas_equalTo(200);
    }];
    
    NSString *helpListPath = [[NSBundle mainBundle] pathForResource:@"HelpList" ofType:@"plist"];
    helpArrs = [[NSArray alloc] initWithContentsOfFile:helpListPath];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [contentView addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    int theight = ((int)[helpArrs[0] count] * 50) + 90;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineMenuView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(contentView);
        make.height.mas_equalTo(theight);
    }];
    tableView.scrollEnabled = NO;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tableView);
    }];
}

- (void)onWillDisappear {
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *helpListPath = [[NSBundle mainBundle] pathForResource:@"HelpDetailList" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:helpListPath];
    
    GHelpDetailVc *detailCtl = [[GHelpDetailVc alloc] init];
    
    NSArray *details = arr[0];
    detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
    detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
    
    [self.navigationController pushViewController:detailCtl animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [helpArrs[0] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GHelpMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kGHelpMenuVcCell];
    if (!cell) {
        cell = [[GHelpMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGHelpMenuVcCell];
    }
    cell.lbl.text = [NSString stringWithFormat:@"%@",helpArrs[0][indexPath.row]];
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"热门问题";
    lbl.textColor = [UIColor colorWithRed:149.0/255 green:149.0/255 blue:149.0/255 alpha:1];
    [headerView addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.leading.equalTo(headerView).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    return headerView;
}

@end
