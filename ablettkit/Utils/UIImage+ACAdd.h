//
//  UIImage+ACAdd.h
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ACAdd)

+ (nullable UIImage *)imageWithColor:(UIColor *)color;
+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
NS_ASSUME_NONNULL_END