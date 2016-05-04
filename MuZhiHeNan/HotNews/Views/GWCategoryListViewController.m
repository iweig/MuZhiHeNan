//
//  GWCategoryListViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWCategoryListViewController.h"
#import "GWNewsModel.h"
#import "GWNewStyleOneCell.h"
#import "GWNewsDetailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface GWCategoryListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GWCategoryListViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (instancetype)initWithCatId:(NSString *)catId
{
    if (self = [super init]) {
        _catId = catId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self getData];
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:@"GWNewStyleOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewStyleOneCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArr) {
        return self.dataArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWNewStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GWNewStyleOneCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"GWNewStyleOneCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    if ([cell isKindOfClass:[GWNewStyleOneCell class]])
    {
        GWNewStyleOneCell *styleOneCell = (GWNewStyleOneCell *)cell;
        styleOneCell.newsModel = self.dataArr[indexPath.row];
    }
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    GWNewsModel *newsModel = self.dataArr[indexPath.row];
    GWNewsDetailViewController *newsDetailVC = [[GWNewsDetailViewController alloc] initWithContentId:newsModel.content_id];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

#pragma mark -网络请求
- (void)getData
{
    kWeakSelf
    NSDictionary *dict = @{@"cat_id":_catId,@"user_id":kUserId,@"token":kToken};
    [HttpManager GET:kGetCategoryList parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *modelDict in responseObject) {
            GWNewsModel *model = [GWNewsModel newsModelWithDict:modelDict];
            [dataArr addObject:model];
        }
        weakSelf.dataArr = dataArr;
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
