//
//  WeexCustomHandler.h
//  WeexDemo
//
//  Created by phoenix on 2019/2/11.
//  Copyright © 2019 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@protocol HandleCustomProtocol <NSObject, WXModuleProtocol>

- (void)handlerTest;

@end

@interface WeexCustomHandler : NSObject<HandleCustomProtocol>

@end
