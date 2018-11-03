//
//  BDFHomeTopicListModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeTopicListModel.h"

@implementation BDFHomeTopicListModel

@end

@implementation BDFHomeTopicListRespModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"records" : NSStringFromClass([BDFHomeTopicListRespRecordsModel class])};
}

@end

@implementation BDFHomeTopicListRespRecordsModel

@end
