//
//  GWAdNewsHeaderCell.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GWAdNewsHeaderCell;

@protocol GWAdNewsHeaderCellDelegate <NSObject>

- (void)adNewsHeaderCell:(GWAdNewsHeaderCell *)adNewsHeaderCell;

@end

@interface GWAdNewsHeaderCell : UITableViewHeaderFooterView

@property (nonatomic, weak) id<GWAdNewsHeaderCellDelegate> delegate;

@property (nonatomic, copy) NSString *catname;
@property (nonatomic, copy) NSString *title;

@end
