//
//  ACShareManager.m
//  YiRong
//
//  Created by ablett on 16/5/13.
//  Copyright © 2016年 ablett. All rights reserved.
//

#import "ACShareManager.h"
#import "ACShareView.h"
#import "ACShareItem.h"
//#import <UMSocial.h>
//#import <UMSocialWechatHandler.h>
//#import <UMSocialSinaSSOHandler.h>
//#import <UMSocialQQHandler.h>

#pragma mark - UM Social share and an analyze
//appID、appStoreUrl、inHouseUrl
#define kAppId_XirangLife        @"1107531138"
#define kUrlAppStore            @"https://itunes.apple.com/us/app/xi-rang-sheng-huo/id1107531138?l=zh&ls=1&mt=8"
#define kUrlInHouse             @"https://www.pgyer.com/dOGj"
#define kUrlOfficialWeb         @"http://xiranglife.com"
//友盟
#define kAppKey_UM              @"55ada72be0f55a5f82003d53"
//微博
#define kAppKey_SinaWeibo       @"2873056512"
#define kAppSecret_SinaWeibo    @"ea92bc24622feadaadfc6ddf4728ae69"
#define kRedirectUrl_SinaWeibo  @"http://sns.whalecloud.com/sina2/callback"
//QQ
#define kAppId_QQ               @"1105393040"
#define kAppKey_QQ              @"FdpWESFcqbmTjSde"
#define kUrlSchema_QQ           @"xiranglife"
//微信
#define kAppId_WeChat           @"wxf9314485f4cef64c"
#define kAppSecret_WeChat       @"b51e0eb3b64d465b1118f299a5017af3"


static const NSString *kTitle = @"title";
static const NSString *kIcon = @"icon";

const static CGFloat shareH = 235;

@interface ACShareManager ()
{
    NSArray *_shareItems;
}
@property (strong, nonatomic) UILabel          *maskView;
@property (strong, nonatomic) ACShareView      *shareView;
@property (strong, nonatomic) UIViewController *viewController;
@property (copy, nonatomic  ) NSString         *content;
@property (strong, nonatomic) UIImage          *image;
@property (copy, nonatomic  ) NSString         *url;
@end

@implementation ACShareManager


- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(&*self)weakSelf = self;
        _shareItems = @[@{kTitle:@"新浪微博", kIcon:@"share_wb"},
                        @{kTitle:@"微信", kIcon:@"share_wx"},
                        @{kTitle:@"微信朋友圈", kIcon:@"share_friend"},
                        @{kTitle:@"QQ好友", kIcon:@"share_qq"},
                        @{kTitle:@"QQ空间", kIcon:@"share_qzone"},
                        @{kTitle:@"短信", kIcon:@"share_msg"},
                        @{kTitle:@"复制链接", kIcon:@"share_copyLink"}];
  
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:_shareItems.count];
        for (NSDictionary *itemDic in _shareItems) {
            ACShareItem *si = [[ACShareItem alloc] init];
            si.title = itemDic[kTitle];
            si.icon = itemDic[kIcon];
            [items addObject:si];
        }
        self.shareView.items = items;
        self.shareView.action = ^(NSInteger index) {
            NSLog(@"%lu", (long)index);
            
//            NSArray *shareType;
            switch (index) {
                case 0:{
                    // 新浪
                    kTitle = [NSString stringWithFormat:@"%@%@",weakSelf.content, weakSelf.url];
//                    shareType = @[UMShareToSina];
                    break;
                }
                case 1:{
                    // 微信
//                    shareType = @[UMShareToWechatSession];
//                    [UMSocialData defaultData].extConfig.wechatSessionData.url = weakSelf.url;
//                    [UMSocialData defaultData].extConfig.wechatSessionData.title = weakSelf.content;
                    break;
                }
                case 2:{
                    // 朋友圈
//                    shareType = @[UMShareToWechatTimeline];
//                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = weakSelf.url;
//                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = weakSelf.content;
                    break;
                }
                case 3:{
//                    if ([TencentOAuth iphoneQQInstalled]) {
//                        // QQ
//                        shareType = @[UMShareToQQ];
//                        [UMSocialData defaultData].extConfig.qqData.url = weakSelf.url;
//                        [UMSocialData defaultData].extConfig.qqData.title = weakSelf.content;
//                    } else {
//                        DDLogError(@"QQ未安装");
//                        return;
//                    }
                    break;
                }
                case 4:{
//                    if ([TencentOAuth iphoneQQInstalled]) {
//                        // QQ空间
//                        shareType = @[UMShareToQzone];
//                        [UMSocialData defaultData].extConfig.qzoneData.url = weakSelf.url;
//                        [UMSocialData defaultData].extConfig.qzoneData.title = weakSelf.content;
//                    } else {
//                        NSLog(@"QQ未安装");
//                        return;
//                    }
                    break;
                }
                case 5:{
                    
                    break;
                }
                case 6:{
                    
                    break;
                }
                default:
                    break;
            }
            
//            [[UMSocialDataService defaultDataService] postSNSWithTypes:shareType
//                                                               content:weakSelf.content
//                                                                 image:weakSelf.image
//                                                              location:nil
//                                                           urlResource:nil
//                                                   presentedController:weakSelf.viewController
//                                                            completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }else if (response.responseCode == UMSResponseCodeCancel) {
//                    NSLog(@"取消");
//                }else {
//                    NSLog(@"失败");
//                }
//            }];

            [weakSelf dismiss:YES];
        };
    }
    return self;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        _maskView.alpha = 0.f;
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGrAction:)];
        _maskView.userInteractionEnabled = YES;
        [_maskView addGestureRecognizer:tapGr];
    }

    return _maskView;
}

