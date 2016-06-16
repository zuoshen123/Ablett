//
//  NSDate+ACAdd.h
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ACAdd)
/**
 *  时间转时间戳
 *
 *  @param timeStr 时间string
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)intervalWithTimeStr:(NSString *)timeStr;

/**
 *  时间戳转时间
 *
 *  @param time    时间戳
 *  @param formate 时间格式
 *
 *  @return 时间string
 */
+ (NSString *)timeStringWithInterval:(NSTimeInterval)time formate:(NSString *)formate;

/**
 *  时间string 转指定格式的时间string
 *
 *  @param timeStr 时间string
 *  @param formate 时间格式
 *
 *  @return 时间string
 */
+ (NSString *)stringWithTimeStr:(NSString *)timeStr formate:(NSString *)formate;

@end
