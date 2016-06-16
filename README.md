###AblettKit

> ablett 是自己在做项目是写的一些控件和工具，正在整理中...

* PayPwdView （支付密码）

> 使用方法

```
ACPayPwdAlert *pwdAlert = [[ACPayPwdAlert alloc] init];
pwdAlert.title = @"请输入支付密码";
pwdAlert.completeAction = ^(NSString *pwd){
   NSLog(@"==pwd:%@", pwd);
};
[pwdAlert show];

```

> 效果图

![image](https://github.com/AblettChen/ACPayPwdView/blob/master/PayPwdView.gif)

* UIViewController+NavigationBar.h （自定义 NavigationBar）

> 使用方法

```
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

```
> 效果图

![image](https://github.com/AblettChen/ACPayPwdView/blob/master/NavigationBar.gif)


