//
//  NSString+Formatting.h
//  YiRong
//
//  Created by ablett on 16/5/25.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ACNumberType) {
    kACNumberTypePhone = 1,
    kACNumberTypeBankCard,
    kACNumberTypeIdCard,
};

@interface NSString (Formatting)

+ (NSString *)stringWithNumberStr:(NSString *)numberStr numberType:(ACNumberType)numberType;
- (NSString *)removeSpace;

@end
