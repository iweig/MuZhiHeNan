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

#define kSearchBarFrmae CGRectMake(60, 0, kScreenSize.width - 100, 44)

@interface GWSearchViewController () <UISearchBarDelegate>
{
    NSInteger _offset;
}
@property (nonatomic, strong) SKTagView *tagView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *hotwordsArr;

@end

@implementation GWSearchViewController

- (NSMutableArray *)hotwordsArr
{
    if (!_hotwordsArr) {
        _hotwordsArr = [NSMutableArray array];
    }
    return _hotwordsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = [UIColor whiteColor];
        view.padding = UIEdgeInsetsMake(8, 10, 8, 10);
        view.interitemSpacing = 10;
        view.lineSpacing = 10;
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
            tag.fontSize = 15;
            tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
            [weakSelf.tagView addTag:tag];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getSearchDataByWords:(NSString *)words
{
    NSDictionary *dict = @{@"content":words,@"offset":kNSString(@"%ld",_offset)};
    [HttpManager GET:kSearch parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}


@end
