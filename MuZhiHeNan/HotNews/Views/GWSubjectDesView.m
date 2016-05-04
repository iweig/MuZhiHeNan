//
//  GWSubjectDesView.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSubjectDesView.h"
#import "GWSubjectModel.h"

@interface GWSubjectDesView ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDes;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (nonatomic, strong) NSArray *btnArr;

@end

@implementation GWSubjectDesView

- (void)awakeFromNib {
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"btn_zhuanti01"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"btn_zhuanti01"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"btn_zhuanti01"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"btn_zhuanti01"] forState:UIControlStateNormal];
    _btnArr = @[self.btn1,self.btn2,self.btn3,self.btn4];
}

+ (instancetype)getSubjectDesView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GWSubjectDesView" owner:nil options:nil] lastObject];
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.lblTitle.text = dict[@"title"];
    self.lblDes.text = dict[@"brief"];
    [self.thumbImageView sd_setImageWithURL:kNSUrl(dict[@"thumb"])];
     NSArray *lists = dict[@"lists"];
    for (int i = 0; i < lists.count; i++) {
        GWSubjectModel *subModel = lists[i];
        UIButton *btn = self.btnArr[i];
        [btn setTitle:subModel.name forState:UIControlStateNormal];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(subjectDesView:selectedIndex:)]) {
        [_delegate subjectDesView:self selectedIndex:btn.tag - 1000];
    }
}

@end
