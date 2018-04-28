//
//  BDFRequestManager.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/10.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFRequestManager.h"

@interface AFHTTPSessionManager (Shared)

+(instancetype)sharedManager;

@end

@implementation AFHTTPSessionManager (Shared)

+(instancetype)sharedManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return manager;
}

@end

@implementation BDFRequestManager

+(void)GET:(NSString *)URLString parameters:(id)parameters responseSeializerType:(BDFRequestSeializerType)type success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    //设置请求头
//    [manager.requestSerializer setValue:[self cookie] forHTTPHeaderField:@"cookie"];
    
    //设置解析类型
    if (type != BDFResponseSeializerTypeDefault && type != BDFResponseSeializerTypeJSON) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    
    //HTTPS证书设置
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    policy.allowInvalidCertificates = YES;
//    manager.securityPolicy = policy;
    
    //开始请求
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)POST:(NSString *)URLString parameters:(id)parameters responseSeializerType:(BDFRequestSeializerType)type success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    // 请求头
//    [manager.requestSerializer setValue:[self cookie] forHTTPHeaderField:@"Authorization"];
    
    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != BDFResponseSeializerTypeJSON && type != BDFResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    
    //  https证书设置
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    policy.allowInvalidCertificates = YES;
//    manager.securityPolicy  = policy;
    
    //开始请求
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //        [MBProgressHUD hideAllHUDsInView:nil];
        //        [MBProgressHUD showMessage:@"网络失败~请重新再试" toView:nil];
        // 失败
        if (failure) {
            failure(error);
        }
    }];

}

+(void)POST:(NSString *)URLString parameters:(id)parameters responseSeializerType:(BDFRequestSeializerType)type constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    //初始化请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    // 请求头
    //    NSString *value = [NSString stringWithFormat:@"Bearer %@",[ CommonTool validStringWithObj:kUserInfo[@"token"]]];
    //    if (value) {
    //        [manager.requestSerializer setValue:value forHTTPHeaderField:@"Authorization"];
    //    }
    
    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != BDFResponseSeializerTypeJSON && type != BDFResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    // https证书设置
    /*
     AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
     policy.allowInvalidCertificates = YES;
     manager.securityPolicy  = policy;
     */
    
    //开始上传
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(AFHTTPResponseSerializer *)responseSearalizerWithSerilizerType:(BDFRequestSeializerType)type {
    switch (type) {
        case BDFResponseSeializerTypeDefault: // default is JSON
            return [AFJSONResponseSerializer serializer];
            break;
            
        case BDFResponseSeializerTypeJSON: // JSON
            return [AFJSONResponseSerializer serializer];
            break;
            
        case BDFResponseSeializerTypeXML: // XML
            return [AFXMLParserResponseSerializer serializer];
            break;
            
        case BDFResponseSeializerTypePlist: // Plist
            return [AFPropertyListResponseSerializer serializer];
            break;
            
        case BDFResponseSeializerTypeCompound: // Compound
            return [AFCompoundResponseSerializer serializer];
            break;
            
        case BDFResponseSeializerTypeImage: // Image
            return [AFImageResponseSerializer serializer];
            break;
            
        case BDFResponseSeializerTypeData: // Data
            return [AFHTTPResponseSerializer serializer];
            break;
            
        default:  // 默认解析器为 JSON解析
            return [AFJSONResponseSerializer serializer];
            break;
    }
}

+ (NSString *)cookie {
    
    return @"_ga=GA1.2.732729183.1467731127; install_id=5316804410; login_flag=319157cead347271ef233ba429923e3b; qh[360]=1; sessionid=b391787a2cd16be0f914259f0cf829a4; sid_guard=\"b391787a2cd16be0f914259f0cf829a4|1473218826|2591916|Fri\054 07-Oct-2016 03:25:42 GMT\"; sid_tt=b391787a2cd16be0f914259f0cf829a4; uuid=\"w:9ce15113cb34468795d7aff3edddd670";
}

+(void)cancelAllRequests {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    [manager.operationQueue cancelAllOperations];
}

@end
