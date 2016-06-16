//
//  UITextField+Formatting.h
//  YiRong
//
//  Created by ablett on 16/5/25.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Formatting)

+ (BOOL)bankCardTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
+ (BOOL)telephoneTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
+ (BOOL)moneyTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
