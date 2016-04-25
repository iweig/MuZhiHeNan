
//
//  GWCustonViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWCustonViewController.h"

@implementation GWCustonViewController

- (GWNavigationController *)customNavigationController
{
    return (GWNavigationController *)self.navigationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    self.customNavigationController.navigationItem.leftBarButtonItem = returnItem;
}

- (void)returnItemClick
{
    [self.customNavigationController popViewControllerAnimated:YES];
}

@end