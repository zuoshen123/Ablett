###AblettKit

> ablett 是自己在做项目时写的一些控件和工具，正在整理中...

##### ACPayPwdView（设置支付密码、修改支付密码）、ACPayPwdAlert（验证支付密码）

> 使用方法

1. 设置支付密码

	* 引入 `ACPayPwdView.h`
	
	``` Objective-C
	
    self.payPwdView = [[ACPayPwdView alloc] init];
    self.payPwdView.payPwdState = kACPayPwdStateSetting;
    
    __weak typeof(&*self.payPwdView)weakPayPwdView = self.payPwdView;
    self.payPwdView.settingDidCompletion = ^(NSString *pwd) {
    //发起请求，传给 server
    NSLog(@"pwd:%@", pwd);
    };
    [self.view addSubview:self.payPwdView];
    
	```  

2. 修改支付密码

	*  引入 `ACPayPwdView.h`
	
	``` Objective-C
	
   	self.payPwdView = [[ACPayPwdView alloc] init];
  		self.payPwdView.payPwdState = kACPayPwdStateVerify;
   
  		 __weak typeof(&*self.payPwdView)weakPayPwdView = self.payPwdView;
   	self.payPwdView.verifyDidCompletion = ^(NSString *pwd) {
       //发起请求，验证是否正确，如果正确，则改变为设置状态/ 如果错误，清空状态重新输入
       weakPayPwdView.payPwdState = kACPayPwdStateSetting;
   	};
   	[self.view addSubview:self.payPwdView];
	```
	
3. 验证支付密码

	* 引入 `ACPayPwdAlert.h`

	``` Objective-C 
	 
	ACPayPwdAlert *pwdAlert = [[ACPayPwdAlert alloc] init];
	pwdAlert.title = @"请输入支付密码";
	pwdAlert.completeAction = ^(NSString *pwd){
	   NSLog(@"==pwd:%@", pwd);
	};
	[pwdAlert show];
	
	```

> 效果图

![image](https://github.com/AblettChen/Ablett/blob/master/ACPayPwdView.gif)

#####  UIViewController+NavigationBar.h （自定义 NavigationBar）

> 使用方法

``` Objective-C
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

![image](https://github.com/AblettChen/Ablett/blob/master/NavigationBar.gif)

##### ACShareView (社会化分享视图)

> 使用方法（完整分享需要引入友盟SDK）

`AppDelegate.m`
``` Objective-C
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[ACShareManager registerShareInfo];
}
```
`shareViewController.m`
``` Objective-C
ACShareManager *shareMgr = [[ACShareManager alloc] init];
    __weak typeof(&*shareMgr)weakShareMgr = shareMgr;
    [self configNavigationRightItemWithObject:[UIImage imageNamed:@"btn_share_theme"] action:^{
        [weakShareMgr showInView:self content:@"hello" image:nil url:nil];
    }];
```

> 效果图

![image](https://github.com/AblettChen/Ablett/blob/master/ACShareView.gif)

