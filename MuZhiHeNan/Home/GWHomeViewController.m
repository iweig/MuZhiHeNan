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

#define kMinimumInteritemSpacing 1
#define kMinimumLineSpacing 1
#define kItemNum 3.0

@interface GWHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *modelArr;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getData];
}

- (void)setupUI
{
    self.navigationItem.title = @"订阅";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat w = (kScreenSize.width - (kItemNum - 1) * kMinimumInteritemSpacing) / kItemNum;
    flowLayout.itemSize = CGSizeMake(w ,w);
    flowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    flowLayout.minimumLineSpacing = kMinimumLineSpacing;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"GWChildredCategoryCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GWChildredCategoryCell"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.modelArr.count > 0) {
        GWCategoryModel *model = self.modelArr[0];
        return model.childrenArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GWChildredCategoryCell *cell = (GWChildredCategoryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GWChildredCategoryCell" forIndexPath:indexPath];
    GWCategoryModel *model = self.modelArr[0];
    cell.model = model.childrenArr[indexPath.row];
    
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
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
        NSLog(@"=====");
    }];
}


@end
