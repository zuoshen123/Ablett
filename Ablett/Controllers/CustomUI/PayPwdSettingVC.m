//
//  PayPwdSettingVC.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "PayPwdSettingVC.h"
#import "ACPayPwdView.h"

@interface PayPwdSettingVC ()
@property (strong, nonatomic) ACPayPwdView *payPwdView;
@end

@implementation PayPwdSettingVC

- (void)configurViews {
    self.payPwdView = [[ACPayPwdView alloc] init];
    self.payPwdView.payPwdState = kACPayPwdStateSetting;
    
    __weak typeof(&*self.payPwdView)weakPayPwdView = self.payPwdView;
        self.payPwdView.settingDidCompletion = ^(NSString *pwd) {
        //发起请求，传给 server
        NSLog(@"pwd:%@", pwd);
    };
    [self.view addSubview:self.payPwdView];
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.ac_navigationItem.title = @"payPwd setting";
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
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
