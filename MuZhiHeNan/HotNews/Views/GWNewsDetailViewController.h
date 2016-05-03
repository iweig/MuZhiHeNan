//
//  GWNewsDetailViewController.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/3.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWNewsDetailViewController : UIViewController

@property (nonatomic, copy) NSString *content_id;

- (instancetype)initWithContentId:(NSString *)contentId;

@end
