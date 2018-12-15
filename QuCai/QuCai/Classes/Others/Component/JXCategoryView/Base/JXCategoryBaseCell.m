//
//  JXCategoryBaseCell.m
//  UI系列测试
//
//  Created by jiaxin on 2017/3/15.
//  Copyright © 2017年 jiaxin. All rights reserved.
//

#import "JXCategoryBaseCell.h"

@interface JXCategoryBaseCell ()
@end

@implementation JXCategoryBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews
{

}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    self.cellModel = cellModel;
    
}

@end
