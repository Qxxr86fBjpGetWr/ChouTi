//
//  BDFHomeTopicListDetailModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeTopicListDetailModel.h"

@implementation BDFHomeTopicListDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return  @{@"records" : [BDFHomeHotNewsModelLink class]};
}

@end
