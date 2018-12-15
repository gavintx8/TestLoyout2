//
//  GTableView.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

// 这个 block 用于回调当前点击 cell 的行数
typedef void(^handleCellBlock)(NSIndexPath *index);

@interface GTableView : UITableView
#pragma mark -- 设置数据源 (要求数组里必须是装着 cell)
/**
 *   设置数据源 (要求数组里必须是装着 cell)
 *
 *   dataArray
 */
- (void)setUpTheDataSourceWithArray:(NSMutableArray<UITableViewCell *> *)dataArray;

#pragma mark -- cell的点击事件
/**
 *  cell的点击事件 (封装成 block)
 *
 *   clickBlock
 */
- (void)clickCellWithBlock:(handleCellBlock)clickBlock;

/**cell 行高*/
@property (nonatomic, assign) CGFloat cellHeight;

@end
