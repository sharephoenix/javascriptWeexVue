//
//  CustomWXComponent.m
//  WeexDemo
//
//  Created by phoenix on 2019/2/11.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "CustomWXComponent.h"

@implementation CustomWXComponent

- (UIView *)loadView {
    return [CustomView new];
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
}
@end
