//
//  GTool.h
//  QuCai
//
//  Created by tx gavin on 2017/7/4.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTool : NSObject

+ (NSString *)stringMoneyFamat:(NSString *)number;

+ (NSString *)stringChineseFamat:(NSString *)number;

+ (void)clearWkWebCache;

+ (void)setStatusBarBackgroundColor:(UIColor *)color;


/**
 文字靠右显示 并且 文字尾部距UILabel有一定的距离
 */
+ (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text;

/**
 设置按钮的圆角
 
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+(id)dc_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can;

/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+(id)dc_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color;

#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)dc_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW ;

/**
 下划线
 
 @param view 下划线
 */
+ (void)dc_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color;

/**
 竖线线
 
 @param view 竖线线
 */
+ (void)dc_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;

/**
 利用贝塞尔曲线设置圆角
 
 @param control 按钮
 @param size 圆角尺寸
 */
+ (void)dc_setUpBezierPathCircularLayerWithControl:(UIButton *)control size:(CGSize)size;

/**
 label首行缩进
 
 @param label label
 @param emptylen 缩进比
 */
+ (void)dc_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen;

/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)dc_encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex;

/**
 取随机数
 
 @param StarNum 开始值
 @param endNum 结束值
 @return 从开始值到结束值之间的随机数
 */
+ (NSInteger)dc_GetRandomNumber:(NSInteger)StarNum to:(NSInteger)endNum;

+ (NSString *)UTCchangeDate:(NSString *)utc;
//获取当前日期
+ (NSString *)GetCurrentDate;
//获取一周前日期
+ (NSString *)GetLastWeekDate;
//获取一个月前日期
+ (NSString *)GetLastMonthDate;
+ (NSString *)GetLastMonthDate2;
//获取当前日期和时间
+ (NSString *)GetCurrentDateTime;
//银行卡号判断
+ (BOOL)checkCardNo:(NSString*)cardNo;
//判断是否是中文名字
+ (BOOL)isVaildRealName:(NSString *)realName;
//根据传入的日期判断是星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
//时间字符串转日期
+ (NSDate*)stringToDate:(NSString*)strDate;
//判断手机号码格式
+ (BOOL)valiMobile:(NSString *)mobile;
//获取当前时间戳
+ (NSString *)currentTimeStr;
/*
 * 输入银行卡号，没四个数字后面加上“ ”
 */
+ (NSString *)bankCardFormat:(NSString *)string;

@end
