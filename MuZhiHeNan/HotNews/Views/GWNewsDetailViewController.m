//
//  GWNewsDetailViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/3.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsDetailViewController.h"
#import "GWNewsDesCell.h"
#import "GWNewsDetailModel.h"
#import "GWNewsContentCell.h"


@interface GWNewsDetailViewController () <UITableViewDataSource, UITableViewDelegate, GWNewsContentCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GWNewsDetailModel *newsDetailModel;

@property (nonatomic, assign) CGFloat newsContentHeight;

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewsDesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewsDesCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self getData];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.newsDetailModel) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        GWNewsDesCell *newsDesCell = [tableView dequeueReusableCellWithIdentifier:@"GWNewsDesCell" forIndexPath:indexPath];
        newsDesCell.selectionStyle = UITableViewCellSelectionStyleNone;
        newsDesCell.model = self.newsDetailModel;
        return newsDesCell;
    }
    else if (indexPath.row == 1)
    {
        GWNewsContentCell *newContentCell = [[GWNewsContentCell alloc] init];
        newContentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        newContentCell.model = self.newsDetailModel;
        return newContentCell;
    }
    return nil;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return 100;
    }
    else if(indexPath.row == 1)
    {
        return self.newsContentHeight;
    }
    return 0;
}

#pragma mark -网络请求
- (void)getData
{
    kWeakSelf
    NSDictionary *dict = @{@"user_id":kUserId,@"token":kToken,@"content_id":_content_id};
    [HttpManager GET:kGetNewsDetail parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GWNewsDetailModel *newsDetailModel = [GWNewsDetailModel newsDetailModelWithDict:responseObject];
        weakSelf.newsDetailModel = newsDetailModel;
        [weakSelf getContentHeight];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getContentHeight
{
    GWNewsContentCell *newContentCell = [[GWNewsContentCell alloc] init];
    newContentCell.model = self.newsDetailModel;
    newContentCell.delegate = self;
    newContentCell.hidden = YES;
    [self.view addSubview:newContentCell];
    
}

#pragma mark -GWNewsContentCellDelegate
- (void)newsContentCell:(GWNewsContentCell *)cell cellHeight:(CGFloat)height
{
    [cell removeFromSuperview];
    self.newsContentHeight = height;
    [self.tableView reloadData];
}

@end
