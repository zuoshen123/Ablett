//
//  UIViewController+NavigationBarAlpha.m
//  Ablett
//
//  Created by ablett on 16/6/13.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "UIViewController+NavigationBarAlpha.h"
#import "UIViewController+NavigationBar.h"
#import <objc/runtime.h>
#import "sys/sysctl.h"


static const CGFloat DEFAULT_offsetY = 200.f;


@interface UIViewController ()
@property (nonatomic,weak  ) UIScrollView          *scrollView;
@property (nonatomic,strong) UIImage               *navigationBarImage;
@property (nonatomic,assign) ACAlphaControlOptions options;
@property (nonatomic,assign) CGFloat               scrollOffsetY;
@end
@implementation UIViewController (NavigationBarAlpha)

static const void *scrollViewKey         = &scrollViewKey;
static const void *navigationBarImageKey = &navigationBarImageKey;
static const void *opitonsKey            = &opitonsKey;
static const void *scrolOffsetYKey       = &scrolOffsetYKey;

#pragma mark - Setter/Getter

- (UIScrollView *)scrollView {
    return objc_getAssociatedObject(self, scrollViewKey);
}

- (void)setScrollView:(UIScrollView *)scrollView {
    objc_setAssociatedObject(self, scrollViewKey, scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)navigationBarImage {
    return objc_getAssociatedObject(self, navigationBarImageKey);
}

- (void)setNavigationBarImage:(UIImage *)navigationBarImage {
    objc_setAssociatedObject(self, navigationBarImageKey, navigationBarImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ACAlphaControlOptions)options {
    return [objc_getAssociatedObject(self, opitonsKey) integerValue];
}

- (void)setOptions:(ACAlphaControlOptions)options {
    objc_setAssociatedObject(self, opitonsKey, @(options), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)scrollOffsetY {
    return [objc_getAssociatedObject(self, scrolOffsetYKey) floatValue];
}

- (void)setScrollOffsetY:(CGFloat)scrollOffsetY {
    objc_setAssociatedObject(self, scrolOffsetYKey, @(scrollOffsetY), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Public

static CGFloat alpha = 0;

- (void)configureKeyScrollView:(UIScrollView *)scrollView scrollOffsetY:(CGFloat)scrollOffsetY opitons:(ACAlphaControlOptions)options {
    
    CGFloat offsetY = ([self deviceVersion] <= 5) ? DEFAULT_offsetY:self.scrollOffsetY;
    CGPoint point = self.scrollView.contentOffset;
    alpha =  point.y/offsetY;
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    
    self.ac_navigationItem.leftBarButtonItem.customView.alpha = self.options & 1?alpha:1;
    self.ac_navigationItem.titleView.alpha = self.options >> 1 & 1 ?alpha:1;
    self.ac_navigationItem.rightBarButtonItem.customView.alpha = self.options >> 2 & 1?alpha:1;
    
    [[[self.ac_navigationBar subviews]objectAtIndex:0] setAlpha:alpha];
}

- (void)configureNavigationBarAlphaWhenViewWillAppear {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.navigationBarImage = [self.ac_navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    });

    [self.ac_navigationBar setBackgroundImage:self.navigationBarImage forBarMetrics:UIBarMetricsDefault];
    [self.ac_navigationBar setShadowImage:[[UIImage alloc]init]];
    
    self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y - 1);
    self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y + 1);
}

- (void)configureNavigationBarAlphaWhenViewWillDisappear {
    [[[self.ac_navigationBar subviews]objectAtIndex:0] setAlpha:1];
    [self.ac_navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.ac_navigationBar setShadowImage:nil];
}

#pragma mark - Utils

- (NSString *)devicePlatform {
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return 	platform;
}

- (NSInteger)deviceVersion {
    NSArray *array = [[self devicePlatform] componentsSeparatedByString:@","];
    NSInteger deviceVersion = 0;
    if ([array.firstObject containsString:@"iPhone"]) {
        deviceVersion  = [[array.firstObject substringWithRange:(NSRange){6,1}] integerValue];
    }
    return deviceVersion;
}

@end
