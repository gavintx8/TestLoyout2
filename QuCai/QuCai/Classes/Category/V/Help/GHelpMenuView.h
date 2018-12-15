//
//  GHelpMenuView.h
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTitleIconAction.h"

typedef void(^HelpMenuBlock)(NSInteger index);

@interface GHelpMenuView : UIView

- (instancetype)initMenu:(NSArray <GTitleIconAction *>*)mens helpMenuBlock:(void(^)(NSInteger index))helpMenuBlock WithLine:(BOOL)line;

@end
