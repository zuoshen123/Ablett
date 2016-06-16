//
//  UIViewController+NavigationBar.h
//  Ablett
//
//  Created by ablett on 16/6/7.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavigationItemBlock)();

@interface UIViewController (NavigationBar)

@property (nonatomic, strong) UINavigationBar *ac_navigationBar; //< custom navigation bar/
@property (nonatomic, strong) UINavigationItem *ac_navigationItem; //< custom navigation item/

/**
 *  left navigationItem action
 *
 *  @param action navigationItem action
 */
- (void)configNavigationLeftItemWithAction:(NavigationItemBlock)action;

/**
 *  config left navigationItem
 *
 *  @param object title or image
 *  @param action navigationItem action
 */
- (void)configNavigationLeftItemWithObject:(id)object action:(NavigationItemBlock)action;

/**
 *  config right navigationItem
 *
 *  @param object title or image
 *  @param action navigationItem action
 */
- (void)configNavigationRightItemWithObject:(id)object action:(NavigationItemBlock)action;

@end
