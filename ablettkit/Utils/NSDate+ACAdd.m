//
//  NSDate+ACAdd.m
//  Ablett
//
//  Created by ablett on 16/6/16.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "NSDate+ACAdd.h"

@implementation NSDate (ACAdd)

+ (NSTimeInterval)intervalWithTimeStr:(NSString *)timeStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval timeInterval = [[formatter dateFromString:timeStr] timeIntervalSince1970];
    
    return timeInterval;
}

+ (NSString *)timeStringWithInterval:(NSTimeInterval)time formate:(NSString *)formate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formate];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSString * timeStr = [formatter stringFromDate:confromTimesp];
    return timeStr;
}

+ (NSString *)stringWithTimeStr:(NSString *)timeStr formate:(NSString *)formate {
    //将 timeStr 转换成时间戳
    NSTimeInterval timeInterval = [self intervalWithTimeStr:timeStr];
    NSString *timeString = [self timeStringWithInterval:timeInterval formate:formate];
    return timeString;
}

@end
