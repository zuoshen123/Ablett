//
//  ACPayPwdView.h
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ACPayPwdState) {
    kACPayPwdStateVerify = 1,
    kACPayPwdStateSetting = 2,
};

@interface ACPayPwdView : UIView

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;

//dedault is kACPayPwdStateSetting
@property (assign, nonatomic) enum ACPayPwdState payPwdState;

@property (copy, nonatomic) void (^verifyDidCompletion)(NSString *pwd);
@property (copy, nonatomic) void (^settingDidCompletion)(NSString *pwd);

- (void)clear;

@end
