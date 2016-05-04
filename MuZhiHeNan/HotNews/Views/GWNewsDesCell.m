//
//  GWNewsDetailHeaderCell.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsDesCell.h"

@interface GWNewsDesCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UILabel *lblCopyFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblCatname;

@end

@implementation GWNewsDesCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(GWNewsDetailModel *)model
{
    _model = model;
    self.lblTitle.text = model.title;
    self.lblCopyFrom.text = model.copyfrom;
    self.lblTime.text = model.inputtime;
    self.lblCatname.text = model.catname;
}


@end
