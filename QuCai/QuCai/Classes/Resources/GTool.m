//
//  GTool.m
//  QuCai
//
//  Created by tx gavin on 2017/7/4.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTool.h"

@implementation GTool

+ (NSString *)stringMoneyFamat:(NSString *)number
{
    if([number isEqualToString:@"--"] || [number isEqualToString:@"维护中"] || [number isEqualToString:@"加载中..."]){
        return number;
    }
    if ([number doubleValue] > 0) {
        number = [NSString stringWithFormat:@"%.2f",[number doubleValue]];
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
        numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber *num = [NSNumber numberWithDouble:[number doubleValue]];
        NSString *str = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:num]];
        if ([str rangeOfString:@"."].length > 0) {
            NSString *floatStr = [str componentsSeparatedByString:@"."][1];
            if (floatStr.length == 1) {
                str = [NSString stringWithFormat:@"%@0",str];
            }else{
                str = [str substringToIndex:([str rangeOfString:@"."].location + 3)];
            }
            return [NSString stringWithFormat:@"%@",str];
        }else{
            return [NSString stringWithFormat:@"%@.00",str];
        }
    }else{
        return @"0.00";
    }
}

+ (NSString *)stringChineseFamat:(NSString *)number
{
    NSString *url = [number stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return url;
}

+ (void)clearWkWebCache{
    
    if ([[[UIDevice currentDevice] systemVersion] intValue ] >8) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            NSLog(@"清楚缓存完毕");
        }];
    }else{
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    }
}

/**
 设置状态栏背景颜色
 
 @param color 设置颜色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:text];
    NSUInteger length = [text length];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -20; //设置与尾部的距离
    style.alignment = NSTextAlignmentRight;//靠右显示
    [attrString addAttribute:NSParagraphStyleAttributeName value:style
                       range:NSMakeRange(0, length)];
    label.attributedText = attrString;
}

+(id)dc_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can
{
    CALayer *icon_layer=[anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    
    return anyControl;
}

+(id)dc_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color
{
    if (label.text.length == 0) {
        return 0;
    }
    int i;
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
    for (i = 0; i < label.text.length; i ++) {
        NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
        NSArray *number = arrray;
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(i, 1)];
        }
    }
    label.attributedText = attributeString;
    return label;
}

#pragma mark - 随机数
+ (NSInteger)dc_GetRandomNumber:(NSInteger)StarNum to:(NSInteger)endNum
{
    return (NSInteger)(StarNum + (arc4random() % ((StarNum - endNum )+ 1)));
}

#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)dc_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW {
    
    CGFloat textMaxW = maxW;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:PFR size:textFont]} context:nil].size;
    
    return textSize;
}

#pragma mark - 下划线
+ (void)dc_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color
{
    UIView *cellAcrossPartingLine = [[UIView alloc] init];
    cellAcrossPartingLine.backgroundColor = color;
    [view addSubview:cellAcrossPartingLine];
    
    [cellAcrossPartingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(view);
        make.bottom.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(view.dc_width, 1));
        
    }];
}
#pragma mark - 竖线
+ (void)dc_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;
{
    if (ratio == 0) { // 默认1
        ratio = 1;
    }
    UIView *cellLongLine = [[UIView alloc] init];
    cellLongLine.backgroundColor = color;
    [view addSubview:cellLongLine];
    
    [cellLongLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(1, view.dc_height * ratio));
        
    }];
}
#pragma mark - 首行缩进
+ (void)dc_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen
{
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    
    label.attributedText = attrText;
}

#pragma mark - 设置圆角
+ (void)dc_setUpBezierPathCircularLayerWithControl:(UIButton *)control size:(CGSize)size;
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:control.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft |UIRectCornerTopRight cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = control.bounds;
    maskLayer.path = maskPath.CGPath;
    control.layer.mask = maskLayer;
}

#pragma mark - 字符串加星处理
+ (NSString *)dc_encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex
{
    if (findex <= 0) {
        findex = 2;
    }else if (findex + findex > content.length) {
        findex --;
    }
    return [NSString stringWithFormat:@"%@***%@",[content substringToIndex:findex],[content substringFromIndex:content.length - findex]];
}

+ (NSString *)UTCchangeDate:(NSString *)utc{
    
    NSTimeInterval time = [utc doubleValue]/1000;
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

+ (NSString *)GetCurrentDate{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    return currentDateStr;
}

+ (NSString *)GetLastWeekDate{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval time = 7 * 24 * 60 * 60;
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return  startDate;
}

+ (NSString *)GetLastMonthDate{
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *monthagoData = [self getPriousorLaterDateFromDate:nextDate withMonth:-1];
    NSString *agoString = [dateFormatter stringFromDate:monthagoData];
    return agoString;
}

+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

+ (NSString *)GetCurrentDateTime{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    return currentDateStr;
}

+ (NSString *)GetLastMonthDate2{
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *monthagoData = [self getPriousorLaterDateFromDate:nextDate withMonth:-1];
    NSString *agoString = [dateFormatter stringFromDate:monthagoData];
    return agoString;
}

+ (BOOL)checkCardNo:(NSString*)cardNo{
    if (cardNo.length < 15) {
        return NO;
    }
    int oddsum = 0;
    int evensum = 0;
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10){
                    tmpVal -= 9;
                }
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0){
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)isVaildRealName:(NSString *)realName {
    NSRange range1 = [realName rangeOfString:@"·"];
    NSRange range2 = [realName rangeOfString:@"•"];
    if(range1.location != NSNotFound ||   // 中文 ·
       range2.location != NSNotFound )    // 英文 •
    {
        //一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 15)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
    else
    {
        //一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 8) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSDate*)stringToDate:(NSString*)strDate {
    NSString *dateString = strDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         9          * 移动号段正则表达式
         10          */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         13          * 联通号段正则表达式
         14          */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         17          * 电信号段正则表达式
         18          */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString *)bankCardFormat:(NSString *)string{
    NSString *str = [string stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, string.length)];
    
    // 根据长度计算分组的个数
    NSInteger groupCount = (NSInteger)ceilf((CGFloat)str.length /4);
    NSMutableArray *components = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < groupCount; i++) {
        if (i*4 + 4 > str.length) {
            [components addObject:[str substringFromIndex:i*4]];
        } else {
            NSString * secureStr = [str substringWithRange:NSMakeRange(i*4, 4)];
            //secureStr = [secureStr stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@"****"];
            [components addObject:secureStr];
        }
    }
    NSString *groupedString = [components componentsJoinedByString:@" "];
    return groupedString;
}

@end
