//
//  GHelpTableViewVc.m
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHelpTableViewVc.h"
#import "GHelpMenuCell.h"
#import "GHelpDetailVc.h"
#import "GOpenAccountVc.h"

static NSString *const  kGHelpMenuVcCell = @"kGHelpTableViewVcCell";

@interface GHelpTableViewVc ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *helpArrs;
}

@end

@implementation GHelpTableViewVc

- (void)onCreate {
    
    self.navigationItem.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildTableView];
}

- (void)onWillShow {
    
}

- (void)buildTableView{
    NSString *helpListPath = [[NSBundle mainBundle] pathForResource:@"HelpList" ofType:@"plist"];
    helpArrs = [[NSArray alloc] initWithContentsOfFile:helpListPath];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    int theight = 0;
    switch (self.helpType) {
        case GHelpTypeHot:
            theight = 0;
            break;
        case GHelpTypeLogin:
            theight = ((int)[helpArrs[1] count] * 50) + 150;
            break;
        case GHelpTypeDeposit:
            theight = ((int)[helpArrs[2] count] * 50) + 200;
            break;
        case GHelpTypeDrawn:
            theight = ((int)[helpArrs[3] count] * 50) + 150;
            break;
        case GHelpTypeTransfer:
            theight = ((int)[helpArrs[4] count] * 50) + 150;
            break;
        case GHelpTypeAccount:
            theight = ((int)[helpArrs[5] count] * 50) + 150;
            break;
        case GHelpTypeMember:
            theight = 0;
            break;
        case GHelpTypeBank:
            theight = ((int)[helpArrs[6] count] * 50) + 150;
            break;
        case GHelpTypeOther:
            theight = ((int)[helpArrs[7] count] * 50) + 150;
            break;
    }
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(theight);
    }];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)onWillDisappear {
}

- (void)onDidAppear{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *helpListPath = [[NSBundle mainBundle] pathForResource:@"HelpDetailList" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:helpListPath];
    
    GHelpDetailVc *detailCtl = [[GHelpDetailVc alloc] init];
    
    switch (self.helpType) {
        case GHelpTypeHot:{}
            break;
        case GHelpTypeLogin:{
            if(indexPath.row == 0){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"开户条约";
                gOpenAccountVc.htmlName = @"openaccount_terms.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else{
                NSArray *details = arr[1];
                detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
                detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
                [self.navigationController pushViewController:detailCtl animated:YES];
            }
        }
            break;
        case GHelpTypeDeposit:{
            if(indexPath.row == 4){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"fast_pay.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 5){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"aliscan_pay.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 6){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"wechat_pay.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 7){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"ali_pay.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else{
                NSArray *details = arr[2];
                detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
                detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
                [self.navigationController pushViewController:detailCtl animated:YES];
            }
        }
            break;
        case GHelpTypeDrawn:{
            NSArray *details = arr[3];
            detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
            detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
            [self.navigationController pushViewController:detailCtl animated:YES];
        }
            break;
        case GHelpTypeTransfer:{
            if(indexPath.row == 4){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"transfer.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else{
                NSArray *details = arr[4];
                detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
                detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
                [self.navigationController pushViewController:detailCtl animated:YES];
            }
        }
            break;
        case GHelpTypeAccount:{
            if(indexPath.row == 0){
                NSArray *details = arr[5];
                detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
                detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
                [self.navigationController pushViewController:detailCtl animated:YES];
            }else if(indexPath.row == 1){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"ysbf_rule.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 2){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"tzgd_rule.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 3){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"bczr_rule.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 4){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"gztk_rule.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }else if(indexPath.row == 5){
                GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
                gOpenAccountVc.navTitle = @"问题详情";
                gOpenAccountVc.htmlName = @"yhysxy_rule.html";
                [self.navigationController pushViewController:gOpenAccountVc animated:YES];
            }
        }
            break;
        case GHelpTypeMember:{}
            break;
        case GHelpTypeBank:{
            NSArray *details = arr[6];
            detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
            detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
            [self.navigationController pushViewController:detailCtl animated:YES];
        }
            break;
        case GHelpTypeOther:{
            NSArray *details = arr[7];
            detailCtl.titleHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][0]];
            detailCtl.detailHelp = [NSString stringWithFormat:@"%@",details[indexPath.row][1]];
            [self.navigationController pushViewController:detailCtl animated:YES];
        }
            break;
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger countRow;
    switch (self.helpType) {
        case GHelpTypeHot:
            countRow = 0;
            break;
        case GHelpTypeLogin:
            countRow = [helpArrs[1] count];
            break;
        case GHelpTypeDeposit:
            countRow = [helpArrs[2] count];
            break;
        case GHelpTypeDrawn:
            countRow = [helpArrs[3] count];
            break;
        case GHelpTypeTransfer:
            countRow = [helpArrs[4] count];
            break;
        case GHelpTypeAccount:
            countRow = [helpArrs[5] count];
            break;
        case GHelpTypeMember:
            countRow = 0;
            break;
        case GHelpTypeBank:
            countRow = [helpArrs[6] count];
            break;
        case GHelpTypeOther:
            countRow = [helpArrs[7] count];
            break;
    }
    return countRow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.helpType == GHelpTypeDeposit) {
        return 100;
    }
    return 10;
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
    NSInteger countRow;
    switch (self.helpType) {
        case GHelpTypeHot:
            countRow = 0;
            break;
        case GHelpTypeLogin:
            countRow = 1;
            break;
        case GHelpTypeDeposit:
            countRow = 2;
            break;
        case GHelpTypeDrawn:
            countRow = 3;
            break;
        case GHelpTypeTransfer:
            countRow = 4;
            break;
        case GHelpTypeAccount:
            countRow = 5;
            break;
        case GHelpTypeMember:
            countRow = 0;
            break;
        case GHelpTypeBank:
            countRow = 6;
            break;
        case GHelpTypeOther:
            countRow = 7;
            break;
    }
    cell.lbl.text = [NSString stringWithFormat:@"%@",helpArrs[countRow][indexPath.row]];
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
    if (self.helpType == GHelpTypeDeposit) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        headerView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = @"我们一直将保护客户隐私及安全性作为首要宗旨，所有支付交易的处理均采用了最高标准的数据加密方式，采用128位SSL加密技术和严格的安全管理体系，确保客户安全得到最完善的保障。";
        lbl.textColor = [UIColor colorWithRed:149.0/255 green:149.0/255 blue:149.0/255 alpha:1];
        lbl.font = [UIFont systemFontOfSize:15.f];
        [headerView addSubview:lbl];
        lbl.lineBreakMode = NSLineBreakByWordWrapping;
        lbl.numberOfLines = 0;
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.leading.equalTo(headerView).offset(20);
            make.trailing.equalTo(headerView).offset(-20);
            make.height.mas_equalTo(100);
        }];
        return headerView;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headerView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        return headerView;
    }
}
@end
