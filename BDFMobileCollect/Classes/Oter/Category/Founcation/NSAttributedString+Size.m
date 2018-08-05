//
//  NSAttributedString+Size.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "NSAttributedString+Size.h"
#import <CoreText/CoreText.h>
//#import "NSAttributedString+YYText.h"

@implementation NSAttributedString (Size)
 

- (CGFloat)boundingHeightForWidth:(CGFloat)inWidth {
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef) self);
//    CGSize suggestedSize= CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0),NULL, CGSizeMake(inWidth, CGFLOAT_MAX), NULL);
//    CFRelease(framesetter);
//    return suggestedSize.height;

    
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {
        return 0;
    }
    
    return [self boundingRectWithSize:CGSizeMake(inWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 3;
}


- (CGFloat)boundingWidthForHeight:(CGFloat)inHeight {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef) self);
    CGSize suggestedSize         = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0),NULL, CGSizeMake(CGFLOAT_MAX, inHeight), NULL);
    CFRelease(framesetter);
    return suggestedSize.width;
}


- (CGFloat)heightWithConstrainedWidth:(CGFloat)width {
    
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {
        return 0;
    }
    
    return [self boundingHeightForWidth:width];
}

@end
