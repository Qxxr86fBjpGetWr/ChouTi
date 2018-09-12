//
//  BDFSearchPublishMenuView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/15.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFSearchPublishMenuView.h"
#import "UIView+Tap.h"

@interface BDFSearchPublishMenuView ()

@property (nonatomic, weak) UIView *coverView;

@property (nonatomic, weak) UIView *menuView;

@end

@implementation BDFSearchPublishMenuView

- (instancetype)initWithFrame:(CGRect)frame source:(NSArray *)source
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)show {
    [self addSubview:self.coverView];
}

- (UIView *)coverView {
    if (!_coverView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_StatusBarAndNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_StatusBarAndNavBarHeight)];
        view.backgroundColor = kLightGrayColor;
        view.alpha = 0.5;
        [view setTapActionWithBlock:^{
            
            [UIView animateWithDuration:0.2 animations:^{
                self.coverView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
        [self addSubview:view];
        _coverView = view;
    }
    return _coverView;
}

- (UIView *)menuView {
    if (!_menuView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        _menuView = view;
    }
    return _menuView;
}

@end
