//
//  RootTabBarController.m
//  Ablett
//
//  Created by ablett on 16/6/7.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "RootTabBarController.h"
#import "CustomUIViewController.h"
#import "NetworkViewController.h"


@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CustomUIViewController *customUIVc = [[CustomUIViewController alloc] init];
    UITabBarItem *customUIItem = [[UITabBarItem alloc] initWithTitle:@"customUI" image:[UIImage imageNamed:@"tabBar_icon_contrast_default"] selectedImage:[UIImage imageNamed:@"tabBar_icon_contrast"]];
    customUIVc.title = @"customUI";
    customUIVc.tabBarItem = customUIItem;
    ACBaseNavigationController *customUINc = [[ACBaseNavigationController alloc] initWithRootViewController:customUIVc];
    
    NetworkViewController *networkVc = [[NetworkViewController alloc] init];
    UITabBarItem *networkItem = [[UITabBarItem alloc] initWithTitle:@"network" image:[UIImage imageNamed:@"tabBar_icon_plan_default"] selectedImage:[UIImage imageNamed:@"tabBar_icon_plan"]];
    networkVc.title = @"network";
    networkVc.tabBarItem = networkItem;
    ACBaseNavigationController *networkNc = [[ACBaseNavigationController alloc] initWithRootViewController:networkVc];
    
    self.viewControllers = @[customUINc, networkNc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
