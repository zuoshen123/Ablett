//
//  ACShareManager.h
//  YiRong
//
//  Created by ablett on 16/5/13.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACShareManager : NSObject

/**
 *  注册 share appkey
 */
+ (void)registerShareInfo;

/**
 *  分享
 *
 *  @param view    super view
 *  @param content share content
 *  @param image   share image
 *  @param url     share url
 */
- (void)showInView:(UIViewController *)viewController
           content:(NSString *)content
             image:(UIImage *)image
               url:(NSString *)url;

@end
