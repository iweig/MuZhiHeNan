//
//  GWCategoryHeaderReusableView.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWCategoryHeaderReusableView.h"

@interface GWCategoryHeaderReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;


@end

@implementation GWCategoryHeaderReusableView

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithHexString:@"ff3030"];

}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lblTitle.text = title;
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.lblSubTitle.text = subTitle;
}

@end
