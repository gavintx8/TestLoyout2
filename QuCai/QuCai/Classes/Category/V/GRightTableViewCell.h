//
//  GRightTableViewCell.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

// 这个 block 用于回调当前点击 cell 的行数
typedef void(^handleEnterGameButtonBlock)(NSInteger index);

@interface GRightTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imv1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *enterGameButton;
@property (nonatomic, copy) handleEnterGameButtonBlock clickEnterGameBlock;

- (void)clickEnterGameWithBlock:(handleEnterGameButtonBlock)clickEnterGameBlock;

@end
