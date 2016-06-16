//
//  ACPayPwdView.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ACPayPwdView.h"
#import "ACPwdInputView.h"

#define kWarningColor [UIColor colorWithRed:0.969 green:0.161 blue:0.047 alpha:1.000]

typedef NS_ENUM(NSUInteger, ACPayPwdSetState) {
    kACPayPwdSetStateOne = 1,
    kACPayPwdSetStateSec = 2,
};

@interface ACPayPwdView ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) ACPwdInputView *pwdInputView;
@property (assign, nonatomic) enum ACPayPwdSetState payPwdSetState;
@property (copy, nonatomic) NSString *tempPwd;
@end

@implementation ACPayPwdView

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    [self.pwdInputView becomeFirstResponder];
    return self;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.backgroundColor = [UIColor clearColor];
    self.pwdInputView.length = 6;
    self.titleLabel = [UILabel labelWithText:@"--"
                                   textColor:UIColorHex(@"#434343")
                               textAlignment:NSTextAlignmentCenter
                                        font:[UIFont systemFontOfSize:16.f]];
    
    self.detailLabel = [UILabel labelWithText:@"--"
                                    textColor:kWarningColor//UIColorHex(@"#F7290C")
                                textAlignment:NSTextAlignmentCenter
                                         font:[UIFont systemFontOfSize:12.f]];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.pwdInputView];
    [self addSubview:self.detailLabel];
    
    /** 设置默认状态 */
    self.payPwdState = kACPayPwdStateSetting;
    self.payPwdSetState = kACPayPwdSetStateOne;
    
    __weak typeof(&*self)weakSelf = self;
    self.pwdInputView.inputDidCompletion = ^(NSString *pwd) {
        
        if(pwd.length == 6) {
            switch (weakSelf.payPwdState) {
                case kACPayPwdStateVerify:{
                    if (weakSelf.verifyDidCompletion) {
                        weakSelf.verifyDidCompletion(pwd);
                    }
                    break;
                }
                case kACPayPwdStateSetting:{
                    switch (weakSelf.payPwdSetState) {
                        case kACPayPwdSetStateOne:{
                            
                            //存入初次输入密码，并将状态改为 kACPayPwdSetStateSec
                            weakSelf.tempPwd = pwd;
                            weakSelf.payPwdSetState = kACPayPwdSetStateSec;
                            break;
                        }
                        case kACPayPwdSetStateSec:{
                            
                            //两次输入一致，将 pwd 回传给 Block
                            if ([weakSelf.tempPwd isEqualToString:pwd]) {
                                weakSelf.detail = @"( 输入正确 )";
                                if (weakSelf.settingDidCompletion) {
                                    weakSelf.settingDidCompletion(pwd);
                                }
                            }else {
                                //不一致，提示输入不一致，并清空状态重新输入
                                weakSelf.detail = @"( 两次输入不一致，请重新输入 )";
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [weakSelf clear];
                                    [weakSelf setNeedsDisplay];
                                });
                            }
                            
                            break;
                        }
                    }
                    break;
                }
            }
        };
    };
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(&*self)weakSelf = self;
    
    CGFloat padding = 15.f;
    CGFloat margin = 20.f;
    
    CGFloat labelH = 20.f;
    CGSize pwdSize = CGSizeMake(kScreenW*0.6, kScreenW*0.6/self.pwdInputView.length);
    
    self.frame = CGRectMake(0, 64, kScreenW, padding*2+margin*2+labelH*2+pwdSize.height);
    self.center = CGPointMake(kScreenW/2, (kScreenH-216)/2);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(pwdSize.width, labelH));
        make.top.mas_equalTo(padding);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.pwdInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(pwdSize);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(margin);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(pwdSize.width, labelH));
        make.top.equalTo(weakSelf.pwdInputView.mas_bottom).offset(margin);
        make.centerX.equalTo(weakSelf);
    }];
}

#pragma mark - Setter/Getter

- (ACPwdInputView *)pwdInputView {
    if (!_pwdInputView) {
        _pwdInputView = [[ACPwdInputView alloc] init];
    }
    return _pwdInputView;
}

- (void)setPayPwdState:(enum ACPayPwdState)payPwdState {
    _payPwdState = payPwdState;
    switch (payPwdState) {
        case kACPayPwdStateVerify:{
            self.title = @"请输入原支付密码";
            self.detail = @"";
            break;
        }
        case kACPayPwdStateSetting:{
            self.title = @"请输入6位新支付密码";
            self.detail = @"( 请勿与银行卡密码相同 )";
            break;
        }
    }
    
    __weak typeof(&*self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf clear];
        [weakSelf setNeedsDisplay];
    });
}

- (void)setPayPwdSetState:(enum ACPayPwdSetState)payPwdSetState {
    _payPwdSetState = payPwdSetState;
    switch (payPwdSetState) {
        case kACPayPwdSetStateOne:{
            self.title = @"请输入6位新支付密码";
            self.detail = @"( 请勿与银行卡密码相同 )";
            break;
        }
        case kACPayPwdSetStateSec:{
            self.title = @"请重复输入6位支付密码";
            self.detail = @"( 请勿与银行卡密码相同 )";
            break;
        }
    }
    
    __weak typeof(&*self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf clear];
        [weakSelf setNeedsDisplay];
    });
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    self.detailLabel.text = detail;
}

#pragma mark - Public

- (void)clear {
    [self.pwdInputView clear];
    [self setNeedsDisplay];
}

@end
