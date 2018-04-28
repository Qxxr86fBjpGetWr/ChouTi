//
//  BDFMessageRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

//@"https://bing.ioliu.cn/v1?p=1&size=10";

@interface BDFMessageRequest : BDFBaseRequest
/**
 页码数
 */
@property (nonatomic, assign)int p;

/**
 每页请求数量
 */
@property (nonatomic, assign)int size;

@end
