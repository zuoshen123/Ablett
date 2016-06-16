//
//  CountDownVC.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "CountDownVC.h"

@interface CountDownVC ()
@property (strong, nonatomic) UIButton *countdownBtn;
@end

@implementation CountDownVC

- (void)configurViews {
    
    self.countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom]; /** UIButtonTypeCustom 否则会出现闪烁*/
    self.countdownBtn.frame = CGRectMake(0, 0, 40*4, 40);
    [self.countdownBtn setBackgroundColor:[UIColor blackColor]];
    [self.countdownBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [self.countdownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.countdownBtn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.countdownBtn addTarget:self action:@selector(countdownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countdownBtn];
    self.countdownBtn.center = self.view.center;
}

- (void)countdownAction:(id)sender {
    [self.countdownBtn startWithTime:5
                          title:@"获取短信验证码"
                 countDownTitle:@"秒后重新发送"
                      mainColor:[UIColor blackColor]
                     countColor:[UIColor darkGrayColor]];
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.ac_navigationItem.title = @"countdown";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
