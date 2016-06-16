//
//  ShareVC.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ShareVC.h"
#import "ACShareManager.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.ac_navigationItem.title = @"share view";
    
    ACShareManager *shareMgr = [[ACShareManager alloc] init];
    [self configNavigationRightItemWithObject:[UIImage imageNamed:@"btn_share_theme"] action:^{
        [shareMgr showInView:self content:@"hello" image:nil url:nil];
    }];
    self.ac_navigationItem.rightBarButtonItem.tintColor = kTextColor;
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
