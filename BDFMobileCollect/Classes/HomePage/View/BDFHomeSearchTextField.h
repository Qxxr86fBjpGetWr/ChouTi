//
//  BDFHomeSearchTextField.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDFHomeSearchTextField : UITextField

/**
 *  传入自定义搜索框图片的搜索框
 *
 *  @param frame          frame
 *  @param leftViewMargin 左边视图间距
 *  @param textColor      文字颜色
 *  @param bgColor        背景颜色
 *  @param holdertext     占位文字颜色
 *  @param imagename      左边图片名字
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
               leftViewMargin:(CGFloat)leftViewMargin
                    textColor:(UIColor *)textColor
                      bgColor:(UIColor *)bgColor
                   holdertext:(NSString *)holdertext
                leftViewimage:(NSString *)imagename
               rightViewimage:(NSString *)imagename;

@property (nonatomic, assign) UIColor *placeHolderColor;

@end
