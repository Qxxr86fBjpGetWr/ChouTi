//
//  NSAttributedString+Size.h
//  
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Size)

/**
 *  根据约束的宽度来求NSAttributedString的高度 
 */
- (CGFloat)heightWithConstrainedWidth:(CGFloat)width ; 

@end
