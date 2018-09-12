//
//  BDFSearchPublishListModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/9.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFSearchPublishListModel.h"

@implementation BDFSearchPublishListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"linksList" : NSStringFromClass([BDFHomeHotNewsModelLink class]),
             };
}

@end
