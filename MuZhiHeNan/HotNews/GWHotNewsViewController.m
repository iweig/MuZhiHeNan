//
//  GWHotNewsViewController.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWHotNewsViewController.h"
#import "GWNewsModel.h"
#import "GWNewStyleOneCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GWNewsHeaderCell.h"

@interface GWHotNewsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger _number;
    NSInteger _offset;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *tuiguangInfoArr;

@end


@implementation GWHotNewsViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)tuiguangInfoArr
{
    if(!_tuiguangInfoArr)
    {
        _tuiguangInfoArr = [NSMutableArray array];
    }
    return _tuiguangInfoArr;
}

- (NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _number = 3;
    _offset = 0;
    
    [self setupUI];
    [self getData];
}

- (void)setupUI
{
    self.navigationItem.title = @"热点";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewStyleOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewStyleOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewsHeaderCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"GWNewsHeaderCell"];
    tableView.sectionHeaderHeight = 30.0;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *modelArr = self.dataArr[section];
    return modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWNewStyleOneCell *styleOneCell = [tableView dequeueReusableCellWithIdentifier:@"GWNewStyleOneCell" forIndexPath:indexPath];

    [self configureCell:styleOneCell atIndexPath:indexPath];
    return styleOneCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GWNewsHeaderCell *headerCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GWNewsHeaderCell"];
    headerCell.lblTitle.text = self.titleArr[section];
    return headerCell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//    if ([cell isKindOfClass:[GWNewStyleOneCell class]]) {
        GWNewStyleOneCell *styleOneCell = (GWNewStyleOneCell *)cell;
        styleOneCell.newsModel = self.dataArr[indexPath.section][indexPath.row];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"GWNewStyleOneCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark -UITableViewDelegate


#pragma mark -网络请求

- (void)getData
{
    [self getDefaultData];
}

- (void)getDefaultData
{
    NSDictionary *dict = @{@"user_id":kUserId,@"token":kToken};
    [HttpManager GET:kGetReDianData parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray array];
        
        //推广
        NSArray *tuiguangArr = responseObject[0][@"tuiguang"];
        NSMutableArray *tuiguangModelArr = [NSMutableArray array];
        for (NSDictionary *dict in tuiguangArr) {
            GWNewsModel *news = [GWNewsModel newsModelWithDict:dict];
            [tuiguangModelArr addObject:news];
        }
        NSDictionary *tuiguangDict = @{@"推广":tuiguangModelArr};
//        [dataArr addObject:tuiguangDict];
        [self.tuiguangInfoArr addObject:tuiguangDict];
        //头条
        NSArray *toutiaoArr = responseObject[0][@"toutiao"];
        NSMutableArray *toutiaoModelArr = [NSMutableArray array];
        for (NSDictionary *dict in toutiaoArr) {
            GWNewsModel *news = [GWNewsModel newsModelWithDict:dict];
            [toutiaoModelArr addObject:news];
        }
        [self.titleArr addObject:@"头条"];
        [dataArr addObject:toutiaoModelArr];
        
        //本地
        NSArray *bendiArr = responseObject[0][@"bendi"];
        NSMutableArray *bendiModelArr = [NSMutableArray array];
        for (NSDictionary *dict in bendiArr) {
            GWNewsModel *news = [GWNewsModel newsModelWithDict:dict];
            [bendiModelArr addObject:news];
        }
        [self.titleArr addObject:@"本地"];
        [dataArr addObject:bendiModelArr];
        
        self.dataArr = dataArr;
        
        [self getAllNewsData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getAllNewsData
{
    NSDictionary *dict = @{@"number":kNSString(@"%ld",_number),@"offset":kNSString(@"%ld",_offset),@"user_id":kUserId,@"token":kToken};
    [HttpManager GET:kGetAllNews parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *newsModelArr = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            GWNewsModel *model = [GWNewsModel newsModelWithDict:dict];
            [newsModelArr addObject:model];
        }
        [self.titleArr addObject:@"更多"];
        [self.dataArr addObject:newsModelArr];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
