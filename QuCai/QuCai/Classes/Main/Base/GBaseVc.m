//
//  GBaseVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBaseVc.h"

@interface GBaseVc ()<UIGestureRecognizerDelegate>

@end

@implementation GBaseVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //侧滑相关
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    [self.navigationController.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
//    if (@available(iOS 11.0, *)) {
//        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    
    [self onCreate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self onWillShow];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self onWillDisappear];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self onDidAppear];
}

- (void) onCreate {

}

- (void) onWillShow {
    
}

- (void) onWillDisappear {
    
}

- (void) onDidAppear {
    
}

#pragma mark - 滑动开始会触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count <= 1)
    {
        return NO;
    }
    return YES;
}

@end
