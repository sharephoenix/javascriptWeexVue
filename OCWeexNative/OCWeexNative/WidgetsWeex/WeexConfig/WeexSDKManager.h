//
//  WeexSDKManager.h
//  WeexDemo
//
//  Created by yangshengtao on 16/11/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXDemoViewController.h"

@interface WeexSDKManager : NSObject

+ (void)setup;

+ (WXDemoViewController *)creatWeexController;

@end
