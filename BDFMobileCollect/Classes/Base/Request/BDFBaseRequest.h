//
//  BDFBaseRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/10.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BDFRequestCompleDelegate <NSObject>

/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;

@end

typedef void (^BDFRequestComple)(id response, BOOL success, NSString *message);

@interface BDFBaseRequest : NSObject

@property (nonatomic, weak) id<BDFRequestCompleDelegate> bdf_delegate;

@property (nonatomic, copy) NSString *bdf_url;

@property (nonatomic, assign) BOOL is_Post;

@property (nonatomic, strong) NSArray<UIImage *> *bdf_imageArray;


+(instancetype)bdf_request;

+(instancetype)bdf_requestWithUrl:(NSString *)url;

+(instancetype)bdf_requestWithUrl:(NSString *)url isPost:(BOOL)ispost;

+(instancetype)bdf_requestWithUrl:(NSString *)url isPost:(BOOL)ispost delegate:(id<BDFRequestCompleDelegate>)delegate;

-(void)bdf_sendRequest;

-(void)bdf_sendRequestWithComple:(BDFRequestComple)comple;

@end
