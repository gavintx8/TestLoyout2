//
//  JXPagerMainTableView.m
//
//  Created by jiaxin on 2017/8/27.
//  Copyright © 2017年 jiaxin. All rights reserved.
//

#import "JXPageListMainTableView.h"

@interface JXPageListMainTableView ()<UIGestureRecognizerDelegate>

@end

@implementation JXPageListMainTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
