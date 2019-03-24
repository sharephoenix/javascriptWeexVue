//
//  WebLocalModule.m
//  WeexDemo
//
//  Created by phoenix on 2019/3/14.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "WebLocalModule.h"
#import "WeexDemo-Swift.h"

@implementation WebLocalModule
@synthesize weexInstance;
WX_EXPORT_METHOD_SYNC(@selector(getLocalUrl:))
WX_EXPORT_METHOD_SYNC(@selector(testArray:))

- (NSString *)getLocalUrl:(NSDictionary *)params {
    NSString *appPath = [[WXCacheManager instance] getAppPath: @"testid"];
    appPath = [appPath stringByAppendingString:[NSString stringWithFormat:@"/%@",@"index.html"]];
    NSURL *fileUrl = [NSURL fileURLWithPath:appPath];
    NSURLComponents *urlComponent = [[NSURLComponents alloc] initWithURL:fileUrl resolvingAgainstBaseURL:YES];

    NSMutableArray<NSURLQueryItem *> *querItems = [NSMutableArray new];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL * _Nonnull stop) {
        [querItems addObject:[[NSURLQueryItem alloc] initWithName:key value:obj]];
    }];
    urlComponent.queryItems = querItems;
    NSString *fileUrlString = urlComponent.URL.absoluteString;
    return fileUrlString;
}

- (void)testArray:(NSArray *)array {
    NSLog(@"%@", array);
}

@end
