//
//  GWCategoryListViewController.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWCategoryListViewController : UIViewController

@property (nonatomic, copy) NSString *catId;

- (instancetype)initWithCatId:(NSString *)catId;

@end
