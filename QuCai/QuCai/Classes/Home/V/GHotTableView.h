//
//  TestListBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2017/8/27.
//  Copyright © 2017年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPageListView.h"

typedef void(^GHotTableViewBlock)(NSInteger index);

@interface GHotTableView : UIView < JXPageListViewListDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceImg;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceTitle;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceDesc;
@property (nonatomic, copy) GHotTableViewBlock hotBlock;

@end
