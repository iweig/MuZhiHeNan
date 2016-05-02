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
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8, 5, 30, 20)];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        _btn = btn;
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_btn.frame), 5, kScreenSize.width - CGRectGetWidth(_btn.frame), 20)];
        [self addSubview:lblTitle];
        _lblTitle = lblTitle;
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

@end
