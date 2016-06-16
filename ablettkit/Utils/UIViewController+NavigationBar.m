//
//  UIViewController+NavigationBar.m
//  Ablett
//
//  Created by ablett on 16/6/7.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "UIViewController+NavigationBar.h"
#import <objc/runtime.h>

static const void *leftBlockKey  = &leftBlockKey;
static const void *rightBlockKey = &rightBlockKey;

#define LeftItemImageOrTitle [UIImage imageNamed:@"icon_back_navigation"]?[UIImage imageNamed:@"icon_back_navigation"]:@""

@implementation UIViewController (NavigationBar)

#pragma mark
#pragma mark - Setter/Getter

- (void)setAc_navigationBar:(UINavigationBar *)ac_navigationBar {
    objc_setAssociatedObject(self, @selector(ac_navigationBar), ac_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAc_navigationItem:(UINavigationItem *)ac_navigationItem {
    objc_setAssociatedObject(self, @selector(ac_navigationItem), ac_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationBar *)ac_navigationBar {
    return objc_getAssociatedObject(self, _cmd);
}

- (UINavigationItem *)ac_navigationItem {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark
#pragma mark - Public

- (void)configNavigationLeftItemWithAction:(NavigationItemBlock)action {
    [self configNavigationLeftItemWithObject:LeftItemImageOrTitle action:action];
}

- (void)configNavigationLeftItemWithObject:(id)object action:(NavigationItemBlock)action {
    [self configNavigationItemWithObject:object isLeft:YES action:action];
}

- (void)configNavigationRightItemWithObject:(id)object action:(NavigationItemBlock)action {
    [self configNavigationItemWithObject:object isLeft:NO action:action];
}

#pragma mark
#pragma mark - Privite

- (void)configNavigationItemWithObject:(id)object isLeft:(BOOL)left action:(NavigationItemBlock)action{
    
    NSCAssert([object isKindOfClass:[NSString class]] || [object isKindOfClass:[UIImage class]], @"the object must be class of NSString or UIImage");
    
    if ([object isKindOfClass:[UIImage class]]) {
        if (action) {
            objc_setAssociatedObject(self, left ? &leftBlockKey : &rightBlockKey,action,OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[object imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:left ? @selector(leftAction:) : @selector(rightAction:)];
        if (left) {
            self.ac_navigationItem.leftBarButtonItem = barButtonItem;
        } else {
            self.ac_navigationItem.rightBarButtonItem = barButtonItem;
        }
    } else {
        if (action) {
            objc_setAssociatedObject(self, left ? &leftBlockKey : &rightBlockKey,action,OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:(NSString *)object style:UIBarButtonItemStylePlain target:self action:left? @selector(leftAction:):@selector(rightAction:)];
        if (left) {
            self.ac_navigationItem.leftBarButtonItem = barButtonItem;
        } else {
            self.ac_navigationItem.rightBarButtonItem = barButtonItem;
        }
    }
}

#pragma mark
#pragma mark - Action

- (void)leftAction:(id)sender {
    NavigationItemBlock action = objc_getAssociatedObject(self, leftBlockKey);
    if (action) {
        action();
    }
}

- (void)rightAction:(id)sender {
    NavigationItemBlock action = objc_getAssociatedObject(self, rightBlockKey);
    if (action) {
        action();
    }
}

@end
