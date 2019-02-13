//
//  CustomWXComponent.h
//  WeexDemo
//
//  Created by phoenix on 2019/2/11.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "WXComponent.h"

@interface CustomWXComponent : WXComponent

@end

@protocol CustomViewDelegate <NSObject>

- (void)delegateAction;

@end

@interface CustomView : UIView

@property(weak, nonatomic) id<CustomViewDelegate> delegate;

@end
