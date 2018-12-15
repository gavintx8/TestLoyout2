//
//  GChosePlatAlert.h
//  QuCai
//
//  Created by mac on 2017/7/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPlatModel;

typedef void(^ClikedChoosePlatCallback) (NSInteger index);

@interface GChosePlatAlert : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)GPlatModel *model;
@property (nonatomic, copy) ClikedChoosePlatCallback clikeCall;
@property (nonatomic, strong)NSString *platname;

- (void)hideView;
- (void)showView;
- (void)initData:(NSMutableArray *)arrs;
- (instancetype)initWithFrame:(CGRect)frame andHeight:(float)height;

@end
