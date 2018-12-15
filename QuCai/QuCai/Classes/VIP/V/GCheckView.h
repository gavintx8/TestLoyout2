//
//  GCheckView.h
//  QuCai
//
//  Created by tx gavin on 2017/7/8.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTitleIconAction.h"

typedef void(^CheckBlock)(NSInteger index);

@interface GCheckView : UIView

- (instancetype)initMenu:(NSArray <GTitleIconAction *>*)mens checkBlock:(void(^)(NSInteger index))checkBlock WithLine:(BOOL)line;


@end
