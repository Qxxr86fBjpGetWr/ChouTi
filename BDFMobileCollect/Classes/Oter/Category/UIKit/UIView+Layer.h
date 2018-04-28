//
//  UIView+Layer.h
//  NeiHan
//
//  Created by Charles on 16/4/19.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor;


/**
 *  边角半径
 */
@property (nonatomic, assign) CGFloat layerCornerRadius;
/**
 *  边线宽度
 */
@property (nonatomic, assign) CGFloat layerBorderWidth;
/**
 *  边线颜色
 */
@property (nonatomic, strong) UIColor *layerBorderColor;
/**
 阴影颜色
 */
@property (nonatomic, strong) UIColor *shadowColor;

@end
