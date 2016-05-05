
//
//  GWCustonViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWCustonViewController.h"

@implementation GWCustonViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpNav];
}

- (void)setUpNav
{
    //初始化nav leftNavigationItem
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithImage:[[GWBundleManager shareBundleManager] imageWithName:@"addRootBlock_toolbar_return" bundleString:@"theme_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnItemClick)];
    self.navigationItem.leftBarButtonItem = returnItem;
}

- (void)returnItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
