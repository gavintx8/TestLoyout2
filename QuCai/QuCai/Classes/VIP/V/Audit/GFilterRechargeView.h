//
//  GFilterView.h
//  QuCai
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^filterRechargeBlock) (NSString *bdate,NSString *edate,NSString *type,NSString *status,NSString *timeTag,NSString *typeTag,NSString *statusTag);

@interface GFilterRechargeView : UIView

@property (nonatomic, strong) NSString *timeTag;
@property (nonatomic, strong) NSString *typeTag;
@property (nonatomic, strong) NSString *statusTag;
@property (nonatomic, strong) NSString *bdateString;
@property (nonatomic, strong) NSString *edateString;
@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, strong) NSString *statusString;

- (instancetype _Nullable)initWithSubOptions:(NSArray* _Nonnull)subOptions
                           withContainerView:(UIView* _Nonnull)containerView
                             withFilterBlock:(filterRechargeBlock _Nullable)block;
- (void)show;
- (void)hide;
- (void)setTimeDefaultValue:(NSString *)tag and:(NSString *)bdate and:(NSString *)edate;
- (void)setTypeDefaultValue:(NSString *)tag and:(NSString *)type;
- (void)setStatusDefaultValue:(NSString *)tag and:(NSString *)status;

@end
