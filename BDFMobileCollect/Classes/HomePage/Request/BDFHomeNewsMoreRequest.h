//
//  BDFHomeNewsMoreRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/28.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

@interface BDFHomeNewsMoreRequest : BDFBaseRequest

@property (nonatomic, copy) NSString *brush;

@property (nonatomic, assign) NSInteger after_time;

@end
