//
//  GTableView.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//


#import "GTableView.h"
#import "GLeftTableviewCell.h"
#import "GRightTableViewCell.h"

@interface GTableView () <UITableViewDataSource,UITableViewDelegate>
/**数据源 数组*/
@property(nonatomic,strong)NSMutableArray *dataArray;

/**将这个 block 定义属性*/
@property (nonatomic, copy) handleCellBlock clickBlock;
@end

@implementation GTableView

#pragma mark -- 设置数据源并创建
- (void)setUpTheDataSourceWithArray:(NSMutableArray<UITableViewCell *> *)dataArray;{
    
    // 加载数据时 增加分割线 刷新数据
    _dataArray = dataArray;
    
    if (_dataArray.count) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    //设置状态栏返回顶部
    [self setScrollsToTop:YES];
    
    //去掉tableview的回弹滚动
    //    self.bounces =NO;
    
    [self reloadData];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.dataSource = self;
        // 设置去除tableview的底端横线
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        // 设置去除tableview的底端横线
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 设置去除tableview的底端横线
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark -- tableView # delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArray[indexPath.row] isKindOfClass:[GLeftTableviewCell class]]) {

    }
    return self.dataArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.clickBlock(indexPath);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[GLeftTableviewCell class]]){
        GLeftTableviewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.label setTextColor:[UIColor colorWithHexStr:@"#000000"]];
        [cell.lineView setBackgroundColor:Them_Color];
    }
}

- (void)clickCellWithBlock:(handleCellBlock)clickBlock{
    if (clickBlock) {
        _clickBlock = clickBlock;
    }
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
