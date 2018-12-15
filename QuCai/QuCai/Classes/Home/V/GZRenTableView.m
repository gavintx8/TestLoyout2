//
//  GZRenTableView.m
//  QuCai
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GZRenTableView.h"
#import "MJRefresh.h"
#import "GGameEnterCell.h"

@interface GZRenTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation GZRenTableView

- (void)dealloc
{
    self.scrollCallback = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        [self.tableView registerClass:[GGameEnterCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 120)];
        imv.image = [UIImage imageNamed:@"index_banner_02"];
        [imv.layer setCornerRadius:3];
        imv.layer.masksToBounds = YES;
        [headView addSubview:imv];
        
        UIImageView *imv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 87, 10, 87, 25)];
        imv2.image = [UIImage imageNamed:@"remen"];
        [headView addSubview:imv2];
        
        self.tableView.tableHeaderView = headView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceImg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GGameEnterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imv1 setImage:[UIImage imageNamed:self.dataSourceImg[indexPath.row]]];
    cell.label1.text = self.dataSourceTitle[indexPath.row];
    cell.label2.text = self.dataSourceDesc[indexPath.row];
    cell.enterGameButton.tag = indexPath.row;
    [cell.enterGameButton addTarget:self action:@selector(enterGameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)enterGameButtonClick:(UIButton *)button{
    if (self.zrenBlock) {
        self.zrenBlock(button.tag);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.zrenBlock) {
        self.zrenBlock(indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback?:self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listViewLoadDataIfNeeded {
    
}

@end

