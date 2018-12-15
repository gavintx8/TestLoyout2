//
//  GEEContainerVc.m
//  QuCai
//
//  Created by tx gavin on 2017/6/26.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GEEContainerVc.h"
#import "GEECollectionViewCell.h"
#import "GEECollectionHeadView.h"
#import "GTransferAccounts.h"
#import "UIView+Gradient.h"

@interface GEEContainerVc ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *ary1;
@property (nonatomic, strong) NSMutableArray *searchArr;
@property (nonatomic, strong) NSDictionary *dicts;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UITextField *txtSearch;
@property (nonatomic, assign) NSInteger searchFlag;
@property (nonatomic, strong) UIView *backView;

@end

@implementation GEEContainerVc

- (void)onCreate {
    
    self.navigationItem.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self createUI];
        [SVProgressHUD dismiss];
    });
}

- (void)onWillShow {
    
}

- (void)onWillDisappear {
    
}

- (void)createUI{
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    self.headView = [[UIView alloc] init];
    [self.contentView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(130);
    }];
    
    [self initHeadView];
    
    
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    
    if (self.geeType == GEETypeMG) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MGDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏",@"老虎机",@"累计奖池",@"视频",@"桌面",@"机台&卡牌", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"BonusSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"ClassicSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"FeatureSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"VideoSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"VideoPoker"]];
        
    }else if (self.geeType == GEETypeHB) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HBDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏",@"桌面",@"老虎机", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Slot_Game"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Table_Game"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
        
    }else if (self.geeType == GEETypePS) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PSDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
    }else if (self.geeType == GEETypeJDB) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JDBDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"老虎机",@"捕鱼机",@"水果机", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"BonusSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"ClassicSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"FeatureSlot"]];
    }else if (self.geeType == GEETypeSW) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SWDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
    }
    
    [self.contentView addSubview:self.collectionV];
    NSInteger heightCV = 0;
    if (self.geeType == GEETypeMG) {
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count) + 130 * 2;
    }else if(self.geeType == GEETypeJDB){
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count);
    }else if(self.geeType == GEETypeSW){
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count);
    }else{
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count) + 130;
    }
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(heightCV);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collectionV);
    }];
    self.searchFlag = 0;
}

