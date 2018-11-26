//
//  BDFSystemMessageModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFSystemMessageModel.h"

@implementation BDFSystemMessageModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"notice" : NSClassFromString([BDFSystemMessageNoticeModel description])};
}

@end

@implementation BDFSystemMessageNoticeModel

@end

@implementation BDFSystemMessageNoticeUserModel

@end
