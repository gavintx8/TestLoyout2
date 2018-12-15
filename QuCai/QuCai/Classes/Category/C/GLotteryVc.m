//
//  GLotteryVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GLotteryVc.h"
#import <FSScrollContentView.h>
#import "GLotterysegmentVc.h"

@interface GLotteryVc ()<FSPageContentViewDelegate, FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation GLotteryVc

- (void)onCreate {
    
    self.navigationItem.title = @"彩票游戏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat yDistance;
    self.title = @"彩票游戏";
    if ([SystemInfo instance].isIphoneX) {
        yDistance = 30;
    } else {
        yDistance = 0;
    }
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 64+yDistance, CGRectGetWidth(self.view.bounds), 35) titles:@[@"IG彩票 新",@"IG彩票",@"VR彩票",@"GY彩票"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:14];
    self.titleView.selectIndex = 0;
    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];

    NSArray *titleAry = @[@"IG彩票 新",@"IG彩票",@"VR彩票",@"GY彩票"];
    for (int i = 0; i < 4; i++) {
        GLotterysegmentVc *vc = [[GLotterysegmentVc alloc]init];
        vc.title = titleAry[i];
        vc.lotteryType = i;
        [childVCs addObject:vc];
    }
    
    self.pageContentView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 99+yDistance, CGRectGetWidth(self.view.bounds), SCREEN_HEIGHT- 114 - yDistance) childVCs:childVCs parentVC:self delegate:self];
    
    self.pageContentView.backgroundColor = [UIColor redColor];
    
    if ([self.judgeStr isEqualToString:@"1"]) {
        self.pageContentView.contentViewCurrentIndex = 2;
        self.titleView.selectIndex = 2;
    } else {
        self.pageContentView.contentViewCurrentIndex = 0;
    }
    
    [self.view addSubview:_pageContentView];
}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    self.title = @[@"IG彩票 新",@"IG彩票",@"VR彩票",@"GY彩票"][endIndex];
}

@end
