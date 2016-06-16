//
//  ACShareModule.h
//  YiRong
//
//  Created by ablett on 16/5/12.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(void);

@interface ACShareModule : UIView

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) ActionBlock action;

@end
