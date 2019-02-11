//
//  AQXEventModule.m
//  OCWeexNative
//
//  Created by phoenix on 2019/2/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AQXEventModule.h"

@implementation AQXEventModule
@synthesize weexInstance; // 让该module 获得当前instance

WX_EXPORT_METHOD(@selector(weexSay:))
WX_EXPORT_METHOD(@selector(callbacktest:))
WX_EXPORT_METHOD(@selector(weexSay:callback:))

- (void)weexSay:(NSString *)string
{
    NSLog(@"js invoke native weexSay:%@",string);
}

- (void)weexSay:(NSString *)string callback:(WXModuleKeepAliveCallback)callback
{
    NSLog(@"js invoke native weexSay:%@",string);
    callback(string,true);// 此处设置true，该回调function 可以多次回调执行，可以写循环测试.
}
// 注：这个回调没有用，只能用 WXModuleKeepAliveCallback 或者 WXModuleCallback 进行数据回调
- (NSString*)callbacktest:(NSString *)string {
    return [NSString stringWithFormat:@"%@--%@",string,string];
}

- (void)openURL:(NSString *)url {
    NSLog(@"WeexOpenURL");
}

@end
