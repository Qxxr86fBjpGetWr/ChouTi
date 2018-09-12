//
//  NSString+Html.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/9.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Html)

/** 超文本HTML格式转换为富文本AtrributeString格式*/
+ (NSAttributedString *)attributeStringByHtmlString:(NSString *)htmlString;

/** 富文本NSAtrributeString格式转换为超文本HTML格式*/
+ (NSString *)htmlStringByAttributeString:(NSAttributedString *)htmlAttributeString;

@end
