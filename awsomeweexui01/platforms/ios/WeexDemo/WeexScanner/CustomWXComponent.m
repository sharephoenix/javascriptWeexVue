//
//  CustomWXComponent.m
//  WeexDemo
//
//  Created by phoenix on 2019/2/11.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "CustomWXComponent.h"

@interface CustomWXComponent()<CustomViewDelegate>

@end

@implementation CustomWXComponent

- (UIView *)loadView {
    CustomView * v = [CustomView new];
    v.delegate = self;
    return v;
}

- (void)delegateAction {
    [self fireEvent:@"customLoaded" params:@{@"customKey":@"customValue"} domChanges:nil];
}

@end


@implementation CustomView
{
    UIButton *button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        button = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 100, 100)];
        button.backgroundColor = [UIColor greenColor];
        [self addSubview:button];
        [button addTarget:self action:@selector(senderButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)senderButton:(id)sender {
    NSLog(@"fix_senderButton");
    if ([self.delegate respondsToSelector:@selector(delegateAction)]) {
        [self.delegate delegateAction];
    }
}
@end
