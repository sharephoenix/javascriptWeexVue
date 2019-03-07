//
//  NativeView.m
//  OCWeexNative
//
//  Created by Alexluan on 2019/3/7.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "NativeView.h"

@interface NativeView()



@end

@implementation NativeView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)firstAction:(id)sender {
    self.info.text = @"111";
    if (self.callBack) {
        self.callBack(@{@"one": @{@"name": @"alex"}});
    }
}
- (IBAction)secondAction:(id)sender {
    self.info.text = @"222";
    if (self.callBack) {
        self.callBack(@{@"two": @{@"age": @"12"}});
    }
}
- (IBAction)thirdAction:(id)sender {
    self.info.text = @"333";
    if (self.callBack) {
        self.callBack(@{@"three": @{@"address": @"shangahi"}});
    }
}
- (IBAction)forthAction:(id)sender {
    self.info.text = @"444";
    if (self.callBack) {
        self.callBack(@{@"four": @{@"local": @"anhui"}});
    }
}

@end
