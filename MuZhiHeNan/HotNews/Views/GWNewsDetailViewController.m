//
//  GWNewsDetailViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/3.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsDetailViewController.h"
#import "GWNewsDetailHeaderCell.h"
#import "GWNewsDetailModel.h"


@interface GWNewsDetailViewController () <UITableViewDataSource, UITableViewDelegate, GWNewsDetailHeaderCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GWNewsDetailHeaderCell *newsDetailHeaderCell;

@end

@implementation GWNewsDetailViewController

- (instancetype)initWithContentId:(NSString *)contentId
{
    if (self = [super init]) {
        _content_id = contentId;
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
    GWNewsDetailHeaderCell *newsDetailHeaderCell = [[GWNewsDetailHeaderCell alloc ] init];
    newsDetailHeaderCell.delegate = self;
    self.newsDetailHeaderCell = newsDetailHeaderCell;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 20)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -UITableViewDataSource

#pragma mark -UITableViewDelegate

#pragma mark -网络请求
- (void)getData
{
    kWeakSelf
    NSDictionary *dict = @{@"user_id":kUserId,@"token":kToken,@"content_id":_content_id};
    [HttpManager GET:kGetNewsDetail parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GWNewsDetailModel *newsDetailModel = [GWNewsDetailModel newsDetailModelWithDict:responseObject];
        weakSelf.newsDetailHeaderCell.model = newsDetailModel;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -GWNewsDetailHeaderCellDelegate
- (void)newsDetailHeaderCell:(GWNewsDetailHeaderCell *)cell cellHeight:(CGFloat)height
{
    self.newsDetailHeaderCell.frame = CGRectMake(0, 0, kScreenSize.width, height);
    self.tableView.tableHeaderView = self.newsDetailHeaderCell;
    [self.view addSubview:self.tableView];
}

@end
