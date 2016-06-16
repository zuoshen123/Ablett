//
//  ACBaseViewController.m
//  Ablett
//
//  Created by ablett on 16/6/7.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ACBaseViewController.h"

static CGFloat const NBH = 64;

@interface ACBaseViewController ()

@end

@implementation ACBaseViewController

#pragma mark - Pubilc

- (void)configurViews {
    
}

#pragma mark - Privite

- (void)customNavigationBar {
    // 自定义的navbar
    self.ac_navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, NBH)];
    [self.view addSubview:self.ac_navigationBar];
    // 设置item
    self.ac_navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    self.ac_navigationBar.items = @[self.ac_navigationItem];
}

#pragma mark - Life cycle

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self customNavigationBar];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBgColor;
    [self configurViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
