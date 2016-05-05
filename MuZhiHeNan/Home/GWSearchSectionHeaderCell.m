//
//  GWSearchSectionHeaderCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/5.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSearchSectionHeaderCell.h"

@interface GWSearchSectionHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic)  UIButton *lblBtn;


@end

@implementation GWSearchSectionHeaderCell

- (void)awakeFromNib {

}

- (void)setTitle:(NSString *)title
{
    self.lblBtn.hidden = NO;
    if ([title isEqualToString:@"作者"])
    {
        self.lblTitle.text = kNSString(@"相关%@",title);
        [self.lblBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    }
    else if ([title isEqualToString:@"标题"])
    {
        self.lblTitle.text = kNSString(@"相关%@",title);
        [self.lblBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    }
    else
    {
        self.lblTitle.text = kNSString(@"相关%@",title);
        self.lblBtn.hidden = YES;
    }
}

@end
