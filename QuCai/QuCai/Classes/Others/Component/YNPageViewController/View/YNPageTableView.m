//
//  YNPageTableView.m
//  YNPageViewController
//
//  Created by ZYN on 2017/7/14.
//  Copyright © 2017年 yongneng. All rights reserved.
//

#import "YNPageTableView.h"

@interface YNPageTableView () <UIGestureRecognizerDelegate>

@end

@implementation YNPageTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



@end
