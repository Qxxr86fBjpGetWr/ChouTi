//
//  BDFHomeNewsSubjectsRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/30.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFHomeNewsSubjectsRequest : BDFBaseRequest
/**
https://api.chouti.com/subjects.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&content_version_ios=110&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
 */
@property (nonatomic, strong) NSString *content_version_ios;

@end

NS_ASSUME_NONNULL_END
