//
//  GHelpDetailVc.m
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHelpDetailVc.h"

@interface GHelpDetailVc ()

@end

@implementation GHelpDetailVc

- (void)onCreate {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"问题详情";
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    [titleLabel setText:self.titleHelp];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.leading.equalTo(self.view).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    UITextView *detailTV = [[UITextView alloc] init];
    detailTV.textColor = [UIColor colorWithRed:133.0/255 green:144.0/255 blue:145.0/255 alpha:1];
    [detailTV setFont:[UIFont systemFontOfSize:15.f]];
    [detailTV setText:[self.detailHelp stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]];
    [detailTV setEditable:NO];
    [self.view addSubview:detailTV];
    [detailTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(500);
    }];
}

- (void)onWillShow {
    
}

- (void)onWillDisappear {
    
}

@end
