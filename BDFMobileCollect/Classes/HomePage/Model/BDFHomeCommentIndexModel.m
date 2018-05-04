//
//  BDFHomeCommentIndexModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/3.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeCommentIndexModel.h"

@implementation BDFHomeCommentIndexModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"comments" : NSStringFromClass([BDFHomeCommentIndexComment class]),
             };
}

@end

@implementation BDFHomeCommentIndexComment

@end
