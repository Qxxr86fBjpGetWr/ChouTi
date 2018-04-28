//
//  BDFCommonConstant.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BDFCommonConstant : NSObject

/** 首页正文字体大小*/
UIKIT_EXTERN int const BDFHomeNewsTextFont;
/** 首页用户名称字体大小*/
UIKIT_EXTERN int const BDFHomeNewsUserNameFont;
/** 首页时间字体大小*/
UIKIT_EXTERN int const BDFHomeNewsTimeFont;

/** 当前纬度*/
UIKIT_EXTERN NSString *const BDFUserCurrentLatitude;
/** 当前经度*/
UIKIT_EXTERN NSString *const BDFUserCurrentLongitude;
/** 是否登陆*/
UIKIT_EXTERN NSString *const BDFHasLoginFlag;
/** 网络请求成功*/
UIKIT_EXTERN NSString *const BDFRequestSuccessNotification;

@end
