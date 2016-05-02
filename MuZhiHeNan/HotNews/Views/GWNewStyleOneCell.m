//
//  GWNewStyleOneCell.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewStyleOneCell.h"

@interface GWNewStyleOneCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCatName;
@property (weak, nonatomic) IBOutlet UILabel *lblViews;
@property (weak, nonatomic) IBOutlet UIButton *btnCatName;

@end

@implementation GWNewStyleOneCell

- (void)awakeFromNib {
    [self.btnCatName setTitleColor:[UIColor colorWithHexString:@"#d0161f"] forState:UIControlStateNormal];
    [self.btnCatName setBackgroundImage:[UIImage imageNamed:@"biaoqian_01"] forState:UIControlStateNormal];
    self.btnCatName.titleLabel.font = [UIFont systemFontOfSize:10.0];
    self.btnCatName.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)setNewsModel:(GWNewsModel *)newsModel
{
    _newsModel = newsModel;
    [self.thumbImageView sd_setImageWithURL:kNSUrl(newsModel.thumb) placeholderImage:[UIImage imageNamed:@"home_logo01"]];
    self.lblTitle.text = newsModel.title;
    [self.btnCatName setTitle:newsModel.catname forState:UIControlStateNormal];
    self.lblViews.text = kNSString(@"%ld",newsModel.views);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
