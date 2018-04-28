//
//  UIView+Layer.m
//  NeiHan
//
//  Created by Charles on 16/4/19.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor { 
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (void)setLayerBorderColor:(UIColor *)layerBorderColor {
    self.layer.borderColor = layerBorderColor.CGColor;
    [self _config];
}

- (UIColor *)layerBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setLayerBorderWidth:(CGFloat)layerBorderWidth {
    self.layer.borderWidth = layerBorderWidth;
    [self _config];
}

- (CGFloat)layerBorderWidth {
    return self.layer.borderWidth;
}

- (void)setLayerCornerRadius:(CGFloat)layerCornerRadius {
    self.layer.cornerRadius = layerCornerRadius;
    [self _config];
}

- (CGFloat)layerCornerRadius {
    return self.layer.cornerRadius;
}

- (void)_config {
    
    self.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

-(void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.layer.shadowRadius = 5;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}

@end
