//
//  BDFRequestManager.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/10.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^BDFRequestCompleHandle)(id response, BOOL success, NSString *message);

typedef NS_ENUM(NSInteger, BDFRequestSeializerType) {
    /**
     *  默认类型 JSON  如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    BDFResponseSeializerTypeDefault,
    /**
     *  JSON类型 如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    BDFResponseSeializerTypeJSON,
    /*
     *  XML类型 如果使用这个响应解析器类型,那么请求返回的数据将会是XML格式
     */
    BDFResponseSeializerTypeXML,
    /**
     *  Plist类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Plist格式
     */
    BDFResponseSeializerTypePlist,
    /*
     *  Compound类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Compound格式
     */
    BDFResponseSeializerTypeCompound,
    /**
     *  Image类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Image格式
     */
    BDFResponseSeializerTypeImage,
    /**
     *  Data类型 如果使用这个响应解析器类型,那么请求返回的数据将会是二进制格式
     */
    BDFResponseSeializerTypeData
};

@interface BDFRequestManager : NSObject

/**
 *  GET请求 By NSURLSession
 *
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters responseSeializerType:(BDFRequestSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  POST请求 By NSURLSession
 *
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters responseSeializerType:(BDFRequestSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  POST请求 上传数据 By NSURLSession
 *
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
responseSeializerType:(BDFRequestSeializerType)type
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

+ (void)cancelAllRequests;


@end
