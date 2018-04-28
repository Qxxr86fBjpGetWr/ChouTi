//
//  BDFTestRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

@interface BDFTestRequest : BDFBaseRequest

//deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&format=json&oauth_consumer_key=c40fe2f61bcfd611177be71ec305196b&oauth_nonce=CAD3A17C-DA85-4DE2-B09E-15810636FFCB&oauth_signature=LqpSeXLWWN9SlANV3Yqp79PxBoc%3D&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1524104651&oauth_version=1.0&source=c40fe2f61bcfd611177be71ec305196b&version=3.1.1.7&x_auth_from=10&x_auth_model=client_auth&x_auth_password=cptbtbtp&x_auth_username=%2B8617610050600&x_login_type=2

@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, copy) NSString *oauth_consumer_key;
@property (nonatomic, copy) NSString *oauth_nonce;
@property (nonatomic, copy) NSString *oauth_signature;
@property (nonatomic, copy) NSString *oauth_signature_method;
@property (nonatomic, copy) NSString *oauth_timestamp;
@property (nonatomic, copy) NSString *oauth_version;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *x_auth_from;
@property (nonatomic, copy) NSString *x_auth_model;
@property (nonatomic, copy) NSString *x_auth_password;
@property (nonatomic, copy) NSString *x_auth_username;
@property (nonatomic, copy) NSString *x_login_type;

@end
