//
//  ViewController.m
//  OCWeexNative
//
//  Created by phoenix on 2019/2/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "WXDemoViewController.h"
#import "WeexSDKManager.h"

@interface ViewController ()

@end

@implementation ViewController
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 3; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WXDemoViewController * _wxdemo = [WeexSDKManager creatWeexController];
            [self.navigationController pushViewController:_wxdemo animated:YES];
        });
    }

    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 300, 200)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:label];
    label.text = @"this is my test label";
    label.textColor = [UIColor redColor];
//    [_wxdemo.view addSubview:label];
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotific" object:self userInfo:@{@"alex": @"name"}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TestNotific:) name:@"TestNotific" object:self];
}

- (void)TestNotific:(NSNotification *)notic {
    NSLog(@"%@", notic.userInfo);
}
@end
