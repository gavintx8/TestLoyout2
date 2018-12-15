//
//  GServiceVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GServiceVc.h"
#import "ContactServiceVc.h"
#import <FLAnimatedImageView+WebCache.h>
#import "GPayVc.h"

@interface GServiceVc ()

@end

@implementation GServiceVc

- (void)onCreate {
    
//    [self setupNav];
    
    ContactServiceVc *csVc = [[ContactServiceVc alloc] init];
    [self.navigationController pushViewController:csVc animated:YES];
}

- (void)onWillShow {
//    self.navigationController.navigationBar.hidden = NO;
//    [self createUI];
    ContactServiceVc *csVc = [[ContactServiceVc alloc] init];
    [self.navigationController pushViewController:csVc animated:YES];
}

- (void)setupNav {
    self.navigationItem.title = TABBAR_SERVICE;
    self.view.backgroundColor = [UIColor colorWithRed:104.0/255 green:104.0/255 blue:104.0/255 alpha:1];
}

- (void)createUI{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.height.mas_equalTo(300);
        make.leading.equalTo(self.view).offset(40);
        make.trailing.equalTo(self.view).offset(-40);
    }];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithRed:122.0/255 green:122.0/255 blue:122.0/255 alpha:1];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.text = @"联系方式";
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView.mas_top).offset(30);
    }];
    
    UIImageView *linkImgV = [[UIImageView alloc] init];
    [linkImgV setImage:[UIImage imageNamed:@"icon-kefu"]];
    [contentView addSubview:linkImgV];
    [linkImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(28);
        make.left.equalTo(contentView.mas_left).offset(40);
    }];
    
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"zx@3x" ofType:@"gif"];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    FLAnimatedImageView *iv = [FLAnimatedImageView new];
    [iv sd_setImageWithURL:url];
    [contentView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(contentView.mas_left).offset(80);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *linkButton = [[UIButton alloc] init];
    linkButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [contentView addSubview:linkButton];
    [linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(contentView.mas_left).offset(80);
        make.height.mas_equalTo(40);
        make.right.equalTo(contentView);
    }];
    [linkButton addTarget:self action:@selector(linkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *qqImgV = [[UIImageView alloc] init];
    [qqImgV setImage:[UIImage imageNamed:@"icon-qq"]];
    [contentView addSubview:qqImgV];
    [qqImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linkButton.mas_bottom).offset(28);
        make.left.equalTo(contentView.mas_left).offset(40);
    }];
    
    UIButton *qqButton = [[UIButton alloc] init];
    [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [qqButton setTitle:@"8818862" forState:UIControlStateNormal];
    qqButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    qqButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:qqButton];
    [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linkButton.mas_bottom).offset(20);
        make.left.equalTo(contentView.mas_left).offset(80);
        make.height.mas_equalTo(40);
        make.right.equalTo(contentView);
    }];
    [qqButton addTarget:self action:@selector(qqButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *emailImgV = [[UIImageView alloc] init];
    [emailImgV setImage:[UIImage imageNamed:@"icon-email"]];
    [contentView addSubview:emailImgV];
    [emailImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qqButton.mas_bottom).offset(18);
        make.left.equalTo(contentView.mas_left).offset(40);
    }];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.textColor = [UIColor blackColor];
    emailLabel.font = [UIFont systemFontOfSize:12.f];
    emailLabel.text = @"邮箱：8818862@qq.com";
    [contentView addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(emailImgV);
        make.left.equalTo(contentView.mas_left).offset(80);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *wechatImgV = [[UIImageView alloc] init];
    [wechatImgV setImage:[UIImage imageNamed:@"icon-wx"]];
    [contentView addSubview:wechatImgV];
    [wechatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailLabel.mas_bottom).offset(18);
        make.left.equalTo(contentView.mas_left).offset(40);
    }];
    
    UILabel *wechatLabel = [[UILabel alloc] init];
    wechatLabel.textColor = [UIColor blackColor];
    wechatLabel.font = [UIFont systemFontOfSize:12.f];
    wechatLabel.text = @"微信号：jinshaff168888";
    [contentView addSubview:wechatLabel];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wechatImgV);
        make.left.equalTo(contentView.mas_left).offset(80);
        make.height.mas_equalTo(40);
    }];
    
//    UIButton *depositButton = [[UIButton alloc] init];
//    [depositButton setTitleColor:Title_Red forState:UIControlStateNormal];
//    [depositButton setTitle:@"立即存款" forState:UIControlStateNormal];
//    depositButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    depositButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
//    depositButton.layer.borderWidth = 1;
//    depositButton.layer.borderColor = Title_Red.CGColor;
//    [depositButton.layer setCornerRadius:5];
//    depositButton.layer.masksToBounds = YES;
//    [contentView addSubview:depositButton];
//    [depositButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wechatLabel.mas_bottom).offset(20);
//        make.centerX.equalTo(contentView);
//        make.width.mas_equalTo(148);
//        make.height.mas_equalTo(30);
//    }];
//    [depositButton addTarget:self action:@selector(depositButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)depositButtonClick:(id)sender{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        GLoginVC *gLogin = [[GLoginVC alloc] init];
        [self presentViewController:gLogin animated:YES completion:nil];
    }else{
        GPayVc *payVc = [[GPayVc alloc] init];
        [self.navigationController pushViewController:payVc animated:YES];
    }
}

- (void)linkButtonClick:(id)sender{
    ContactServiceVc *csVc = [[ContactServiceVc alloc] init];
    [self.navigationController pushViewController:csVc animated:YES];
}

- (void)qqButtonClick:(id)sender{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"8818862"]]];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请安装QQ"];
    }
}

- (void)onWillDisappear {
}

@end
