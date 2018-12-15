//
//  GPlatCell.h
//  QuCai
//
//  Created by mac on 2017/7/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPlatModel.h"

#define ItemHeight kSize(32)

@interface GPlatCell : UITableViewCell

- (float)setData:(GPlatModel *)model and:(NSString *)name;

@end
