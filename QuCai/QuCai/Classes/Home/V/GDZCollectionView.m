//
//  GDZCollectionView.m
//  QuCai
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDZCollectionView.h"
#import "MJRefresh.h"
#import "GDZCollectionHeadView.h"
#import "GDZCollectionFootView.h"
#import "GDZCollectionViewCell.h"

static NSString *collectionViewCellIdentifier = @"collectionViewCell";

@interface GDZCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation GDZCollectionView

- (void)dealloc
{
    self.scrollCallback = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake((kScreenWidth - 60)/2 + 10, ((kScreenWidth - 60)/2)*9/16 + 30);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 130);
        layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 45);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.scrollEnabled = NO;
        [self.collectionView registerClass:[GDZCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
        [self.collectionView registerClass:[GDZCollectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
        [self.collectionView registerClass:[GDZCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceImg.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDZCollectionViewCell *cell = (GDZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    cell.imv.image = [UIImage imageNamed:self.dataSourceImg[indexPath.row]];
    cell.label1.text = self.dataSourceTitle[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)    {
        GDZCollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        [headerView getSHCollectionReusableViewHearderTitle:@"index_games_01"];
        
        UIButton *fishButton = [[UIButton alloc] init];
        [headerView addSubview:fishButton];
        [fishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView);
        }];
        [fishButton addTarget:self action:@selector(actionBtnClickFish:) forControlEvents:UIControlEventTouchUpInside];
        
        reusableview = headerView;
    }else{
        GDZCollectionFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
        UIButton *moreButton = [GUIHelper getButtonWithImage:[UIImage imageNamed:@"index_rightmore"]];
        [moreButton setTitle:@"更多游戏" forState:UIControlStateNormal];
        moreButton.titleLabel.font = TXT_SIZE_14;
        [moreButton setTitleColor:[UIColor colorWithHexStr:@"#8F8F8F"] forState:UIControlStateNormal];
        [footerView addSubview:moreButton];
        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(footerView);
            make.top.equalTo(footerView).offset(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(45);
        }];
        [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -moreButton.imageView.sz_size.width, 0, moreButton.imageView.sz_size.width)];
        [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, moreButton.titleLabel.bounds.size.width+10, 0, -moreButton.titleLabel.bounds.size.width)];
        [moreButton addTarget:self action:@selector(actionBtnClickMore:) forControlEvents:UIControlEventTouchUpInside];
        reusableview = footerView;
    }
    return reusableview;
}

- (void)actionBtnClickMore:(UIButton *)btn {
    if (self.dzBlock) {
        self.dzBlock(123);
    }
}

- (void)actionBtnClickFish:(UIButton *)btn {
    if (self.dzBlock) {
        self.dzBlock(321);
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dzBlock) {
        self.dzBlock(indexPath.row);
    }
}

#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.collectionView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listViewLoadDataIfNeeded {
    
}

@end
