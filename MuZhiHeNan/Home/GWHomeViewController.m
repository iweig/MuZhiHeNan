//
//  GWSubscriberViewController.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWHomeViewController.h"
#import "GWChildredCategoryCell.h"
#import "GWCategoryModel.h"
#import "SDCycleScrollView.h"
#import "GWNewsModel.h"
#import "GWCategoryHeaderReusableView.h"

#define kMinimumInteritemSpacing 1
#define kMinimumLineSpacing 1
#define kItemNum 3.0

@interface GWHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *modelArr;

//广告
@property (nonatomic, strong) NSMutableArray *imageGroup;
@property (nonatomic, strong) NSMutableArray *titleGroup;
@property (nonatomic, strong) NSMutableArray *adsArr;
@property (nonatomic, strong) SDCycleScrollView *adScrollView;

@end

@implementation GWHomeViewController

//懒加载数据
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (NSMutableArray *)imageGroup
{
    if (!_imageGroup) {
        _imageGroup = [NSMutableArray array];
    }
    return _imageGroup;
}

- (NSMutableArray *)titleGroup
{
    if (!_titleGroup) {
        _titleGroup = [NSMutableArray array];
    }
    return _titleGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getData];
    [self getAdsData];
}

- (NSMutableArray *)adsArr
{
    if (!_adsArr) {
        _adsArr = [NSMutableArray array];
    }
    return _adsArr;
}

- (void)setupUI
{
    self.navigationItem.title = @"订阅";
    
    //初始化广告栏
    SDCycleScrollView *adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -200, kScreenSize.width, 200) imagesGroup:nil];
    adScrollView.autoScrollTimeInterval = 6.0;
    adScrollView.delegate = self;
    self.adScrollView = adScrollView;

    //初始化订阅信息
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat w = (kScreenSize.width - (kItemNum - 1) * kMinimumInteritemSpacing) / kItemNum;
    flowLayout.itemSize = CGSizeMake(w ,w);
    flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    flowLayout.headerReferenceSize = CGSizeMake(kScreenSize.width, 40);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentInset = UIEdgeInsetsMake(200, 0, 64, 0);
    [collectionView registerNib:[UINib nibWithNibName:@"GWChildredCategoryCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GWChildredCategoryCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"GWCategoryHeaderReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"GWCategoryHeaderReusableView"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.modelArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.modelArr.count > 0) {
        GWCategoryModel *model = self.modelArr[section];
        return model.childrenArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GWChildredCategoryCell *cell = (GWChildredCategoryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GWChildredCategoryCell" forIndexPath:indexPath];
    GWCategoryModel *model = self.modelArr[indexPath.section];
    
    cell.model = model.childrenArr[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GWCategoryHeaderReusableView *headerView = nil;
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
         headerView = [collectionView dequeueReusableSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"GWCategoryHeaderReusableView" forIndexPath:indexPath];
    }
    GWCategoryModel *model = self.modelArr[indexPath.section];
    headerView.title = model.shortName;
    headerView.subTitle = model.name;
    return headerView;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}

#pragma mark -SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}

#pragma mark -网络请求
- (void)getData
{
    kWeakSelf
    NSDictionary *dict = @{@"user_id":kUserId,@"token":kToken};
    [HttpManager GET:kGetAllCategory parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dict in responseObject) {
            GWCategoryModel *model = [GWCategoryModel categoryModelWithDict:dict];
            [weakSelf.modelArr addObject:model];
        }
        [weakSelf.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

- (void)getAdsData
{
    kWeakSelf
    NSDictionary *dict = @{@"user_id":kUserId,@"token":kToken};
    [HttpManager GET:kGetReDianData parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSArray *jiaodianArr = responseObject[0][@"jiaodiantu"];
     for (NSDictionary *modelDict in jiaodianArr) {
         GWNewsModel *adesModel = [GWNewsModel adesModelWithDict:modelDict];
         [weakSelf.adsArr addObject:adesModel];
         [weakSelf.imageGroup addObject:modelDict[@"thumb"]];
         [weakSelf.titleGroup addObject:modelDict[@"title"]];
     }
         [weakSelf refreshAdData];
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
 }];
}

- (void)refreshAdData
{
    self.adScrollView.imageURLStringsGroup = self.imageGroup;
    self.adScrollView.titlesGroup = self.titleGroup;
    [self.collectionView addSubview:self.adScrollView];
}

@end