- (void)initHeadView {
    
    self.headView.backgroundColor = [UIColor blackColor];
    UIImageView *imv = [[UIImageView alloc] init];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    [self.headView addSubview:imv];
    if (self.geeType == GEETypeMG) {
        imv.image = [UIImage imageNamed:@"microgaming"];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_top).offset(37);
            make.left.equalTo(self.headView).offset(14);
        }];
    }else if (self.geeType == GEETypeHB) {
        imv.image = [UIImage imageNamed:@"HABA1"];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_top).offset(37);
            make.left.equalTo(self.headView).offset(15);
            
        }];
    }else if (self.geeType == GEETypePS) {
        imv.image = [UIImage imageNamed:@"psgame"];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_top).offset(30);
            make.left.equalTo(self.headView).offset(-30);
            make.width.mas_offset(230);
            make.height.mas_offset(46);
        }];
    }else if (self.geeType == GEETypeJDB) {
        imv.image = [UIImage imageNamed:@"jdbgame"];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_top).offset(30);
            make.left.equalTo(self.headView).offset(-30);
            make.width.mas_offset(239);
            make.height.mas_offset(50);
        }];
    }else if (self.geeType == GEETypeSW) {
        imv.image = [UIImage imageNamed:@"swgame"];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_top).offset(30);
            make.left.equalTo(self.headView).offset(-30);
            make.width.mas_offset(243);
            make.height.mas_offset(50);
        }];
    }
    
    self.txtSearch = [[UITextField alloc] init];
    NSString *holderText = @"搜索";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor lightGrayColor]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.txtSearch.attributedPlaceholder = placeholder;
    self.txtSearch.textColor = [UIColor whiteColor];
    self.txtSearch.backgroundColor = [UIColor colorWithRed:29.0/255 green:30.0/255 blue:31.0/255 alpha:1];
    self.txtSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    self.txtSearch.leftViewMode = UITextFieldViewModeAlways;
    [self.headView addSubview:self.txtSearch];
    if (self.geeType == GEETypeMG) {
        [self.txtSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(35);
        }];
    }else if (self.geeType == GEETypeHB) {
        [self.txtSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imv.mas_bottom).offset(-5);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(35);
        }];
    }else if (self.geeType == GEETypePS) {
        [self.txtSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(30);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(35);
        }];
    }else if (self.geeType == GEETypeJDB) {
        [self.txtSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(30);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(35);
        }];
    }else if (self.geeType == GEETypeSW) {
        [self.txtSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(30);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(35);
        }];
    }
    self.txtSearch.layer.cornerRadius = 17;
    self.txtSearch.layer.masksToBounds = YES;
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"search_fangdajing"] forState:UIControlStateNormal];
    [self.headView addSubview:searchBtn];
    if (self.geeType == GEETypeMG) {
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(8);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }else if (self.geeType == GEETypeHB) {
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imv.mas_bottom).offset(-11);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }else if (self.geeType == GEETypePS) {
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(38);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }else if (self.geeType == GEETypeJDB) {
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(38);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }else if (self.geeType == GEETypeSW) {
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imv.mas_bottom).offset(38);
            make.right.equalTo(self.headView).offset(-15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }
    [searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(id)sender{
    
    if (![self.txtSearch.text isEqualToString:@""]) {
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        self.searchArr = [[NSMutableArray alloc] init];
        
        if (self.geeType == GEETypeMG) {
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"BonusSlot"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"ClassicSlot"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"FeatureSlot"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"VideoSlot"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"VideoPoker"]];
        }else if (self.geeType == GEETypeHB) {
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"Slot_Game"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"Table_Game"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
        }else if (self.geeType == GEETypePS) {
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
        }else if (self.geeType == GEETypeJDB) {
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"BonusSlot"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"ClassicSlot"]];
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"FeatureSlot"]];
        }else if (self.geeType == GEETypeSW) {
            [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
        }
        
        for (int i=0; i<arrs.count; i++) {
            
            if([[arrs[i] objectForKey:@"title"] rangeOfString:self.txtSearch.text].location != NSNotFound){
                
                [self.searchArr addObject:arrs[i]];
            }
        }
        if(self.searchArr.count == 0){
            self.txtSearch.text = @"";
            [SVProgressHUD showInfoWithStatus:@"没有查找到相关游戏"];
            [SVProgressHUD dismissWithDelay:1];
            return;
        }
        if ([self.searchArr count] > 0) {
            self.searchFlag = 1;
            
            self.backView = [[UIView alloc] init];
            [self.backView setGradientBackgroundWithColors:@[[UIColor colorWithRed:40.0/255 green:213.0/255 blue:60.0/255 alpha:1],[UIColor colorWithRed:42.0/255 green:173.0/255 blue:194.0/255 alpha:1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
            [self.contentView addSubview:self.backView];
            [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headView.mas_bottom);
                make.left.right.equalTo(self.contentView);
                make.height.mas_equalTo(50);
            }];
            
            UIButton *backBtn = [[UIButton alloc] init];
            [backBtn setImage:[UIImage imageNamed:@"gicon_back"] forState:UIControlStateNormal];
            [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.backView addSubview:backBtn];
            [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.backView.mas_top);
                make.leading.offset(1);
                make.width.mas_equalTo(56);
                make.height.mas_equalTo(48);
            }];
            [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.collectionV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((self.searchArr.count / 3) * 135 + 260);
            }];
            self.view.backgroundColor = [UIColor blackColor];
            [self.collectionV reloadData];
        }
    }
    [self.txtSearch resignFirstResponder];
}

- (void)backClick:(id)sender{
    [self.backView removeFromSuperview];
    self.txtSearch.text = @"";
    self.searchFlag = 0;
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    
    if (self.geeType == GEETypeMG) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MGDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏",@"老虎机",@"累计奖池",@"视频",@"桌面",@"机台&卡牌", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"BonusSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"ClassicSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"FeatureSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"VideoSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"VideoPoker"]];
        
    }else if (self.geeType == GEETypeHB) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HBDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏",@"桌面",@"老虎机", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Slot_Game"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Table_Game"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
        
    }else if (self.geeType == GEETypePS) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PSDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
    }else if (self.geeType == GEETypeJDB) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JDBDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"老虎机",@"捕鱼机",@"水果机", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"BonusSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"ClassicSlot"]];
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"FeatureSlot"]];
    }else if (self.geeType == GEETypeSW) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SWDZList" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.dicts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.ary1 = [NSMutableArray arrayWithObjects:@"热门游戏", nil];
        
        [arrs addObjectsFromArray:[self.dicts objectForKey:@"Video_Poker"]];
    }
    NSInteger heightCV = 0;
    if (self.geeType == GEETypeMG) {
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count) + 130 * 2;
    }else if(self.geeType == GEETypeJDB){
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count);
    }else if(self.geeType == GEETypeSW){
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count);
    }else{
        heightCV = (arrs.count / 3) * 130 + (50 * self.dicts.count) + 130;
    }
    [self.collectionV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightCV);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionV reloadData];
}

