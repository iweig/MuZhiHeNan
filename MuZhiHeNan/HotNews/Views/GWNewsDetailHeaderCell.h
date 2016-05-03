//
//  GWNewsDetailHeaderCell.h
//  MuZhiHeNan
//
//  Created by gw on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWNewsDetailModel.h"
@class GWNewsDetailHeaderCell;

@protocol GWNewsDetailHeaderCellDelegate <NSObject>

- (void)newsDetailHeaderCell:(GWNewsDetailHeaderCell *)cell cellHeight:(CGFloat)height;

@end

@interface GWNewsDetailHeaderCell : UITableViewCell

@property (nonatomic, weak) id<GWNewsDetailHeaderCellDelegate> delegate;

@property (nonatomic, strong) GWNewsDetailModel *model;

@end
