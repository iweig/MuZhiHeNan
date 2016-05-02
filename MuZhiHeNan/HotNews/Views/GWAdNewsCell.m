//
//  GWAdNewsCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWAdNewsCell.h"

@interface GWAdNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;

@end

@implementation GWAdNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setExpandModel:(GWExpandModel *)expandModel
{
    _expandModel = expandModel;
    [self.thumbImageView sd_setImageWithURL:kNSUrl(expandModel.thumb) placeholderImage:[UIImage imageNamed:@"home_logo01"]];
}

@end
