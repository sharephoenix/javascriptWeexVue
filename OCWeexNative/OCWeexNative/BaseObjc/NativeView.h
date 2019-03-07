//
//  NativeView.h
//  OCWeexNative
//
//  Created by Alexluan on 2019/3/7.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NativeView : UIView
@property (weak, nonatomic) IBOutlet UITextView *info;

/**
 key: event
 value: params
 */
@property(copy, nonatomic) void (^callBack)(NSDictionary *event);

@end
