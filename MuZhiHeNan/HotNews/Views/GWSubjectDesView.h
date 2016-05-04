//
//  GWSubjectDesView.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GWSubjectDesView;

@protocol GWSubjectDesViewDelegate <NSObject>

- (void)subjectDesView:(GWSubjectDesView *)view selectedIndex:(NSInteger)index;

@end

@interface GWSubjectDesView : UITableViewCell

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, weak) id<GWSubjectDesViewDelegate> delegate;

+ (instancetype)getSubjectDesView;

@end
