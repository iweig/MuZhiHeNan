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
#import "UITableView+FDTemplateLayoutCell.h"

@interface GWSubjectViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataDict;

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 25;
    [tableView registerNib:[UINib nibWithNibName:@"GWNewStyleOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewStyleOneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"GWSubjectHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWSubjectHeaderCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
