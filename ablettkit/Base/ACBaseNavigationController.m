//
//  ACBaseNavigationController.m
//  Ablett
//
//  Created by ablett on 16/6/7.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ACBaseNavigationController.h"

@interface ACBaseNavigationController ()
@property (strong, nonatomic) UIButton *backBtn;
@end

@implementation ACBaseNavigationController

#pragma -
#pragma - Overwrite

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        __weak typeof(&*self)weakSelf = self;
        [viewController configNavigationLeftItemWithAction:^{
            [weakSelf popViewControllerAnimated:YES];
        }];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    // 意思是，我们仍然可以重新在push控制器的viewDidLoad方法中设置导航栏的leftBarButtonItem，
    // 如果设置了就会覆盖在push方法中设置的“返回”按钮，因为 [super push....]会加载push的控制器执行viewDidLoad方法。
    [super pushViewController:viewController animated:animated];
}

#pragma -
#pragma - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 切换时显示颜色 */
    self.view.backgroundColor = [UIColor whiteColor];
    /** 必须设置这两个属性，否则会导致pop手势失效 */
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.hidden = YES;
    
    // 不能使用这个方法，会导致pop手势失效，也不能把bar removeFromSuperView
    // [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
