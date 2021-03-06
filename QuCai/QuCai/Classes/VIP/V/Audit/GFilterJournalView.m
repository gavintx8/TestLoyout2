//
//  GFilterView.m
//  QuCai
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GFilterJournalView.h"

@interface GFilterJournalView()<UIGestureRecognizerDelegate>{
    UILabel *endLabel;
    UIButton *endBtuuon;
}

@property (nonatomic,weak) UIView* containerView;
@property (nonatomic,strong) NSArray* subOptions;
@property (nonatomic,weak) UIView* maskView;
@property (nonatomic,weak) UIView* toolBarView;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UIView *choseTimetView;
@property (nonatomic, strong) UIView *sortView;

@end

@implementation GFilterJournalView
{
    filterJournalBlock _journalBlock;
}

- (instancetype _Nullable)initWithSubOptions:(NSArray* _Nonnull)subOptions
                           withContainerView:(UIView* _Nonnull)containerView
                             withFilterBlock:(filterJournalBlock _Nullable)block{
    if (block) {
        _journalBlock = block;
    }
    if ( self = [super init] ){
        self.subOptions = subOptions;
        self.containerView = containerView;
        self.backgroundColor = [UIColor whiteColor];
        
        UIView* maskView = [[UIView alloc] init];
        maskView.backgroundColor = [UIColor clearColor];
        [_containerView addSubview:(_maskView = maskView)];
        
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        tapGesture.delegate = self;
        [maskView addGestureRecognizer:tapGesture];
        
        UIView* toolBarView = [[UIView alloc] init];
        [toolBarView setBackgroundColor:[UIColor whiteColor]];
        [maskView addSubview:(_toolBarView = toolBarView)];
        
        [maskView addSubview:self];
        
        [self createAutoLayout];
        
        self.bdateString = [NSString stringWithFormat:@"%@ 00:00:00",[GTool GetCurrentDate]];
        self.edateString = [NSString stringWithFormat:@"%@ 23:59:59",[GTool GetCurrentDate]];
        self.typeString = @"0";
        
        [self buildTimeView:self];
        [self buildChoseTimeView:self];
        [self buildSortView:self];
    }
    return self;
}

