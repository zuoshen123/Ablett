//
//  UIViewController+NavigationBarAlpha.h
//  Ablett
//
//  Created by ablett on 16/6/13.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, ACAlphaControlOptions) {
    kACAlphaControlOptionLeft = 0x01,
    kACAlphaControlOptionsTitle = 0x01 << 1,
    kACAlphaControlOptionsRight = 0x01 << 2,
};

@interface UIViewController (NavigationBarAlpha)

- (void)configureKeyScrollView:(UIScrollView *)scrollView
                 scrollOffsetY:(CGFloat)scrollOffsetY
                       opitons:(ACAlphaControlOptions)options;

- (void)configureNavigationBarAlphaWhenViewWillAppear;
- (void)configureNavigationBarAlphaWhenViewWillDisappear;

@end
