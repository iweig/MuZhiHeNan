//
//  GWSubjectViewController.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWSubjectViewController : UIViewController

@property (nonatomic, copy) NSString *specialId;

- (instancetype)initWithSpecialId:(NSString *)specialId;

@end
