//
//  NSString+Formatting.m
//  YiRong
//
//  Created by ablett on 16/5/25.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "NSString+Formatting.h"

@implementation NSString (Formatting)

+ (NSString *)stringWithNumberStr:(NSString *)numberStr numberType:(ACNumberType)numberType {
    
    NSInteger headLenght = 0, middleLength = 0;
    
    switch (numberType) {
        case kACNumberTypePhone:{
            headLenght = 3;
            middleLength = 4;
            break;
        }
        case kACNumberTypeBankCard:{
            headLenght = 4;
            middleLength = 4;
            break;
        }
        case kACNumberTypeIdCard:{
            headLenght = 6;
            middleLength = 8;
            break;
        }
    }
    return [self stringWithNoStr:numberStr formatSeparateHeadLenght:headLenght middleLength:middleLength];
}

+ (NSString *)stringWithNoStr:(NSString *)noStr formatSeparateHeadLenght:(NSInteger)headLenght middleLength:(NSInteger)middleLength {
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789X\b"];
    noStr = [noStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *formatStr = @"";
    int firstNumber = 0;
    while (noStr.length > 0) {
        NSString *subString = [noStr substringToIndex:MIN(noStr.length, firstNumber==0?headLenght:middleLength)];
        formatStr = [formatStr stringByAppendingString:subString];
        if (subString.length == firstNumber==0?headLenght:middleLength) {
            formatStr = [formatStr stringByAppendingString:@" "];
        }
        noStr = [noStr substringFromIndex:MIN(noStr.length, firstNumber==0?headLenght:middleLength)];
        firstNumber++;
    }
    
    formatStr = [formatStr stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    return formatStr;
}

- (NSString *)removeSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
