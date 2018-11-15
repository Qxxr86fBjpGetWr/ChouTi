//
//  BDFMeCommentModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeCommentModel.h"

@implementation BDFMeCommentModel

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"comments" : NSStringFromClass([BDFMeCommentsCommentModel class]),
             };
}

@end

@implementation BDFMeCommentsCommentModel

@end

@implementation BDFMeCommentsUserModel

@end
