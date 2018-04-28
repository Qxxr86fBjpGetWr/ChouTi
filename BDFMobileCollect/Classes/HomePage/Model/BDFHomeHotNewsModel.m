//
//  BDFHomeHotNewsModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeHotNewsModel.h"
#import <MJExtension.h>

@implementation BDFHomeHotNewsModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
      @"links" : NSStringFromClass([BDFHomeHotNewsModelLink class]),
      };
}

@end

@implementation BDFHomeHotNewsModelLink

@end

@implementation BDFHomeHotNewsModelLinkUser

@end

