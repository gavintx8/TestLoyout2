//
//  YNPageCollectionView.m
//  YNPageViewController
//
//  Created by ZYN on 2017/7/14.
//  Copyright © 2017年 yongneng. All rights reserved.
//

#import "YNPageCollectionView.h"

@interface YNPageCollectionView () <UIGestureRecognizerDelegate>

@end

@implementation YNPageCollectionView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
