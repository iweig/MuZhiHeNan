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

#define kBottomViewFrame CGRectMake(0, kScreenSize.height - 50 - 64, kScreenSize.width, 30)

#define kMargin 10
#define KBtnW 30

@interface GWNewsDetailViewController () <UITableViewDataSource, UITableViewDelegate, GWNewsContentCellDelegate,UIActionSheetDelegate>
{
    CGFloat _lastOffsetY;
    BOOL _isChangeTextSize;
    BOOL _isPrase;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GWNewsDetailModel *newsDetailModel;

@property (nonatomic, assign) CGFloat newsContentHeight;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *btnDianzan;
@property (nonatomic, strong) UIButton *btnShoucang;

@property (nonatomic, strong) UILabel *animLbl;

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

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 64)];
    [tableView registerNib:[UINib nibWithNibName:@"GWNewsDesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GWNewsDesCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self getData];
     [self createBottomView];
}

- (void)createBottomView
{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:kBottomViewFrame];
    //返回btn
    UIButton *fanhuiBtn = [[UIButton alloc] initWithFrame:CGRectMake(6, 0, KBtnW, KBtnW)];
    fanhuiBtn.contentMode = UIViewContentModeScaleToFill;
    [fanhuiBtn setBackgroundImage:[UIImage imageNamed:@"tab_fanhui"] forState:UIControlStateNormal];
    fanhuiBtn.tag = 1000;
    [fanhuiBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:fanhuiBtn];
    
    CGFloat btnX = kScreenSize.width - (KBtnW + kMargin) * 4;
    //字号btn
    UIButton *zihaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, KBtnW, KBtnW)];
    [zihaoBtn setBackgroundImage:[UIImage imageNamed:@"tab_zihao"] forState:UIControlStateNormal];
    zihaoBtn.tag = 1001;
    [zihaoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:zihaoBtn];
    
    //收藏btn
    UIButton *shoucangBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zihaoBtn.frame) + kMargin, 0, KBtnW, KBtnW)];
    [shoucangBtn setBackgroundImage:[UIImage imageNamed:@"tab_shoucang"] forState:UIControlStateNormal];
    shoucangBtn.tag = 1002;
    [shoucangBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shoucangBtn];
    self.btnShoucang = shoucangBtn;
    
    //点赞btn
    UIButton *dianzanBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shoucangBtn.frame) + kMargin, 0, KBtnW, KBtnW)];
    [dianzanBtn setBackgroundImage:[UIImage imageNamed:@"tab_zan"] forState:UIControlStateNormal];
    dianzanBtn.tag = 1003;
    [dianzanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:dianzanBtn];
    self.btnDianzan = dianzanBtn;
    
    //分享btn
    UIButton *fenxiangBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dianzanBtn.frame) + kMargin, 0, KBtnW, KBtnW)];
    [fenxiangBtn setBackgroundImage:[UIImage imageNamed:@"tab_fenxiang"] forState:UIControlStateNormal];
    fenxiangBtn.tag = 1004;
    [fenxiangBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:fenxiangBtn];
    
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag - 1000) {
        case 0:
        {
            //返回
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:
        {
            //改变字号

            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"改变字号" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"小号",@"中号",@"大号", nil];
            [actionSheet showInView:self.view];
        }
            break;
        case 2:
        {
            kWeakSelf
            //收藏
            NSDictionary *dict = @{@"content_id":self.newsDetailModel.content_id,@"user_id":kUserId,@"token":kToken};
            [HttpManager GET:kAddfavourite parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"收藏成功");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"收藏失败");
            }];
        }
            break;
        case 3:
        {
            //点赞
            
            if (_isPrase) {
                return;
            }
            kWeakSelf
            NSDictionary *dict = @{@"content_id":self.newsDetailModel.content_id,@"user_id":kUserId,@"token":kToken};
            [HttpManager GET:kDianzan parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                _isPrase = YES;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                label.text = @"+1";
                label.textColor = [UIColor redColor];
                label.center = CGPointMake(weakSelf.btnDianzan.center.x, weakSelf.bottomView.center.y);
                [weakSelf.view addSubview:label];
                weakSelf.animLbl = label;
                [UIView animateWithDuration:1.25 animations:^{
                    weakSelf.animLbl.center = CGPointMake(weakSelf.animLbl.center.x, weakSelf.animLbl.center.y - 60);
                    
                } completion:^(BOOL finished) {
                    [weakSelf.animLbl removeFromSuperview];
                    [weakSelf.btnDianzan setBackgroundImage:[UIImage imageNamed:@"tab_zan_h"] forState:UIControlStateNormal];
                }];

                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"点赞失败");
            }];

        }
            break;
        case 4:
        {
            //分享
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self changeTextSize:12];
            break;
        case 1:
            [self changeTextSize:18];
            break;
        case 2:
            [self changeTextSize:24];
            break;
        default:
            break;
    }
}

//改变字号
- (void)changeTextSize:(NSInteger)percent
{
    _isChangeTextSize = YES;
    NSString *str = [self.newsDetailModel.content componentsSeparatedByString:@"font-size:"][0];
    NSString *str2 = [self.newsDetailModel.content componentsSeparatedByString:@"px;"][1];
    NSString *content = kNSString(@"%@font-size:%ldpx;%@",str,percent,str2);
    self.newsDetailModel.content = content;
    [self getContentHeight];
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
    if (_isChangeTextSize) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        [self.tableView reloadData];
    }
    
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 2 && offsetY < _lastOffsetY) {
        [UIView animateWithDuration:.25 animations:^{
            self.bottomView.frame = kBottomViewFrame;
        }];
    }
    else
    {
        CGRect rect = kBottomViewFrame;
        rect.origin.y = rect.origin.y + 100;
        [UIView animateWithDuration:.25 animations:^{
            self.bottomView.frame = rect;
        }];
    }
    _lastOffsetY = offsetY;
    
}

@end
