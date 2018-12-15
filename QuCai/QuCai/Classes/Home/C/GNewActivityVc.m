//
//  GNewActivityVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/30.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GNewActivityVc.h"
#import "GNewActivityCell.h"
#import "GNewActivityModel.h"
#import "GKPhotoBrowser.h"

static NSString *const  kGNewActivityVcCell = @"kGNewActivityVcCell";

@interface GNewActivityVc () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tempArrayImg;
@property (nonatomic, strong) NSMutableArray <GNewActivityModel *> *picArrayS;
@property (nonatomic, assign) double rowH;
@end

@implementation GNewActivityVc

- (void)onCreate {
    
    self.navigationItem.title = @"最新优惠";
    
    [self createUI];
    
    [self initRefreshControl];
}

- (void)onWillShow {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)onWillDisappear {
    [SVProgressHUD dismiss];
}

- (void)loadData {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @"2";
    dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kMobilePicture RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        self.tempArrayImg = [NSMutableArray array];
        if (responseObject != nil) {
            NSMutableArray *arrs = [[NSMutableArray alloc] init];
            for (int i=0; i<[responseObject count]; i++) {
                NSDictionary *dict =responseObject[i];
                if ([[dict objectForKey:@"src1"] isEqualToString:[[SZUser shareUser] readSrc1Link]]) {
                    [arrs addObject:dict];
                }
            }
            self.picArrayS = [GNewActivityModel mj_objectArrayWithKeyValuesArray:[arrs copy]];
            
            if(self.picArrayS.count > 0){
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.layer.cornerRadius = 8;
                imageView.layer.masksToBounds = YES;
                [imageView layoutIfNeeded];
                GNewActivityModel *model = self.picArrayS[0];
                NSURL *url = [NSURL URLWithString:[GTool stringChineseFamat:model.img1]];
                [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                sleep(1);
                [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    CGFloat width = image.size.width;
                    CGFloat height = image.size.height;
                    self.rowH = height*((ScreenW -20)/width);
                    
                    [self.tableView reloadData];
                    [self.tableView.mj_header endRefreshing];
                }];
            }else{
                [self.tableView.mj_header endRefreshing];
            }
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)createUI {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_HEIGHT);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)initRefreshControl {
    
    kWeakSelf(wkself);
    
    [self.tableView setRefreshWithHeaderBlock:^{
        [wkself loadData];
    } footerBlock:nil];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView setupEmptyDataText:@"暂无记录，点击刷新" verticalOffset:-40 emptyImage:[UIImage imageNamed:@"nodata"] tapBlock:^{
        [wkself loadData];
        [self.tableView.mj_header beginRefreshing];
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    }];
}

#pragma mark -—————————— UITableView Delegate And DataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.picArrayS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GNewActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:kGNewActivityVcCell];
    if (!cell) {
        cell = [[GNewActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGNewActivityVcCell];
    }
    cell.gNewActivityModel = self.picArrayS[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.rowH + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *imageUrl = [GTool stringChineseFamat:self.picArrayS[indexPath.row].img2];
    GKPhoto *photo = [GKPhoto new];
    photo.url = [NSURL URLWithString:imageUrl];
    
    NSMutableArray *photos = [NSMutableArray new];
    [photos addObject:photo];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.loadStyle = GKPhotoBrowserLoadStyleDeterminate;
//    [self presentViewController:browser animated:NO completion:nil];
    [self.navigationController pushViewController:browser animated:YES];
}

@end
