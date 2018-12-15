//
//  GChosePlatAlert.m
//  QuCai
//
//  Created by mac on 2017/7/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GChosePlatAlert.h"
#import "GPlatCell.h"

@implementation GChosePlatAlert
{
    UIView *view;
    UIView *bgView;
}

- (instancetype)initWithFrame:(CGRect)frame andHeight:(float)height {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明view
        view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        [self addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
        [view addGestureRecognizer:tap];
        //白色底view
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, height)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        
        [bgView addSubview:self.tableview];
        self.tableview.tableFooterView = [[UIView alloc]init];
    }
    return self;
}

#pragma mark - methods
- (void)hideView
{
    [UIView animateWithDuration:0.25 animations:^
     {
         self->bgView.centerY = self->bgView.centerY+CGRectGetHeight(self->bgView.frame);
         
     } completion:^(BOOL fin){
         [self removeFromSuperview];
     }];
}

- (void)showView
{
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^
     {
         self->bgView.centerY = self->bgView.centerY-CGRectGetHeight(self->bgView.frame);
         
     } completion:^(BOOL fin){}];
}

- (void)initData:(NSMutableArray *)arrs
{
    [_dataSource removeAllObjects];
    
    _dataSource = arrs;
    
    [self.tableview reloadData];
}

#pragma mark - tavdelegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"GPlatCell";
    GPlatCell *cell = [[GPlatCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GPlatModel *model = _dataSource[indexPath.row];
    tableView.rowHeight = [cell setData:model and:self.platname];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clikeCall) {
        self.clikeCall(indexPath.row);
    }
}

- (UITableView *)tableview
{
    if (!_tableview) {
        if(KIsiPhoneX){
            _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 280) style:UITableViewStylePlain];
        }else{
            _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 250) style:UITableViewStylePlain];
        }
        _tableview.sectionHeaderHeight = 0;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _tableview;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)dealloc{
}

@end
