//
//  BDFMessageWarnModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMessageWarnModel.h"

@implementation BDFMessageWarnModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data" : NSStringFromClass([BDFMessageWarnDataModel class])};
}

@end

@implementation BDFMessageWarnDataModel

@end

@implementation BDFMessageWarnDataLinksModel

@end

@implementation BDFMessageWarnDataFromUserModel

@end

@implementation BDFMessageWarnDataCommentsModel

@end
