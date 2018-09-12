//
//  BDFSearchSuggestRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

@interface BDFSearchSuggestRequest : BDFBaseRequest
/**
access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&keywords=%E6%88%91&source=c40fe2f61bcfd611177be71ec305196b&version=3.1.6.1
 */

@property (nonatomic, copy) NSString *keywords;

@end