- (ACShareView *)shareView {
    if (!_shareView) {
        _shareView = [[ACShareView alloc] init];
        _shareView.frame = CGRectMake(0, kScreenH, kScreenW, shareH);
        _shareView.column = 4;
        __weak typeof(&*self)weakSelf = self;
        _shareView.cancelAction = ^(){
            [weakSelf dismiss:YES];
        };
    }
    return _shareView;
}

- (void)tapGrAction:(id)sender {
    [self dismiss:YES];
}

+ (void)registerShareInfo {
//    [UMSocialData setAppKey:kAppKey_UM];
//    [UMSocialWechatHandler setWXAppId:kAppId_WeChat
//                            appSecret:kAppSecret_WeChat
//                                  url:kUrlOfficialWeb];
//    
//    [UMSocialWechatHandler setWXAppId:kAppId_WeChat
//                            appSecret:kAppSecret_WeChat
//                                  url:kUrlOfficialWeb];
//    
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kAppKey_SinaWeibo
//                                              secret:kAppSecret_SinaWeibo
//                                         RedirectURL:kRedirectUrl_SinaWeibo];
//    
//    [UMSocialQQHandler setQQWithAppId:kAppId_QQ
//                               appKey:kAppKey_QQ
//                                  url:kUrlOfficialWeb];
//    [UMSocialQQHandler setQQWithAppId:kAppId_QQ
//                               appKey:kAppKey_QQ
//                                  url:kUrlOfficialWeb];
}

- (void)showInView:(UIViewController *)viewController
           content:(NSString *)content
             image:(UIImage *)image
               url:(NSString *)url {
    self.viewController = viewController;
    self.content = content;
    self.image = image;
    self.url = url;
    
    [self showInView:self.viewController.view];
}

- (void)showInView:(UIView *)inView {
    [inView addSubview:self.maskView];
    [inView addSubview:self.shareView];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.maskView.alpha = 1.f;
        self.shareView.frame = CGRectMake(0, kScreenH-shareH, kScreenW, shareH);
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.25f animations:^{
            self.maskView.alpha = 0.f;
            self.shareView.frame = CGRectMake(0, kScreenH, kScreenW, shareH);
        } completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
            [self.shareView removeFromSuperview];
        }];
    }else {
        [self.maskView removeFromSuperview];
        [self.shareView removeFromSuperview];
    }
}

@end
