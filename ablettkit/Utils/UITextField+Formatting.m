//
//  UITextField+Formatting.m
//  YiRong
//
//  Created by ablett on 16/5/25.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "UITextField+Formatting.h"

@implementation UITextField (Formatting)

+ (BOOL)bankCardTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 24) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

+ (BOOL)telephoneTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    int firstNumber = 0;
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, firstNumber==0?3:4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == firstNumber==0?3:4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, firstNumber==0?3:4)];
        firstNumber++;
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 14) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

+ (BOOL)moneyTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.\b"];
//    
//    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
//        return NO;
//    }
//    
//    BOOL isHasRadixPoint = YES;
//    NSInteger RadixPointNum = 2;
//    NSString *existText = textField.text;
//    
//    if ([existText rangeOfString:@"."].location == NSNotFound) {
//        isHasRadixPoint = NO;
//    }
//    
//    if (string.length > 0) {
//        unichar newChar = [string characterAtIndex:0];
//        if (existText.length>0) {
//            if ([existText characterAtIndex:0]=='0') {
//                if (newChar=='0') {
//                    return NO;
//                }else if((newChar > '0' && newChar <= '9') &&existText.length<=1){
//                    textField.text = @"";
//                }
//            }
//        }
//        
//        if ((newChar >= '0' && newChar <= '9') || newChar == '.' ) {
//            if (newChar == '.') {
//                if (existText.length==0) {
//                    textField.text = @"0.";
//                    return NO;
//                }else{
//                    return !isHasRadixPoint;
//                }
//            }else {
//                if (isHasRadixPoint) {
//                    NSRange ran = [existText rangeOfString:@"."];
//                    return (range.location - ran.location <= RadixPointNum);
//                } else
//                    return YES;
//            }
//        }else {
//            return YES;
//        }
//        
//    }
//    return YES;
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )         {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }else {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."]){
        return NO;
    }
    short remain = 2; //默认保留2位小数
    NSString *tempStr = [textField.text stringByAppendingString:string];         NSUInteger strlen = [tempStr length];         if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
            return NO;
        }
    }
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ) {
        return NO;
    }
    return YES;
}

@end
