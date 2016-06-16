//
//  CustomNavigaitonBarVC.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "CustomNavigaitonBarVC.h"
#import "CustomNavigaitonBarDetailVC.h"


@interface CustomNavigaitonBarVC ()

@end

@implementation CustomNavigaitonBarVC

- (void)pushAction:(id)sender {
    CustomNavigaitonBarDetailVC *detailVc = [[CustomNavigaitonBarDetailVC alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.ac_navigationItem.title = @"CustomNavigaitonBarDetail";
    self.ac_navigationBar.barStyle = UIBarStyleBlack;
    self.ac_navigationBar.barTintColor = [UIColor colorWithRed:0.967 green:0.159 blue:0.047 alpha:1.000] ;
    __weak typeof(&*self)weakSelf = self;
    [self configNavigationRightItemWithObject:@"push" action:^{
        [weakSelf pushAction:nil];
    }];
    self.ac_navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
