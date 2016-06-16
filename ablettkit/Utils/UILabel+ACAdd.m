//
//  UILabel+ACAdd.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "UILabel+ACAdd.h"

@implementation UILabel (ACAdd)

+ (instancetype)labelWithText:(NSString *)text
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                         font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:text];
    [label setTextColor:textColor];
    [label setTextAlignment:textAlignment];
    [label setFont:font];
    return label;
}

@end
