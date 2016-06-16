//
//  PayPwdModifyVC.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "PayPwdModifyVC.h"
#import "ACPayPwdView.h"


@interface PayPwdModifyVC ()
@property (strong, nonatomic) ACPayPwdView *payPwdView;
@end

@implementation PayPwdModifyVC

- (void)configurViews {
    self.payPwdView = [[ACPayPwdView alloc] init];
    self.payPwdView.payPwdState = kACPayPwdStateVerify;
    
    __weak typeof(&*self.payPwdView)weakPayPwdView = self.payPwdView;
    self.payPwdView.verifyDidCompletion = ^(NSString *pwd) {
        //发起请求，验证是否正确，如果正确，则改变为设置状态/ 如果错误，清空状态重新输入
        weakPayPwdView.payPwdState = kACPayPwdStateSetting;
    };
    [self.view addSubview:self.payPwdView];
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.ac_navigationItem.title = @"payPwd modify";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.payPwdView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
