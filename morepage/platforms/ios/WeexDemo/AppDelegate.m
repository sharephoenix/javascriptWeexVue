/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "DemoDefine.h"
#import <WeexSDK/WeexSDK.h>
#import <AVFoundation/AVFoundation.h>
#import "WeexSDKManager.h"
#import "WeexDemo-Swift.h"
#import <SSZipArchive/ZipArchive.h>

@interface AppDelegate ()
@end

@implementation AppDelegate

#pragma mark
#pragma mark application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [WeexSDKManager setup];
        [WXSDKEngine registerComponent:@"web" withClass:NSClassFromString(@"WKWebComponent")];
        [self.window makeKeyAndVisible];
        // Override point for customization after application launch.
        [self startSplashScreen];
    });

    [self unZip];
//    [self downloadCase];

    return YES;
}

// 解压文件
- (void)unZip {
    {
        NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"zip"];
        NSString *unzipPath = [[WXCacheManager instance] getAppPath:@"testid"];
        [SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath];
    }
}

// 下载文件
- (void)downloadCase {
    {
        NSString *appPath = [[WXCacheManager instance] getAppPath: @"testid"];
        NSString *fileName = @"package-lock.json";
        CacheDownLoad *downManager = [[CacheDownLoad alloc] init:appPath fileName:fileName];
        [downManager downLoadFileWithUrl:[NSURL URLWithString:@"http://192.168.0.102:8080/package-lock.json"] toPath:[[WXCacheManager instance] getRootPath]];
    }

    {
        NSString *appPath = [[WXCacheManager instance] getAppPath: @"testid"];
        NSString *fileName = @"index.html";
        CacheDownLoad *downManager = [[CacheDownLoad alloc] init:appPath fileName:fileName];
        [downManager downLoadFileWithUrl:[NSURL URLWithString:@"http://192.168.0.102:8080/index.html"] toPath:[[WXCacheManager instance] getRootPath]];
    }
}

#pragma mark 
#pragma mark animation when startup

- (void)startSplashScreen
{
    UIView* splashView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    splashView.backgroundColor = WEEX_COLOR;
    
    UIImageView *iconImageView = [UIImageView new];
    UIImage *icon = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weex-icon" ofType:@"png"]];
    if ([icon respondsToSelector:@selector(imageWithRenderingMode:)]) {
        iconImageView.image = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        iconImageView.tintColor = [UIColor whiteColor];
    } else {
        iconImageView.image = icon;
    }
    iconImageView.frame = CGRectMake(0, 0, 320, 320);
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.center = splashView.center;
    [splashView addSubview:iconImageView];
    
    [self.window addSubview:splashView];
    
    float animationDuration = 1.4;
    CGFloat shrinkDuration = animationDuration * 0.3;
    CGFloat growDuration = animationDuration * 0.7;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [UIView animateWithDuration:shrinkDuration delay:1.0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            iconImageView.transform = scaleTransform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:growDuration animations:^{
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
                iconImageView.transform = scaleTransform;
                splashView.alpha = 0;
            } completion:^(BOOL finished) {
                [splashView removeFromSuperview];
            }];
        }];
    } else {
        [UIView animateWithDuration:shrinkDuration delay:1.0 options:0 animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            iconImageView.transform = scaleTransform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:growDuration animations:^{
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
                iconImageView.transform = scaleTransform;
                splashView.alpha = 0;
            } completion:^(BOOL finished) {
                [splashView removeFromSuperview];
            }];
        }];
    }
}

@end
