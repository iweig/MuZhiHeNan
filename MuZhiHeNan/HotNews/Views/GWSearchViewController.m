//
//  GWSearchViewController.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSearchViewController.h"
#import "SKTagView.h"
#import "Masonry.h"
#import "GWSearchAuthorModel.h"
#import "GWSearchInfoModel.h"
#import "GWSearchContentCell.h"
#import "GWSearchAuthorCell.h"
#import "GWSearchSectionHeaderCell.h"
#import "GWNewsDetailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

#define kSearchBarFrmae CGRectMake(60, 0, kScreenSize.width - 100, 44)

@interface GWSearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSUInteger _offset;
    BOOL _hasAuthor;
    BOOL _hasTitle;
}
@property (nonatomic, strong) SKTagView *tagView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *hotwordsArr;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableDictionary *titleDict;

@property (nonatomic, strong) NSMutableArray *authorArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GWSearchViewController

- (NSMutableDictionary *)titleDict
{
    if (!_titleDict) {
        _titleDict = [NSMutableDictionary dictionary];
    }
    return _titleDict;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)hotwordsArr
{
    if (!_hotwordsArr) {
        _hotwordsArr = [NSMutableArray array];
    }
    return _hotwordsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _offset = 0;
    [self setupUI];
    [self getSearchHotWords];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createSearchBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar removeFromSuperview];
}

- (void)createSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:kSearchBarFrmae];
    [searchBar setBackgroundImage:[GWBundleManager imageWithName:@"white_border_bg" bundleString:@"theme_default"]];
    searchBar.placeholder = @"搜索相关标题和文章";
    searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:searchBar];
    self.searchBar = searchBar;
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, kScreenSize.width, kScreenSize.height - 80 - 64)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionHeaderHeight = 30.0;
    [tableView registerNib:[UINib nibWithNibName:@"GWSearchContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWSearchContentCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWSearchAuthorCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWSearchAuthorCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWSearchSectionHeaderCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"GWSearchSectionHeaderCell"];
    [self.view addSubview:tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView = tableView;
    
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = [UIColor whiteColor];
        view.padding = UIEdgeInsetsMake(3, 4, 3, 4);
        view.interitemSpacing = 6;
        view.lineSpacing = 3;
        kWeakSelf
        view.didTapTagAtIndex = ^(NSUInteger index){
            [weakSelf getSearchDataByWords:weakSelf.hotwordsArr[index]];
        };
        view;
    });
    [self.view addSubview:self.tagView];
    kWeakSelf
    [self.tagView  mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = weakSelf.view;
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];
}

