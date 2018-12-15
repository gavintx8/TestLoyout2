//
//  GZRenTableView.h
//  QuCai
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPageListView.h"

typedef void(^GZRenTableViewBlock)(NSInteger index);

@interface GZRenTableView : UIView < JXPageListViewListDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceImg;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceTitle;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceDesc;
@property (nonatomic, copy) GZRenTableViewBlock zrenBlock;

@end
