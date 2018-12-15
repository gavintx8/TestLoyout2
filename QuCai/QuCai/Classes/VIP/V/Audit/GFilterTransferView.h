//
//  GFilterView.h
//  QuCai
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^filterTransferBlock) (NSString *bdate,NSString *edate,NSString *type,NSString *ttype,NSString *timeTag,NSString *typeTag,NSString *gameTag);

@interface GFilterTransferView : UIView

@property (nonatomic, strong) NSString *timeTag;
@property (nonatomic, strong) NSString *typeTag;
@property (nonatomic, strong) NSString *gameTag;
@property (nonatomic, strong) NSString *bdateString;
@property (nonatomic, strong) NSString *edateString;
@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, strong) NSString *ttypeString;

- (instancetype _Nullable)initWithSubOptions:(NSArray* _Nonnull)subOptions
                           withContainerView:(UIView* _Nonnull)containerView
                             withFilterBlock:(filterTransferBlock _Nullable)block;
- (void)show;
- (void)hide;
- (void)setTimeDefaultValue:(NSString *)tag and:(NSString *)bdate and:(NSString *)edate;
- (void)setTypeDefaultValue:(NSString *)tag and:(NSString *)type;
- (void)setGameDefaultValue:(NSString *)tag and:(NSString *)game;

@end
