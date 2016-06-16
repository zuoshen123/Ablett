//
//  UILabel+ACAdd.h
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ACAdd)

+ (instancetype)labelWithText:(NSString *)text
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment
                         font:(UIFont *)font;

@end
