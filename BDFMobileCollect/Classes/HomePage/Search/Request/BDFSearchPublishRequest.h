//
//  BDFSearchPublishRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/7.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

@interface BDFSearchPublishRequest : BDFBaseRequest

/**
 https://api.chouti.com/search/show.json
 access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&searchType=2&source=c40fe2f61bcfd611177be71ec305196b&version=3.1.6.1&words=%E5%85%B6%E5%AE%9E%E4%BD%A0%E7%9A%84%E4%BA%BA%E7%94%9F
 */

@property (nonatomic, copy) NSString *words;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger searchType;

@end