- (void)buildTimeView:(UIView *)view{
    UILabel *lblTime = [self createSectionLabelTitle:@"    时间"];
    [view addSubview:lblTime];
    [lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(20+64);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(40);
    }];
    
    self.timeView = [[UIView alloc] init];
    [self.timeView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblTime.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(70);
    }];
    
    UIButton *btnToday = [self createButtonTag:@" 今  天 " and:301];
    [btnToday setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnToday setBackgroundColor:BG_Nav];
    [self.timeView addSubview:btnToday];
    [btnToday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_top).offset(20);
        make.left.equalTo(self.timeView.mas_left).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    UIButton *btnHebdomad = [self createButtonTag:@" 一  周 " and:302];
    [self.timeView addSubview:btnHebdomad];
    [btnHebdomad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_top).offset(20);
        make.left.equalTo(btnToday.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    UIButton *btnAmonth = [self createButtonTag:@" 一 个 月 " and:303];
    [self.timeView addSubview:btnAmonth];
    [btnAmonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_top).offset(20);
        make.left.equalTo(btnHebdomad.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    UIButton *btnCustom = [self createButtonTag:@" 自 定 义 " and:304];
    [self.timeView addSubview:btnCustom];
    [btnCustom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_top).offset(20);
        make.left.equalTo(btnAmonth.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
}

- (void)setTimeDefaultValue:(NSString *)tag and:(NSString *)bdate and:(NSString *)edate{
    self.bdateString = bdate;
    self.edateString = edate;
    if ([tag intValue] > 301) {
        UIButton *btn1 = [self viewWithTag:301];
        [btn1 setBackgroundColor:[UIColor whiteColor]];
        [btn1 setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
        self.timeTag = tag;
        UIButton *btn2 = [self viewWithTag:[tag integerValue]];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 setBackgroundColor:BG_Nav];
    }
    if([tag isEqualToString:@"304"]){
        [self.choseTimetView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
        }];
        
        UIButton *btn1 = [self viewWithTag:901];
        [btn1 setTitle:[self.bdateString substringToIndex:10] forState:UIControlStateNormal];
        
        UIButton *btn2 = [self viewWithTag:902];
        [btn2 setTitle:[self.edateString substringToIndex:10] forState:UIControlStateNormal];
    }
}

- (UILabel *)createSectionLabelTitle:(NSString *)title{
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.adjustsFontSizeToFitWidth =YES;
    [lbl setText:title];
    [lbl setFont:[UIFont boldSystemFontOfSize:15.f]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    [lbl setTextColor:[UIColor colorWithRed:114.0/255 green:114.0/255 blue:114.0/255 alpha:1]];
    return lbl;
}

- (UIButton *)createButtonTag:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    [GTool dc_chageControlCircularWith:btn AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
    [btn addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)timeButtonClick:(UIButton *)button{
    for (int i = 301; i < 305; i++) {
        if (button.tag == i) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:BG_Nav];
        }else{
            UIButton *myButton = [self viewWithTag:i];
            [myButton setBackgroundColor:[UIColor whiteColor]];
            [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
        }
    }
    if (button.tag == 304) {
        [self.choseTimetView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(90);
        }];
        endLabel.hidden = NO;
        endBtuuon.hidden = NO;
    }else{
        [self.choseTimetView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if(button.tag == 301){
        self.bdateString = [NSString stringWithFormat:@"%@ 00:00:00",[GTool GetCurrentDate]];
        self.edateString = [NSString stringWithFormat:@"%@ 23:59:59",[GTool GetCurrentDate]];
    }else if(button.tag == 302){
        self.bdateString = [NSString stringWithFormat:@"%@ 00:00:00",[GTool GetLastWeekDate]];
        self.edateString = [NSString stringWithFormat:@"%@ 23:59:59",[GTool GetCurrentDate]];
    }else if(button.tag == 303){
        self.bdateString = [NSString stringWithFormat:@"%@ 00:00:00",[GTool GetLastMonthDate]];
        self.edateString = [NSString stringWithFormat:@"%@ 23:59:59",[GTool GetCurrentDate]];
    }
    self.timeTag = [NSString stringWithFormat:@"%ld",button.tag];
}

- (void)buildChoseTimeView:(UIView *)view{
    
    self.choseTimetView = [[UIView alloc] init];
    [view addSubview:self.choseTimetView];
    [self.choseTimetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(0);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.choseTimetView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseTimetView);
        make.left.right.equalTo(self.choseTimetView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *startLabel = [[UILabel alloc] init];
    [startLabel setFont:[UIFont systemFontOfSize:14.f]];
    [startLabel setText:@"起始时间"];
    [startLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.choseTimetView addSubview:startLabel];
    [startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseTimetView).offset(20);
        make.left.equalTo(self.choseTimetView).offset(60);
        make.width.mas_equalTo(80);
    }];
    
    endLabel = [[UILabel alloc] init];
    endLabel.hidden = YES;
    [endLabel setFont:[UIFont systemFontOfSize:14.f]];
    [endLabel setText:@"截止时间"];
    [endLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.choseTimetView addSubview:endLabel];
    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseTimetView).offset(20);
        make.right.equalTo(self.choseTimetView).offset(-40);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *startButton = [self createButtonTag3:[NSDate currentDateString] and:901];
    [self.choseTimetView addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseTimetView).offset(40);
        make.left.equalTo(self.choseTimetView).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
    
    endBtuuon = [self createButtonTag3:[NSDate currentDateString] and:902];
    endBtuuon.hidden = YES;
    [self.choseTimetView addSubview:endBtuuon];
    [endBtuuon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseTimetView).offset(40);
        make.right.equalTo(self.choseTimetView).offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
}

- (UIButton *)createButtonTag3:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    [GTool dc_chageControlCircularWith:btn AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
    [btn addTarget:self action:@selector(choseTimeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)choseTimeButtonClick:(UIButton *)button{
    for (int i = 901; i < 903; i++) {
        if (button.tag == i) {
            [GTool dc_chageControlCircularWith:button AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:BG_Nav canMasksToBounds:YES];
        }else{
            UIButton *myButton = [self viewWithTag:i];
            [GTool dc_chageControlCircularWith:myButton AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
        }
    }
    if (button.tag == 901) {
        [BRDatePickerView showDatePickerWithTitle:@"起始时间" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:[GTool GetLastMonthDate2] maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
            [button setTitle:selectValue forState:UIControlStateNormal];
            NSString *tempStr1 = [selectValue stringByReplacingOccurrencesOfString:@"日" withString:@""];
            NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            self.bdateString = [NSString stringWithFormat:@"%@ 00:00:00",[tempStr2 stringByReplacingOccurrencesOfString:@"月" withString:@"-"]];
        }];
    }else{
        [BRDatePickerView showDatePickerWithTitle:@"截止时间" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:[GTool GetLastMonthDate2] maxDateStr:[NSDate currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
            [button setTitle:selectValue forState:UIControlStateNormal];
            NSString *tempStr1 = [selectValue stringByReplacingOccurrencesOfString:@"日" withString:@""];
            NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
            self.edateString = [NSString stringWithFormat:@"%@ 23:59:59",[tempStr2 stringByReplacingOccurrencesOfString:@"月" withString:@"-"]];
        }];
    }
}

- (void)buildSortView:(UIView *)view{
    UILabel *lblSort = [self createSectionLabelTitle:@"    分类"];
    [view addSubview:lblSort];
    [lblSort mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choseTimetView.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(40);
    }];
    
    self.sortView = [[UIView alloc] init];
    [self.sortView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:self.sortView];
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblSort.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(110);
    }];
    
    UIButton *sortButton1 = [self createButtonTag2:@"全部" and:401];
    [sortButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sortButton1 setBackgroundColor:BG_Nav];
    [self.sortView addSubview:sortButton1];
    [sortButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_top).offset(20);
        make.left.equalTo(self.sortView.mas_left).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(35);
    }];
    
    UIButton *sortButton2 = [self createButtonTag2:@"加款" and:402];
    [self.sortView addSubview:sortButton2];
    [sortButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_top).offset(20);
        make.left.equalTo(sortButton1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(35);
    }];
    
    UIButton *sortButton3 = [self createButtonTag2:@"扣款" and:403];
    [self.sortView addSubview:sortButton3];
    [sortButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_top).offset(20);
        make.left.equalTo(sortButton2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(35);
    }];
    
    UIButton *sortButton4 = [self createButtonTag2:@"彩金" and:404];
    [self.sortView addSubview:sortButton4];
    [sortButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_top).offset(20);
        make.left.equalTo(sortButton3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(35);
    }];
    
    UIButton *sortButton5 = [self createButtonTag2:@"优惠" and:405];
    [self.sortView addSubview:sortButton5];
    [sortButton5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_top).offset(20);
        make.left.equalTo(sortButton4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(35);
    }];
    
    UIButton *sortButton6 = [self createButtonTag2:@"提款" and:406];
    [self.sortView addSubview:sortButton6];
    [sortButton6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_top).offset(20);
        make.left.equalTo(sortButton5.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(35);
    }];
    
    if(SCREEN_WIDTH < 400) {
        [self.sortView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(110 + 40);
        }];
        
        UIButton *sortButton7 = [self createButtonTag2:@"反水" and:407];
        [self.sortView addSubview:sortButton7];
        [sortButton7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sortButton1.mas_bottom).offset(10);
            make.left.equalTo(self.sortView.mas_left).offset(20);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(35);
        }];
    }else{
        UIButton *sortButton7 = [self createButtonTag2:@"反水" and:407];
        [self.sortView addSubview:sortButton7];
        [sortButton7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sortView.mas_top).offset(20);
            make.left.equalTo(sortButton6.mas_right).offset(10);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(35);
        }];
    }
    
    if ([self.typeTag intValue] > 401) {
        [sortButton1 setBackgroundColor:[UIColor whiteColor]];
        
        UIButton *btn = [self viewWithTag:[self.typeTag integerValue]];
        [btn setBackgroundColor:BG_Nav];
    }
    
    UILabel *lblBottom = [self createSectionLabelTitle:@""];
    [self.sortView addSubview:lblBottom];
    [lblBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sortView);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundColor:BG_Nav];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_bottom).offset(20);
        make.centerX.equalTo(view);
        make.width.equalTo(@200);
        make.height.mas_equalTo(42);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTypeDefaultValue:(NSString *)tag and:(NSString *)type{
    self.typeString = type;
    if ([tag intValue] > 401) {
        UIButton *btn1 = [self viewWithTag:401];
        [btn1 setBackgroundColor:[UIColor whiteColor]];
        [btn1 setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
        self.typeTag = tag;
        UIButton *btn2 = [self viewWithTag:[tag integerValue]];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 setBackgroundColor:BG_Nav];
    }
}

