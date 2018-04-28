//
//  BDFBaseRequest.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/10.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"
#import "BDFRequestManager.h"
#import <MJExtension.h>
#import "BDFUserInfoManager.h"

@implementation BDFBaseRequest

+(instancetype)bdf_request {
    return [[self alloc] init];
}

+(instancetype)bdf_requestWithUrl:(NSString *)url {
    return [self bdf_requestWithUrl:url isPost:NO];
}

+(instancetype)bdf_requestWithUrl:(NSString *)url isPost:(BOOL)ispost {
    return [self bdf_requestWithUrl:url isPost:ispost delegate:nil];
}

+(instancetype)bdf_requestWithUrl:(NSString *)url isPost:(BOOL)ispost delegate:(id<BDFRequestCompleDelegate>)delegate {
    BDFBaseRequest *request = [self bdf_request];
    request.bdf_url = url;
    request.is_Post = ispost;
    request.bdf_delegate = delegate;
    
    return request;
}

-(void)bdf_sendRequest {
    [self bdf_sendRequestWithComple:nil];
}

-(void)bdf_sendRequestWithComple:(BDFRequestComple)comple {
    NSString *url = self.bdf_url;
    if (url.length == 0) {return;}
    NSDictionary *parameDic = [self parame];
    
    if (_is_Post) {
        if (_bdf_imageArray.count == 0) {//下载
            [BDFRequestManager POST:url parameters:parameDic responseSeializerType:BDFResponseSeializerTypeJSON success:^(id responseObject) {
                
                [self handleResponse:responseObject completion:comple];
                
            } failure:^(NSError *error) {
                
            }];
        }
    }else{
        [BDFRequestManager GET:url parameters:parameDic responseSeializerType:BDFResponseSeializerTypeJSON success:^(id responseObject) {
            
            [self handleResponse:responseObject completion:comple];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    if (self.bdf_imageArray.count) {//上传图片
        [BDFRequestManager POST:url parameters:parameDic responseSeializerType:BDFResponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSInteger imageCount = 0.;
            
            for (UIImage *image in _bdf_imageArray) {
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imageCount)];
                
                [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:fileName mimeType:@"image/png"];
                imageCount ++;
                
            }
        } success:^(id responseObject) {
            //处理数据
            [self handleResponse:responseObject completion:^(id response, BOOL success, NSString *message) {
                
            }];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)handleResponse:(id)responseObject completion:(BDFRequestComple)completion {
    if (completion) {
        completion(responseObject,YES,@"");
    }else if (self.bdf_delegate) {
        if ([self.bdf_delegate respondsToSelector:@selector(requestSuccessReponse:response:message:)]) {
            [self.bdf_delegate requestSuccessReponse:YES response:responseObject message:@""];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:BDFRequestSuccessNotification object:nil];
}

-(NSDictionary *)parame {
    BDFUserInfoManager *infoManager = [BDFUserInfoManager sharedManager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"deviceId"] = @"12ec7b9b922138b8a6bc55070a164669d050bb7a";
    params[@"version"] = @"3.1.1.7";
    params[@"source"] = @"c40fe2f61bcfd611177be71ec305196b";
    
    if (infoManager.isLogin) {
        params[@"access_token"] = @"c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED";
    }
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    if ([params.allKeys containsObject:@"delegate"]) {
        [params removeObjectForKey:@"delegate"];
    }
    if ([params.allKeys containsObject:@"bdf_isPost"]) {
        [params removeObjectForKey:@"bdf_isPost"];
    }
    if ([params.allKeys containsObject:@"bdf_url"]) {
        [params removeObjectForKey:@"bdf_url"];
    }
    if (self.bdf_imageArray.count == 0) {
        if ([params.allKeys containsObject:@"bdf_imageArray"]) {
            [params removeObjectForKey:@"bdf_imageArray"];
        }
    }
    return params;
    
}

@end
