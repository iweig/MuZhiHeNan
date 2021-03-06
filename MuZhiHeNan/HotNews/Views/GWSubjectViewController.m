//
//  GWSubjectViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSubjectViewController.h"
#import "GWSubjectModel.h"
#import "GWNewStyleOneCell.h"
#import "GWSubjectHeaderCell.h"
#import "GWSubjectDesView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "GWNewsDetailViewController.h"

#define kBtnReturnTopFrame CGRectMake(kScreenSize.width - 60, kScreenSize.height + 50, 44, 44)

@interface GWSubjectViewController () <UITableViewDataSource, UITableViewDelegate, GWSubjectDesViewDelegate>
{
    CGFloat _lastOffsetY;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic ,strong) GWSubjectDesView *desView;

@property (nonatomic, strong) UIButton *btnReturnTop;

@end

@implementation GWSubjectViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self getData];
}

- (instancetype)initWithSpecialId:(NSString *)specialId
{
    if (self = [super init]) {
        self.specialId = specialId;
    }
    return self;
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 30;
    [tableView registerNib:[UINib nibWithNibName:@"GWNewStyleOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewStyleOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWSubjectHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWSubjectHeaderCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *btnReturnTop = [[UIButton alloc] initWithFrame:kBtnReturnTopFrame];
    [btnReturnTop setBackgroundImage:[UIImage imageNamed:@"btn_top_fanhui"] forState:UIControlStateNormal];
    [btnReturnTop addTarget:self action:@selector(onReturnTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:btnReturnTop aboveSubview:self.tableView];
    self.btnReturnTop = btnReturnTop;

}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataDict) {
        NSArray *lists = self.dataDict[@"lists"];
        return lists.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GWSubjectModel *model = (GWSubjectModel *)self.dataDict[@"lists"][section];
    return model.lists.count;
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GWSubjectHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GWSubjectHeaderCell"];
    GWSubjectModel *model = self.dataDict[@"lists"][section];
    cell.title = model.name;
    return cell;
}

- (void)configureCell:(GWNewStyleOneCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSArray *modelArr = self.dataDict[@"lists"];
    GWSubjectModel *subjectModel = modelArr[indexPath.section];
    cell.newsModel = subjectModel.lists[indexPath.row];
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    GWSubjectModel *subjectModel = self.dataDict[@"lists"][indexPath.section];
    GWNewsModel *newsModel = subjectModel.lists[indexPath.row];
    GWNewsDetailViewController *newsDetailVC = [[GWNewsDetailViewController alloc] initWithContentId:newsModel.content_id];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

#pragma mark -网络请求
- (void)getData
{
    kWeakSelf
    NSDictionary *dict = @{@"special_id":_specialId,@"user_id":kUserId,@"token":kToken};
    ;
    [HttpManager GET:kGetSpecialContent parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:responseObject[@"title"] forKey:@"title"];
        [dict setObject:responseObject[@"thumb"] forKey:@"thumb"];
        [dict setObject:responseObject[@"brief"] forKey:@"brief"];
        NSMutableArray *modelArr = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"lists"]) {
            GWSubjectModel *model = [GWSubjectModel subjectModelWithDict:dict];
            [modelArr addObject:model];
        }
        [dict setObject:modelArr forKey:@"lists"];
        weakSelf.dataDict = dict;
        [weakSelf.tableView reloadData];
        [weakSelf loadSubjectDes];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -GWSubjectDesViewDelegate
- (void)subjectDesView:(GWSubjectDesView *)view selectedIndex:(NSInteger)index
{

    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)loadSubjectDes
{
    GWSubjectDesView *desView = [GWSubjectDesView getSubjectDesView];
    desView.dict = self.dataDict;
    desView.delegate = self;
    self.tableView.tableHeaderView = desView;
    self.desView = desView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 30 && offsetY > _lastOffsetY) {
        [UIView animateWithDuration:0.25 animations:^{
            self.btnReturnTop.frame = CGRectMake(kBtnReturnTopFrame.origin.x, kScreenSize.height - 70 - 50, kBtnReturnTopFrame.size.width, kBtnReturnTopFrame.size.height);
        }];
    }
    else if(offsetY > 20)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.btnReturnTop.frame = kBtnReturnTopFrame;
        }];
    }
    _lastOffsetY = offsetY;
}

- (void)onReturnTop
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
