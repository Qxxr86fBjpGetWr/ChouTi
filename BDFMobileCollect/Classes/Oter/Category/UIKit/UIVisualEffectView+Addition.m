//
//  UIVisualEffectView+Addition.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/7/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "UIVisualEffectView+Addition.h"

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation UIVisualEffectView (Addition)

- (instancetype)initVisualEffectView {
    
    return [self initVisualEffectWithStyle:UIBlurEffectStyleLight];
}

- (instancetype)initVisualEffectWithStyle:(UIBlurEffectStyle)style {
    self = [super init];
    if (self) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        self = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}

@end
