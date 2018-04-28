//
//  BDFMessageModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFMessageModel.h"

@implementation BDFMessageModel

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : @"BDFMessageDataModel",
             };
}

@end

@implementation BDFMessageDataModel

@end

@implementation BDFMessageStatusModel

@end
