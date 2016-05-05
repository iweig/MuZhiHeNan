//
//  GWSearchAuthorCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/5.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSearchAuthorCell.h"

@interface GWSearchAuthorCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end

@implementation GWSearchAuthorCell

- (void)awakeFromNib {
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2.0;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setAuthorModel:(GWSearchAuthorModel *)authorModel
{
    _authorModel = authorModel;
    if (![authorModel.avatar isEqualToString:@""]) {
        [self.iconImageView sd_setImageWithURL:kNSUrl(authorModel.avatar)];
    }
    else
    {
        self.iconImageView.image = [UIImage imageNamed:@"pic_30"];
    }
    self.lblName.text = authorModel.realname;
}

@end
