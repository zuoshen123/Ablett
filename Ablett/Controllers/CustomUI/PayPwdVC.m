//
//  PayPwdVC.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "PayPwdVC.h"
#import "DemoCell.h"
#import "PayPwdSettingVC.h"
#import "PayPwdModifyVC.h"

#define kSection(index) [NSString stringWithFormat:@"section%ld",(long)index]

static NSString const*kTitle = @"title";

@interface PayPwdVC ()
{
    NSDictionary *_dataDic;
}
@end

@implementation PayPwdVC

#pragma mark - Overwrite

- (void)configurViews {
}

#pragma mark Setter/Getter


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataDic[kSection(section)][kTitle] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell"];
    if (!cell) {
        cell = [DemoCell new];
    }
    cell.title = _dataDic[kSection(indexPath.section)][kTitle][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_dataDic[kSection(indexPath.section)][kTitle][indexPath.row] isEqualToString:@"设置支付密码"]) {
        
        PayPwdSettingVC *payPwdVc = [PayPwdSettingVC new];
        [self.navigationController pushViewController:payPwdVc animated:YES];
        
    }else if ([_dataDic[kSection(indexPath.section)][kTitle][indexPath.row] isEqualToString:@"修改支付密码"]) {
        
        PayPwdModifyVC *payPwdModifyVc = [PayPwdModifyVC new];
        [self.navigationController pushViewController:payPwdModifyVc animated:YES];
        
    }else if ([_dataDic[kSection(indexPath.section)][kTitle][indexPath.row] isEqualToString:@"验证支付密码"]) {
        
        ACPayPwdAlert *pwdAlert = [[ACPayPwdAlert alloc] init];
        pwdAlert.title = @"请输入支付密码";
        [pwdAlert show];
        pwdAlert.completeAction = ^(NSString *pwd) {
            NSLog(@"pwd:%@", pwd);
        };
    }
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.ac_navigationItem.title = @"pay password";
    
    _dataDic = @{kSection(0l):@{kTitle:@[@"设置支付密码", \
                                         @"修改支付密码"]},
                 kSection(1l):@{kTitle:@[@"验证支付密码"]}
                 };
    
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
