//
//  GBindingCardListVc.m
//  QuCai
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBindingCardListVc.h"
#import "GCardCell.h"
#import "ContactServiceVc2.h"

static NSString *const  kGCardCell = @"kGCardCell";

@interface GBindingCardListVc ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GBindingCardListVc

- (void) onCreate {
    
    [self setupNav];
    
    [self createUI];
}

- (void) onWillShow {

}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"银行卡";
}


- (void)createUI{
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_HEIGHT);
    }];
    self.tableView.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark -—————————— UITableView Delegate And DataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GCardCell *cell = [tableView dequeueReusableCellWithIdentifier:kGCardCell];
    if (!cell) {
        cell = [[GCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGCardCell];
    }
    NSDictionary *dict = self.tempArray[indexPath.row];
    [cell setData:dict];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSString *label_text2 = @"温馨提示:如需修改绑定银行卡信息，请联系 在线客服";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] range:NSMakeRange(21, 4)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 21)];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [label5 setFont:[UIFont systemFontOfSize:12.f]];
    label5.attributedText = attributedString2;
    label5.textAlignment = NSTextAlignmentCenter;
    
    [label5 yb_addAttributeTapActionWithStrings:@[@"在线客服"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
        [self.navigationController pushViewController:csVc animated:YES];
    }];
    
    return label5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