- (void)nextButtonClick:(UIButton *)button{
    if (_journalBlock) {
        _journalBlock(self.bdateString,self.edateString,self.typeString,self.timeTag,self.typeTag);
        [self hide];
    }
}

- (UIButton *)createButtonTag2:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    [GTool dc_chageControlCircularWith:btn AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
    [btn addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)sortButtonClick:(UIButton *)button{
    for (int i = 401; i < 408; i++) {
        if (button.tag == i) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:BG_Nav];
        }else{
            UIButton *myButton = [self viewWithTag:i];
            [myButton setBackgroundColor:[UIColor whiteColor]];
            [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
        }
    }
    if (button.tag == 401) {
        self.typeString = @"0";
    }else if (button.tag == 402) {
        self.typeString = @"1";
    }else if (button.tag == 403) {
        self.typeString = @"2";
    }else if (button.tag == 404) {
        self.typeString = @"3";
    }else if (button.tag == 405) {
        self.typeString = @"4";
    }else if (button.tag == 406) {
        self.typeString = @"5";
    }else if (button.tag == 407) {
        self.typeString = @"6";
    }
    self.typeTag = [NSString stringWithFormat:@"%ld",button.tag];
}

- (void)createAutoLayout{
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.left.equalTo(self.maskView.mas_left).offset(self.containerView.frame.size.width);
        make.height.mas_equalTo(45);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(self.toolBarView.mas_left);
        make.bottom.equalTo(self.toolBarView.mas_top);
        make.right.equalTo(self.toolBarView.mas_right);
    }];
    
    UIView* toolBarLine = [[UIView alloc] init];
    [_toolBarView addSubview:toolBarLine];
    [toolBarLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
}

- (void)show{
    self.maskView.hidden = NO;
    [UIView animateWithDuration:0.1 animations:^{
        self.maskView.backgroundColor = [UIColor colorWithWhite:0.25 alpha:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75     /*动画时长*/
                              delay:0.0     /*动画延时*/
             usingSpringWithDamping:0.75    /*弹簧效果*/
              initialSpringVelocity:0    /*弹簧速度*/
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             [self.toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.left.equalTo(self.maskView.mas_left).offset(60);
                             }];
                             [self.maskView layoutIfNeeded];
                         } completion:nil];
    }];
}

- (void)hide{
    [self.toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.maskView.mas_left).offset(self.containerView.frame.size.width);
    }];
    self.maskView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    [self.maskView layoutIfNeeded];
    self.maskView.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ( [touch.view isEqual:_maskView] ){
        [self hide];
    }
    return YES;
}

@end
