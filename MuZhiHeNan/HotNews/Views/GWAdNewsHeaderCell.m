//
//  GWAdNewsHeaderCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWAdNewsHeaderCell.h"

@interface GWAdNewsHeaderCell ()

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UILabel *lblTitle;


@end


@implementation GWAdNewsHeaderCell


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 7, 28, 16)];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:btn];
        _btn = btn;
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_btn.frame) + 8, 5, kScreenSize.width - CGRectGetWidth(_btn.frame), 16)];
        lblTitle.font = [UIFont systemFontOfSize:10.0];
        lblTitle.center = CGPointMake(lblTitle.center.x, 15.0);
        [self addSubview:lblTitle];
        _lblTitle = lblTitle;
        
        //为headerView添加点击事件
        UIButton *bgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 30)];
        [bgBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgBtn];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lblTitle.text = title;
}

- (void)setCatname:(NSString *)catname
{
    _catname = catname;
    [self.btn setTitle:_catname forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"biaoqian_01"] forState:UIControlStateNormal];
}

- (void)btnClick
{
    NSLog(@"GWAdNewsHeaderCell");
}

@end
