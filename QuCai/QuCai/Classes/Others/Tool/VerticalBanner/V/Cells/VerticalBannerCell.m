//
//  VerticalBannerCell.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "VerticalBannerCell.h"
#import "VerticalBannerView.h"
#import "GHomePageVc.h"
static NSString* const ViewTableViewCellId=@"ViewTableViewCellId";

@interface VerticalBannerCell()<VerticalScrolDelegate>

@property (nonatomic, strong)VerticalBannerView *verticalBannerView;
@property (nonatomic, strong) NSMutableArray *annAry ;
@property (nonatomic, strong) GHomePageVc *homePageVc ;
@property (nonatomic, strong) UIView *contentV ;
@property (nonatomic, strong) UIView *tipView;

@end

@implementation VerticalBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    [self setupUi];
}

#pragma mark - 懒加载
- (VerticalBannerView *)verticalBannerView{
    if (!_verticalBannerView) {
        _verticalBannerView = [[VerticalBannerView alloc] initWithFrame:CGRectMake(mycommonEdge, mycommonEdge, SCREEN_WIDTH - mycommonEdge*2 , 23.33)];
         _verticalBannerView.scrolDelegate = self;
    }
    return _verticalBannerView;
}

- (void)verticalBannerViewF{

    [_verticalBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.mas_trailing).offset(0);
        make.bottom.mas_equalTo(self);
    }];
}

#pragma mark - 设置UI

- (void)setupUi{

    [self.contentView addSubview:self.verticalBannerView];
    [self verticalBannerViewF];
    [self loadData];
}

- (void)loadData {
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
    self.annAry = [NSMutableArray array];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kAnnouncement RequestWay:kPOST withParamters:dic1 withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if (responseObject != nil) {
            NSMutableArray *ary = responseObject;
            for (int i = 0; i < ary.count; i++) {
                NSDictionary *dict = ary[i];
                if ([[dict objectForKey:@"src1"] isEqualToString:[[SZUser shareUser] readSrc1Link]]) {
                    [self.annAry addObject:ary[i][@"rmk"]];
                }
            }
            [self.verticalBannerView reloadData:self.annAry];
            [[NSUserDefaults standardUserDefaults] setObject:self.annAry forKey:@"localGonGaoAry"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSError *error) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        self.annAry = [def objectForKey:@"localGonGaoAry"];
        [self.verticalBannerView reloadData:self.annAry];
    }];
}

//获取控制器
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark  - delegate

- (void)verticalBannerView:(VerticalBannerView *)scrol didSelectedImgWithRow:(NSInteger)row{
    GHomePageVc *homePageVc = (GHomePageVc *)[self viewController];
    self.homePageVc = homePageVc;
    UIView *contentView = [GUIHelper getViewWithColor:[UIColor blackColor]];
    self.contentV = contentView;
    contentView.alpha = 0.4;
    [homePageVc.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(homePageVc.view);
    }];
    
    UIView *tipView = [GUIHelper getViewWithColor:[UIColor colorWithHexStr:@"#f2f2f2"]];
    self.tipView = tipView;
    tipView.alpha = 1.0;
    tipView.layer.cornerRadius = 5;
    tipView.layer.masksToBounds = YES;
    [self.homePageVc.view insertSubview:tipView aboveSubview:contentView];
    [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.homePageVc.view.mas_left).offset(19);
        make.right.equalTo(self.homePageVc.view.mas_right).offset(-19);
        make.centerY.equalTo(self.homePageVc.view);
        make.height.mas_equalTo(H(180));
    }];
    
    UILabel *label1 = [GUIHelper getLabel:@"提示:" andFont:TXT_SIZE_17 andTextColor:[UIColor colorWithHexStr:@"#303133"]];
    [tipView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).offset(15);
        make.left.equalTo(tipView.mas_left).offset(15);
    }];
    
    UIButton *closeBtn = [GUIHelper getButtonWithImage:[UIImage imageNamed:@"login_back"]];
    [tipView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipView.mas_top).offset(17);
        make.right.equalTo(tipView.mas_right).offset(-17);
        make.height.width.mas_equalTo(15);
    }];
    [closeBtn addTarget:self action:@selector(closeTipView) forControlEvents:UIControlEventTouchUpInside];    
    
    UILabel *label2 = [GUIHelper getLabel:nil andFont:TXT_SIZE_13 andTextColor:[UIColor colorWithHexStr:@"#606266"]];
    [tipView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(18);
        make.left.equalTo(tipView.mas_left).offset(15);
        make.right.equalTo(tipView.mas_right).offset(-15);
    }];
    label2.text = self.annAry[row];
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label2.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label2.text length])];
    label2.attributedText = attributedString;
    CGSize labelSize = [label2 sizeThatFits:CGSizeMake(ScreenW - 30, MAXFLOAT)];
    CGFloat height = ceil(labelSize.height) + 1;
    
    [tipView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100 + height);
    }];
    
    UIButton *submmit = [GUIHelper getButton:@"确定" titleColor:[UIColor colorWithHexStr:@"#ffffff"] font:TXT_SIZE_12];
    submmit.backgroundColor = [UIColor colorWithHexStr:@"#d62f27"];
    [tipView addSubview:submmit];
    [submmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tipView.mas_right).offset(-15);
        make.bottom.equalTo(tipView.mas_bottom).offset(-10);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(32);
    }];
    submmit.layer.cornerRadius = 5;
    submmit.layer.masksToBounds = YES;
    [submmit addTarget:self action:@selector(closeTipView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeTipView {
    
    [self.contentV removeFromSuperview];
    [self.tipView removeFromSuperview];
}

#pragma mark - 数据改变

#pragma mark - 类方法

+ (NSString*) cellId{
    
    return ViewTableViewCellId;
}

@end
