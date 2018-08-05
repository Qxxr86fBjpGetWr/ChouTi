//
//  BDFSearchSuggestModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFSearchSuggestModel.h"

@implementation BDFSearchSuggestModel

@end

@implementation BDFSearchSuggestModelObject

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"resultList" : NSStringFromClass([BDFSearchSuggestModelObjectResult class]),
             };
}

@end

@implementation BDFSearchSuggestModelObjectResult

@end
