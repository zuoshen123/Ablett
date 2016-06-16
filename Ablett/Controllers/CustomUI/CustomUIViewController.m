//
//  CustomUIViewController.m
//  Ablett
//
//  Created by ablett on 16/6/7.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "CustomUIViewController.h"
#import "CustomNavigaitonBarVC.h"
#import "PayPwdVC.h"
#import "DemoCell.h"

#define kSection(index) [NSString stringWithFormat:@"section%ld",(long)index]

static NSString const*kTitle = @"title";

@interface CustomUIViewController ()
{
    NSDictionary *_dataDic;
}
@end

@implementation CustomUIViewController

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
    
    if ([_dataDic[kSection(indexPath.section)][kTitle][indexPath.row] isEqualToString:@"自定义 navigationBar"]) {
        CustomNavigaitonBarVC *cnVc = [CustomNavigaitonBarVC new];
        [self.navigationController pushViewController:cnVc animated:YES];
    }else if ([_dataDic[kSection(indexPath.section)][kTitle][indexPath.row] isEqualToString:@"支付密码"]) {
        PayPwdVC *payPwdVc = [PayPwdVC new];
        [self.navigationController pushViewController:payPwdVc animated:YES];
    }
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.ac_navigationItem.title = @"custom UI";
    
    _dataDic = @{kSection(0l):@{kTitle:@[@"自定义 navigationBar", \
                                         @"支付密码"]},
                 kSection(1l):@{kTitle:@[@"..."]}
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

@end
