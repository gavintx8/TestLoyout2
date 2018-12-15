//
//  GTabBar.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTabBar.h"
#import <objc/runtime.h>

#define LBMagin 10

@interface GTabBar ()

@property (nonatomic,assign)UIEdgeInsets oldSafeAreaInsets;

@end

@implementation GTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
            
            [plusBtn setImage:[UIImage imageNamed:TABBAR_PURCHASE_ICON] forState:UIControlStateNormal];
            [plusBtn setImage:[UIImage imageNamed:TABBAR_PURCHASE_ICON] forState:UIControlStateHighlighted];
        } else {
            [plusBtn setImage:[UIImage imageNamed:@"di_cunkuan"] forState:UIControlStateNormal];
            [plusBtn setImage:[UIImage imageNamed:@"di_cunkuan"] forState:UIControlStateHighlighted];
        }
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarNm) name:@"changeTabBarName" object:nil];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.plusBtn.centerX = self.centerX;
    //调整发布按钮的中线点Y值
    if (KIsiPhoneX) {
        self.plusBtn.centerY = self.sz_height * 0.5 - 2*LBMagin - 6 ;
    } else {
        self.plusBtn.centerY = self.sz_height * 0.5 - LBMagin;
    }
    
    self.plusBtn.sz_width = 65;
    self.plusBtn.sz_height = 85;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        
        [self.plusBtn setTitle:@"注册" forState:UIControlStateNormal];
        [self.plusBtn setImage:[UIImage imageNamed:@"di_zhuce"] forState:UIControlStateNormal];
        [self.plusBtn setImage:[UIImage imageNamed:@"di_zhuce"] forState:UIControlStateHighlighted];
    } else {
        [self.plusBtn setTitle:@"存款" forState:UIControlStateNormal];
        [self.plusBtn setImage:[UIImage imageNamed:@"di_cunkuan"] forState:UIControlStateNormal];
        [self.plusBtn setImage:[UIImage imageNamed:@"di_cunkuan_pre"] forState:UIControlStateHighlighted];
    }
    
    self.plusBtn.titleLabel.font = TXT_SIZE_14;
    [self.plusBtn setTitleColor:BG_Nav forState:UIControlStateNormal];
    [self verticalImageAndTitle:8.0];
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.sz_width = self.sz_width / 5;
            
            btn.sz_x = btn.sz_width * btnIndex;
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.plusBtn];
}

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.plusBtn.imageView.frame.size;
    CGSize titleSize = self.plusBtn.titleLabel.frame.size;
    CGSize textSize = [self.plusBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.plusBtn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.plusBtn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.plusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

- (void)changeTabBarNm {
    
    [self.plusBtn setTitle:@"存款" forState:UIControlStateNormal];
    [self.plusBtn setImage:[UIImage imageNamed:@"di_cunkuan"] forState:UIControlStateNormal];
    [self.plusBtn setImage:[UIImage imageNamed:@"di_cunkuan_pre"] forState:UIControlStateHighlighted];
    
}

//点击了发布按钮
- (void)plusBtnDidClick
{
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusClick:)]) {
        [self.myDelegate tabBarPlusClick:self];
    }
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}


- (void) safeAreaInsetsDidChange
{
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
       self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
       self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
       self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom)
    {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
    
}

- (CGSize) sizeThatFits:(CGSize) size
{
    CGSize s = [super sizeThatFits:size];
    if(@available(iOS 11.0, *))
    {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if( bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}

@end
