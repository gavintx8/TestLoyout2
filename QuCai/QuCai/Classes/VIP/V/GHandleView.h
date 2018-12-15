//
//  GHandleView.h
//  QuCai
//
//  Created by tx gavin on 2017/7/8.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTitleIconAction.h"

typedef void(^HandleBlock)(NSInteger index);

@interface GHandleView : UIView

- (instancetype)initMenu:(NSArray <GTitleIconAction *>*)mens handleBlock:(void(^)(NSInteger index))handleBlock WithLine:(BOOL)line;

@end
