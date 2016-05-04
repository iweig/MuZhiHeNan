//
//  GWHotNewsViewController.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWHotNewsViewController.h"
#import "GWNewsModel.h"
#import "GWExpandModel.h"
#import "GWNewStyleOneCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GWNewsHeaderCell.h"
#import "GWAdNewsCell.h"
#import "GWAdNewsHeaderCell.h"
#import "GWNewsDetailViewController.h"
#import "GWNewsStyleTwoCell.h"
#import "GWSubjectViewController.h"

@interface GWHotNewsViewController () <UITableViewDataSource, UITableViewDelegate, GWAdNewsHeaderCellDelegate>
{
    NSInteger _number;
    NSInteger _offset;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) NSMutableArray *expandArr;

@end


@implementation GWHotNewsViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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

- (NSMutableArray *)expandArr
{
    if (!_expandArr) {
        _expandArr = [NSMutableArray array];
    }
    return _expandArr;
}

- (void)setupUI
{
    self.navigationItem.title = @"热点";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewStyleOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewStyleOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewsHeaderCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"GWNewsHeaderCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewsStyleTwoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewsStyleTwoCell"];
    //推广
    [tableView registerNib:[UINib nibWithNibName:@"GWAdNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWAdNewsCell"];
    [tableView registerClass:[GWAdNewsHeaderCell class] forHeaderFooterViewReuseIdentifier:@"GWAdNewsHeaderCell"];
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
    if (indexPath.section == 0) {
        GWAdNewsCell *adNewsCell = [tableView dequeueReusableCellWithIdentifier:@"GWAdNewsCell" forIndexPath:indexPath];
        [self configureCell:adNewsCell atIndexPath:indexPath];
        return adNewsCell;
    }
    else if (indexPath.section > 0 && indexPath.row == 0) {
        GWNewStyleOneCell *styleOneCell = [tableView dequeueReusableCellWithIdentifier:@"GWNewStyleOneCell" forIndexPath:indexPath];
        [self configureCell:styleOneCell atIndexPath:indexPath];
        return styleOneCell;
    }
    else {
        GWNewsStyleTwoCell *styleTwoCell = [tableView dequeueReusableCellWithIdentifier:@"GWNewsStyleTwoCell" forIndexPath:indexPath];
        [self configureCell:styleTwoCell atIndexPath:indexPath];
        return styleTwoCell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        GWAdNewsHeaderCell *adNewsHeaderCell = (GWAdNewsHeaderCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GWAdNewsHeaderCell"];
        adNewsHeaderCell.delegate = self;
        adNewsHeaderCell.catname = self.titleArr[section];
        GWNewsModel *newsModel = self.expandArr[0][0];
        adNewsHeaderCell.title = newsModel.title;
        return adNewsHeaderCell;
    }
    GWNewsHeaderCell *headerCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GWNewsHeaderCell"];
    headerCell.lblTitle.text = self.titleArr[section];
    return headerCell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if ([cell isKindOfClass:[GWNewStyleOneCell class]]) {
        GWNewStyleOneCell *styleOneCell = (GWNewStyleOneCell *)cell;
        styleOneCell.newsModel = self.dataArr[indexPath.section][indexPath.row];
    }
    if ([cell isKindOfClass:[GWAdNewsCell class]]) {
        GWAdNewsCell *adNewsCell = (GWAdNewsCell *)cell;
        adNewsCell.expandModel = self.dataArr[indexPath.section][indexPath.row];
    }
    if ([cell isKindOfClass:[GWNewsStyleTwoCell class]]) {
        GWNewsStyleTwoCell *styleTwoCell = (GWNewsStyleTwoCell *)cell;
        styleTwoCell.newsModel = self.dataArr[indexPath.section][indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"GWAdNewsCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
    else if (indexPath.section > 0 && indexPath.row == 0)
    {
        return [tableView fd_heightForCellWithIdentifier:@"GWNewStyleOneCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:@"GWNewsStyleTwoCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    if (indexPath.section == 0) {
        GWExpandModel *expandModel = self.dataArr[indexPath.section][indexPath.row];
        GWSubjectViewController *subjectVC = [[GWSubjectViewController alloc] initWithSpecialId:expandModel.special_id];
        [self.navigationController pushViewController:subjectVC animated:YES];
    }
    else
    {
        GWNewsModel *newsModel = self.dataArr[indexPath.section][indexPath.row];
        GWNewsDetailViewController *newsDetailVC = [[GWNewsDetailViewController alloc] initWithContentId:newsModel.content_id];
        [self.navigationController pushViewController:newsDetailVC animated:YES];
    }
    
}

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
            GWNewsModel *newsModel = [GWNewsModel newsModelWithDict:dict];
            [tuiguangModelArr addObject:newsModel];
        }
        [self.titleArr addObject:@"推广"];
        [self.expandArr addObject:tuiguangModelArr];
        
        //专题
        NSArray *zhuantiArr = responseObject[0][@"zhuanti"];
        NSMutableArray *zhuantiModelArr = [NSMutableArray array];
        for (NSDictionary *dict in zhuantiArr) {
            GWExpandModel *news = [GWExpandModel expandModelWithDict:dict];
            [zhuantiModelArr addObject:news];
        }
//        [self.titleArr addObject:@"专题"];
        [dataArr addObject:zhuantiModelArr];
        
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

#pragma mark -GWAdNewsHeaderCellDelegate
- (void)adNewsHeaderCell:(GWAdNewsHeaderCell *)adNewsHeaderCell
{
    GWNewsModel *newsModel = self.expandArr[0][0];
    GWNewsDetailViewController *newsDetailVC = [[GWNewsDetailViewController alloc] initWithContentId:newsModel.content_id];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
