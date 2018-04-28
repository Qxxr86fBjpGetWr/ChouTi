//
//  UIButton+Addition.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/24.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "UIButton+Addition.h"
#import <objc/runtime.h>

typedef void (^ActionBlock)();

static char buttonClickKey;

@implementation UIButton (Addition)

+(instancetype)buttonWithTitle:(NSString *)title normalColor:(UIColor *)norColor disableColor:(UIColor *)disColor fontSize:(CGFloat)size target:(id)target action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (title && norColor) {
        [button setTitleColor:norColor forState:UIControlStateNormal];
    }
    if (title && disColor) {
        [button setTitleColor:disColor forState:UIControlStateDisabled];
    }
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:size]];
    
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    
    return button;
}

+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                             target:(id)target
                             action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (imagename) {
        
        [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }
    if (hightImagename) {
        
        [button setImage:[UIImage imageNamed:hightImagename] forState:UIControlStateNormal];
    }
    
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    return button;
    
}

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor && title) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                     touchBlock:(void (^)())block {
    
    UIButton *button = [self buttonWithTitle:title
                                 normalColor:normalColor
                               selectedColor:selectedColor
                                    fontSize:fontSize
                                      target:self
                                      action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+ (void)btnTouch:(UIButton *)button {
    if (button.block) {
        button.block();
    }
}

-(void)setBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &buttonClickKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(ActionBlock)block {
    return objc_getAssociatedObject(self, &buttonClickKey);
}

@end
