//
//  GWBaseViewController.h
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWNavigationController.h"

@interface GWBaseViewController : UIViewController

@property (nonatomic, strong) GWNavigationController * customNavigationController;

- (void)leftItemClick;

@end