#pragma mark -UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect = kSearchBarFrmae;
        rect.origin.x -= 40;
        rect.size.width = rect.size.width + 50;
        searchBar.frame = rect;
    }];
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0) {
        [self getSearchDataByWords:searchBar.text];
        searchBar.text = @"";
        [UIView animateWithDuration:.25 animations:^{
            searchBar.frame = kSearchBarFrmae;
        }];
        [searchBar setShowsCancelButton:NO animated:YES];
        [searchBar resignFirstResponder];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [UIView animateWithDuration:.25 animations:^{
        searchBar.frame = kSearchBarFrmae;
    }];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)getSearchHotWords
{
    kWeakSelf
    NSDictionary *dict = @{@"user_id":kUserId,@"token":kToken};
    [HttpManager GET:kGetsearchhotwords parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject enumerateObjectsUsingBlock:^(NSString * text, NSUInteger idx, BOOL * _Nonnull stop) {
            SKTag *tag = [SKTag tagWithText:text];
            tag.textColor = [UIColor whiteColor];
            tag.bgColor = [UIColor orangeColor];
            tag.cornerRadius = 3.0;
            tag.fontSize = 12;
            tag.padding = UIEdgeInsetsMake(8, 10, 8, 10);
            [weakSelf.tagView addTag:tag];
            [weakSelf.hotwordsArr addObject:text];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getSearchDataByWords:(NSString *)words
{
    
    kWeakSelf
    [self.titleDict removeAllObjects];
    [self.dataArr removeAllObjects];
    _hasAuthor = NO;
    _hasTitle = NO;
    NSString *urlStr = kNSString(@"%@?user_id=%@&token=%@&content=%@&offset=%ld",kSearch,kUserId,kToken,[words stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_offset);
    [HttpManager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //作者
        NSMutableArray *authorModelArr = [NSMutableArray array];
        NSArray *authorArr = responseObject[@"author"];
        if (authorArr.count > 0) {
            _hasAuthor = YES;
            for (NSDictionary *dict in authorArr) {
                GWSearchAuthorModel *searchModel = [GWSearchAuthorModel searchAuthorModelWithDict:dict];
                [authorModelArr addObject:searchModel];
            }
            [weakSelf.titleDict setValue:@"作者" forKey:@"author"];
            [weakSelf.dataArr addObject:authorModelArr];
        }
        
        //标题
        NSMutableArray *titleModelArr = [NSMutableArray array];
        NSArray *titleArr = responseObject[@"title"];
        if (titleArr.count > 0) {
            _hasTitle = YES;
            for (NSDictionary *dict in titleArr) {
                GWSearchInfoModel *searchModel = [GWSearchInfoModel searchInfoModelWithDict:dict];
                [titleModelArr addObject:searchModel];
            }
            [weakSelf.titleDict setValue:@"标题" forKey:@"title"];
             [weakSelf.dataArr addObject:titleModelArr];
        }
       
        //文章
        NSMutableArray *contentModelArr = [NSMutableArray array];
        NSArray *contentArr = responseObject[@"content"];
        if (contentArr.count > 1) {
            for (NSDictionary *dict in contentArr) {
                GWSearchInfoModel *searchModel = [GWSearchInfoModel searchInfoModelWithDict:dict];
                [contentModelArr addObject:searchModel];
            }
            [weakSelf.titleDict setValue:@"文章" forKey:@"content"];
            [weakSelf.dataArr addObject:contentModelArr];
        }
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.titleDict.count > 0) {
        return self.titleDict.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArr[section];
    if (array.count > 0) {
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hasAuthor && indexPath.section == 0) {
        GWSearchAuthorCell *authorCell = [tableView dequeueReusableCellWithIdentifier:@"GWSearchAuthorCell" forIndexPath:indexPath];
        [self configureCell:authorCell atIndexPath:indexPath];
        
        return authorCell;
    }
    else
    {
        GWSearchContentCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"GWSearchContentCell" forIndexPath:indexPath];
        [self configureCell:searchCell atIndexPath:indexPath];
        
        return searchCell;
    }
    return nil;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
        if ([cell isMemberOfClass:[GWSearchContentCell class]]) {
        GWSearchContentCell *searchCell = (GWSearchContentCell *)cell;
        searchCell.searchModel = self.dataArr[indexPath.section][indexPath.row];
    }
     if ([cell isMemberOfClass:[GWSearchAuthorCell class]] && _hasAuthor && indexPath.section == 0) {
        GWSearchAuthorCell *authorCell = (GWSearchAuthorCell *)cell;
        authorCell.authorModel = self.dataArr[indexPath.section][indexPath.row];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hasAuthor) {
        return [tableView fd_heightForCellWithIdentifier:@"GWSearchAuthorCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:@"GWSearchContentCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GWSearchSectionHeaderCell *headerCell = (GWSearchSectionHeaderCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GWSearchSectionHeaderCell"];
    headerCell.title = self.titleDict.allValues[section];
    return headerCell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSArray *modelArr = self.dataArr[indexPath.section];
    if (_hasAuthor && indexPath.section == 0) {
        GWSearchAuthorModel *authofModel = modelArr[indexPath.row];
        
    }
    else
    {
        GWSearchInfoModel *model = modelArr[indexPath.row];
        GWNewsDetailViewController *newsDetailVC = [[GWNewsDetailViewController alloc] initWithContentId:model.content_id];
        [self.navigationController pushViewController:newsDetailVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
