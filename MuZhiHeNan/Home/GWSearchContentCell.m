//
//  GWSearchContentCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/5.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSearchContentCell.h"

@interface GWSearchContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

@implementation GWSearchContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSearchModel:(GWSearchInfoModel *)searchModel
{
    _searchModel = searchModel;
    self.lblTime.text = searchModel.created;
    self.lblTitle.text = searchModel.title;
}

@end
