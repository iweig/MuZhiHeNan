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

@end

@implementation GWNewStyleOneCell

- (void)awakeFromNib {
    self.lblCatName.textColor = [UIColor colorWithHexString:@"#d0161f"];
    self.lblCatName.layer.masksToBounds = YES;
}

- (void)setNewsModel:(GWNewsModel *)newsModel
{
    _newsModel = newsModel;
    [self.thumbImageView sd_setImageWithURL:kNSUrl(newsModel.thumb) placeholderImage:[UIImage imageNamed:@"home_logo01"]];
    self.lblTitle.text = newsModel.title;
    self.lblCatName.text = newsModel.catname;
    self.lblViews.text = kNSString(@"%ld",newsModel.views);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
