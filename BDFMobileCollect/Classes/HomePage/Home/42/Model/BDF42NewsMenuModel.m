//
//  BDF42NewsMenuModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/8.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDF42NewsMenuModel.h"

@implementation BDF42NewsMenuModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"resp" : NSStringFromClass([BDF42NewsMenuRespModel class])};
}

@end

@implementation BDF42NewsMenuRespModel

-(instancetype)initWithVale:(NSString *)value {
    self = [super init];
    if (self) {
        self.value = value;
        self.id = @"";
        self.key = @"";
    }
    return self;
}

@end
