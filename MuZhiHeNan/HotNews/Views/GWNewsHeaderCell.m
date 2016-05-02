//
//  GWNewsHeaderCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsHeaderCell.h"

@implementation GWNewsHeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    CGRect rect = self.frame;
    rect.size.width = kScreenSize.width;
    self.frame = rect;
}


@end
