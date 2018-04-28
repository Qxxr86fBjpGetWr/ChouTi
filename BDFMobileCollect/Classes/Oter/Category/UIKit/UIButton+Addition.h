//
//  UIButton+Addition.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/24.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

+(instancetype)buttonWithTitle:(NSString *)title normalColor:(UIColor *)norColor disableColor:(UIColor *)disColor fontSize:(CGFloat)size target:(id)target action:(SEL)action;

+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                             target:(id)target
                             action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                     touchBlock:(void(^)())block;


@end
