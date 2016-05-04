//
//  GWSubjectHeaderCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSubjectHeaderCell.h"

@interface GWSubjectHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation GWSubjectHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lblTitle.text = title;
}

@end