- (UICollectionView *)collectionV {
    
    if (_collectionV == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/4+20, 130);
        [_collectionV registerClass:[GEECollectionViewCell class] forCellWithReuseIdentifier:@"eeViewCell"];
        _collectionV.backgroundColor = [UIColor colorWithRed:15/255 green:15/255 blue:15/255 alpha:1];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.scrollEnabled = NO;
        [_collectionV registerClass:[GEECollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    }
    return _collectionV;
}

#pragma mark -—————————— UICollectionView Delegate And DataSource ——————————
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.geeType == GEETypeMG) {
        if (self.searchFlag == 0) {
            NSArray *arrs = [[NSArray alloc] init];
            if (0 == section) {
                arrs = [self.dicts objectForKey:@"BonusSlot"];
            }else if (1 == section) {
                arrs = [self.dicts objectForKey:@"ClassicSlot"];
            }else if (2 == section) {
                arrs = [self.dicts objectForKey:@"FeatureSlot"];
            }else if (3 == section) {
                arrs = [self.dicts objectForKey:@"Video"];
            }else if (4 == section) {
                arrs = [self.dicts objectForKey:@"VideoSlot"];
            }else if (5 == section) {
                arrs = [self.dicts objectForKey:@"VideoPoker"];
            }
            return arrs.count;
        }else{
            return self.searchArr.count;
        }
    }else if (self.geeType == GEETypeHB) {
        if (self.searchFlag == 0) {
            NSArray *arrs = [[NSArray alloc] init];
            if (0 == section) {
                arrs = [self.dicts objectForKey:@"Slot_Game"];
            }else if (1 == section) {
                arrs = [self.dicts objectForKey:@"Table_Game"];
            }else if (2 == section) {
                arrs = [self.dicts objectForKey:@"Video_Poker"];
            }
            return arrs.count;
        }else{
            return self.searchArr.count;
        }
    }else if (self.geeType == GEETypePS) {
        if (self.searchFlag == 0) {
            NSArray *arrs = [[NSArray alloc] init];
            if (0 == section) {
                arrs = [self.dicts objectForKey:@"Video_Poker"];
            }
            return arrs.count;
        }else{
            return self.searchArr.count;
        }
    }else if (self.geeType == GEETypeJDB) {
        if (self.searchFlag == 0) {
            NSArray *arrs = [[NSArray alloc] init];
            if (0 == section) {
                arrs = [self.dicts objectForKey:@"BonusSlot"];
            }else if (1 == section) {
                arrs = [self.dicts objectForKey:@"ClassicSlot"];
            }else if (2 == section) {
                arrs = [self.dicts objectForKey:@"FeatureSlot"];
            }
            return arrs.count;
        }else{
            return self.searchArr.count;
        }
    }else if (self.geeType == GEETypeSW) {
        if (self.searchFlag == 0) {
            NSArray *arrs = [[NSArray alloc] init];
            if (0 == section) {
                arrs = [self.dicts objectForKey:@"Video_Poker"];
            }
            return arrs.count;
        }else{
            return self.searchArr.count;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.searchFlag == 0) {
        return self.dicts.count;
    }else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"eeViewCell";
    GEECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    NSArray *arrs = [[NSArray alloc] init];
    
    if (self.geeType == GEETypeMG) {
        if (self.searchFlag == 0) {
            if (0 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"BonusSlot"];
            }else if (1 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"ClassicSlot"];
            }else if (2 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"FeatureSlot"];
            }else if (3 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"Video"];
            }else if (4 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"VideoSlot"];
            }else if (5 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"VideoPoker"];
            }
        }else{
            arrs = [self.searchArr copy];
        }
    }else if (self.geeType == GEETypeHB) {
        if (self.searchFlag == 0) {
            if (0 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"Slot_Game"];
            }else if (1 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"Table_Game"];
            }else if (2 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"Video_Poker"];
            }
        }else{
            arrs = [self.searchArr copy];
        }
    }else if (self.geeType == GEETypePS) {
        if (self.searchFlag == 0) {
            if (0 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"Video_Poker"];
            }
        }else{
            arrs = [self.searchArr copy];
        }
    }else if (self.geeType == GEETypeJDB) {
        if (self.searchFlag == 0) {
            if (0 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"BonusSlot"];
            }else if (1 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"ClassicSlot"];
            }else if (2 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"FeatureSlot"];
            }
        }else{
            arrs = [self.searchArr copy];
        }
    }else if (self.geeType == GEETypeSW) {
        if (self.searchFlag == 0) {
            if (0 == indexPath.section) {
                arrs = [self.dicts objectForKey:@"Video_Poker"];
            }
        }else{
            arrs = [self.searchArr copy];
        }
    }
    [cell.imv setImage:[UIImage imageNamed:[arrs[indexPath.item] objectForKey:@"src"]]];
    cell.label1.text = [arrs[indexPath.item] objectForKey:@"title"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        GLoginVC *gLogin = [[GLoginVC alloc] init];
        gLogin.geectl = self;
        [self presentViewController:gLogin animated:YES completion:nil];
    }else{
        GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
        
        NSArray *arrs = [[NSArray alloc] init];
        if (self.geeType == GEETypeMG) {
            if (self.searchFlag == 0) {
                if (0 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"BonusSlot"];
                }else if (1 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"ClassicSlot"];
                }else if (2 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"FeatureSlot"];
                }else if (3 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"Video"];
                }else if (4 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"VideoSlot"];
                }else if (5 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"VideoPoker"];
                }
            }else{
                arrs = [self.searchArr copy];
            }
        }else if (self.geeType == GEETypeHB) {
            if (self.searchFlag == 0) {
                if (0 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"Slot_Game"];
                }else if (1 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"Table_Game"];
                }else if (2 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"Video_Poker"];
                }
            }else{
                arrs = [self.searchArr copy];
            }
        }else if (self.geeType == GEETypePS) {
            if (self.searchFlag == 0) {
                if (0 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"Video_Poker"];
                }
            }else{
                arrs = [self.searchArr copy];
            }
        }else if (self.geeType == GEETypeJDB) {
            if (self.searchFlag == 0) {
                if (0 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"BonusSlot"];
                }else if (1 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"ClassicSlot"];
                }else if (2 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"FeatureSlot"];
                }
            }else{
                arrs = [self.searchArr copy];
            }
        }else if (self.geeType == GEETypeSW) {
            if (self.searchFlag == 0) {
                if (0 == indexPath.section) {
                    arrs = [self.dicts objectForKey:@"Video_Poker"];
                }
            }else{
                arrs = [self.searchArr copy];
            }
        }
        
        gTransferAccounts.platformName = [arrs[indexPath.item] objectForKey:@"title"];
        if (self.geeType == GEETypeMG) {
            gTransferAccounts.gameType = @"MG";
            gTransferAccounts.fromName = @"MG电子";
            gTransferAccounts.gameID = [arrs[indexPath.item] objectForKey:@"GameID"];
        }else if (self.geeType == GEETypeHB) {
            gTransferAccounts.gameType = @"HABA";
            gTransferAccounts.fromName = @"HABA电子";
            gTransferAccounts.gameID = [arrs[indexPath.item] objectForKey:@"Keyname"];
        }else if (self.geeType == GEETypePS) {
            gTransferAccounts.gameType = @"PS";
            gTransferAccounts.fromName = @"PS电子";
            gTransferAccounts.gameID = [arrs[indexPath.item] objectForKey:@"GameID"];
        }else if (self.geeType == GEETypeJDB) {
            gTransferAccounts.gameType = @"JDB";
            gTransferAccounts.fromName = @"JDB电子";
            gTransferAccounts.gameID = [arrs[indexPath.item] objectForKey:@"GameID"];
        }else if (self.geeType == GEETypeSW) {
            gTransferAccounts.gameType = @"SW";
            gTransferAccounts.fromName = @"SW电子";
            gTransferAccounts.gameID = [arrs[indexPath.item] objectForKey:@"GameID"];
        }
        [self.navigationController pushViewController:gTransferAccounts animated:YES];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)    {
        GEECollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        [headerView getSHCollectionReusableViewHearderTitle:_ary1[indexPath.section]];
        reusableview = headerView;
        if (self.searchFlag == 1) {
            reusableview.hidden = YES;
        }else{
            reusableview.hidden = NO;
        }
    }
    return reusableview;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.txtSearch resignFirstResponder];
}
@end
