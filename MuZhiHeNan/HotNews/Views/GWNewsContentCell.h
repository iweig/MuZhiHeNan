//
//  GWNewsContentCell.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWNewsDetailModel.h"

@class GWNewsContentCell;

@protocol  GWNewsContentCellDelegate<NSObject>

- (void)newsContentCell:(GWNewsContentCell *)cell cellHeight:(CGFloat)height;

@end

@interface GWNewsContentCell : UITableViewCell

@property (nonatomic, strong) GWNewsDetailModel *model;
@property (nonatomic, weak) id<GWNewsContentCellDelegate> delegate;


@end
