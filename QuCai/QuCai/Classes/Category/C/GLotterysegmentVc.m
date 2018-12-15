//
//  GLotterysegmentVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GLotterysegmentVc.h"
#import "GTheSecondModuleCollectionViewCell.h"
#import "GLotterySegmentHeaderView.h"
#import "GTransferAccounts.h"

static NSString *const  kHomePageleftTableViewCell = @"kHomePageleftTableViewCell";

@interface GLotterysegmentVc ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray *ary1;
@property (nonatomic, strong) NSMutableArray *ary3;

@end

@implementation GLotterysegmentVc

- (void)onCreate {

    [self.view addSubview:self.collectionV];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.bottom.right.equalTo(self.view);
    }];
    self.collectionV.scrollEnabled = YES;
    self.collectionV.alwaysBounceVertical = YES;
}

- (void)onWillShow {
    
}

- (void)onWillDisappear {
    
}

- (UICollectionView *)collectionV {
    
    if (_collectionV == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 35);
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/5+11, 90);
        [_collectionV registerClass:[GTheSecondModuleCollectionViewCell class] forCellWithReuseIdentifier:@"secondModuleCollectionViewCell"];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_collectionV registerClass:[GLotterySegmentHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
        
        self.ary1 = [NSMutableArray arrayWithObjects:@"时时彩",@"11选5",@"快乐十分",@"快乐8",@"快三",@"PK10",@"3D",@"PC蛋蛋",@"六合彩", nil];
        self.ary3 = [NSMutableArray arrayWithObjects:@"视讯彩频道",@"国彩频道",@"高频彩频道",@"VR动画彩频道", nil];
    }
    return _collectionV;
}

#pragma mark -—————————— UICollectionView Delegate And DataSource ——————————
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"LotteryList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    if (self.lotteryType == GLotteryTypeNew) {
        
        NSArray *arr = [[dataArrs objectAtIndex:0] objectAtIndex:section];
        return arr.count;
        
    } else if (self.lotteryType == GLotteryTypeNormal ){
        
        NSArray *arr = [[dataArrs objectAtIndex:1] objectAtIndex:section];
        return arr.count;
        
    } else if (self.lotteryType == GLotteryTypeVR ){
        
        NSArray *arr = [[dataArrs objectAtIndex:2] objectAtIndex:section];
        return arr.count;

    } else if (self.lotteryType == GLotteryTypeGY ){
        
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.lotteryType == GLotteryTypeNormal || self.lotteryType == GLotteryTypeNew) {
        
        return _ary1.count;

    } else if (self.lotteryType == GLotteryTypeVR ){
        
        return _ary3.count;
    }
    else if (self.lotteryType == GLotteryTypeGY ){
        
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"secondModuleCollectionViewCell";
    GTheSecondModuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"LotteryList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    if (self.lotteryType == GLotteryTypeNew) {
        
        NSArray *arr = [[dataArrs objectAtIndex:0] objectAtIndex:indexPath.section];
        NSDictionary *dict = [arr objectAtIndex:indexPath.row];
        
        cell.imv.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        cell.label1.text = [dict objectForKey:@"platformName"];
        
    } else if (self.lotteryType == GLotteryTypeNormal) {
        
        NSArray *arr = [[dataArrs objectAtIndex:1] objectAtIndex:indexPath.section];
        NSDictionary *dict = [arr objectAtIndex:indexPath.row];
        
        cell.imv.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        cell.label1.text = [dict objectForKey:@"platformName"];
        
    } else if (self.lotteryType == GLotteryTypeVR) {
        
        NSArray *arr = [[dataArrs objectAtIndex:2] objectAtIndex:indexPath.section];
        NSDictionary *dict = [arr objectAtIndex:indexPath.row];
        
        cell.imv.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        cell.label1.text = [dict objectForKey:@"platformName"];
        
    } else if (self.lotteryType == GLotteryTypeGY) {
        
        NSArray *imgArray = [NSArray arrayWithObjects:@"gy", nil];
        NSArray *label1Array = [NSArray arrayWithObjects:@"GY彩票",nil];
        
        cell.imv.image = [UIImage imageNamed:imgArray[indexPath.item]];
        cell.label1.text = label1Array[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        
        GLoginVC *gLogin = [[GLoginVC alloc] init];
        [self presentViewController:gLogin animated:YES completion:nil];
    } else {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"LotteryList" ofType:@"plist"];
        NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];

        GTransferAccounts *gTransferAccounts = [[GTransferAccounts alloc] init];
        if (self.lotteryType == GLotteryTypeNew) {
            
            NSArray *arr = [[dataArrs objectAtIndex:0] objectAtIndex:indexPath.section];
            NSDictionary *dict = [arr objectAtIndex:indexPath.row];

            gTransferAccounts.platformName = [dict objectForKey:@"platformName"];
            gTransferAccounts.gameType = [dict objectForKey:@"gameType"];
            gTransferAccounts.gameID = [dict objectForKey:@"gameID"];
            gTransferAccounts.fromName = @"IG彩票（新）";
            
        }else if (self.lotteryType == GLotteryTypeNormal) {
            
            NSArray *arr = [[dataArrs objectAtIndex:1] objectAtIndex:indexPath.section];
            NSDictionary *dict = [arr objectAtIndex:indexPath.row];
            
            gTransferAccounts.platformName = [dict objectForKey:@"platformName"];
            gTransferAccounts.gameType = [dict objectForKey:@"gameType"];
            gTransferAccounts.gameID = [dict objectForKey:@"gameID"];
            gTransferAccounts.fromName = @"IG彩票";
            
        }else if (self.lotteryType == GLotteryTypeVR) {
            
            NSArray *arr = [[dataArrs objectAtIndex:2] objectAtIndex:indexPath.section];
            NSDictionary *dict = [arr objectAtIndex:indexPath.row];
            
            gTransferAccounts.platformName = [dict objectForKey:@"platformName"];
            gTransferAccounts.gameType = [dict objectForKey:@"gameType"];
            gTransferAccounts.gameID = [dict objectForKey:@"gameID"];
            gTransferAccounts.fromName = @"VR彩票";
        }else if (self.lotteryType == GLotteryTypeGY) {
            
            gTransferAccounts.platformName = @"GY彩票";
            gTransferAccounts.gameType = @"GY";
            gTransferAccounts.gameID = @"";
            gTransferAccounts.fromName = @"GY彩票";
        }
        [self.navigationController pushViewController:gTransferAccounts animated:YES];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)    {
        GLotterySegmentHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        if (self.lotteryType == GLotteryTypeNew || self.lotteryType == GLotteryTypeNormal) {
            [headerView getSHCollectionReusableViewHearderTitle:_ary1[indexPath.section]];
        } else if (self.lotteryType == GLotteryTypeVR) {
            [headerView getSHCollectionReusableViewHearderTitle:_ary3[indexPath.section]];
        }else if (self.lotteryType == GLotteryTypeGY) {
            [headerView getSHCollectionReusableViewHearderTitle:@"GY彩票"];
        }
        reusableview = headerView;
    }
    return reusableview;
}

@end
