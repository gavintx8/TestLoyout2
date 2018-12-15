//
//  GFilterView.h
//  QuCai
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^filterDrawBlock) (NSString *bdate,NSString *edate,NSString *status,NSString *timeTag,NSString *statusTag);

@interface GFilterDrawView : UIView

@property (nonatomic, strong) NSString *timeTag;
@property (nonatomic, strong) NSString *statusTag;
@property (nonatomic, strong) NSString *bdateString;
@property (nonatomic, strong) NSString *edateString;
@property (nonatomic, strong) NSString *statusString;

- (instancetype _Nullable)initWithSubOptions:(NSArray* _Nonnull)subOptions
                           withContainerView:(UIView* _Nonnull)containerView
                             withFilterBlock:(filterDrawBlock _Nullable)block;
- (void)show;
- (void)hide;
- (void)setTimeDefaultValue:(NSString *)tag and:(NSString *)bdate and:(NSString *)edate;
- (void)setStatusDefaultValue:(NSString *)tag and:(NSString *)status;

@end
