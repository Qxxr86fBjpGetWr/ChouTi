//
//  BDFHomeSubjectsModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/30.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeSubjectsModel.h"

@implementation BDFHomeSubjectsModel

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"subjects" : NSStringFromClass([BDFHomeSubjectModel class]),
             };
}

@end

@implementation BDFHomeSubjectModel

@end
