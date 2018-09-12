//
//  NSString+Html.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/9.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "NSString+Html.h"

@implementation NSString (Html)

/** 超文本HTML格式转换为富文本AtrributeString格式*/
+ (NSAttributedString *)attributeStringByHtmlString:(NSString *)htmlString {
    NSAttributedString *attributeString;
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *importParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
                                   };
    NSError *error = nil;
    attributeString = [[NSAttributedString alloc] initWithData:htmlData options:importParams documentAttributes:NULL error:&error];
    return attributeString;
}

/** 富文本NSAtrributeString格式转换为超文本HTML格式*/
+ (NSString *)htmlStringByAttributeString:(NSAttributedString *)htmlAttributeString {
    NSString *htmlString;
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
                                   };
    NSData *htmlData = [htmlAttributeString dataFromRange:NSMakeRange(0, htmlAttributeString.length) documentAttributes:exportParams error:nil];
    htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    return htmlString;
}

@end
