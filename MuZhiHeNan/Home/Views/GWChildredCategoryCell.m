//
//  GWChildredCategoryCell.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWChildredCategoryCell.h"

@interface GWChildredCategoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation GWChildredCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(GWChildredCategoryModel *)model
{
    _model = model;
    [self.thumbView sd_setImageWithURL:kNSUrl(model.thumb) placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.lblTitle.text = model.catname;
    
}

@end
