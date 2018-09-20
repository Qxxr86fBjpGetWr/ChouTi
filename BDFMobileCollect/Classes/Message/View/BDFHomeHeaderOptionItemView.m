//
//  BDFHomeHeaderOptionItemView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/1.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFHomeHeaderOptionItemView.h"

@implementation BDFHomeHeaderOptionItemView

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_fillColor set];
    
    CGRect newRect = rect;
    newRect.size.width = rect.size.width * self.progress;
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}

@end
