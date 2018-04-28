//
//  BDFCommonConstant.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFCommonConstant.h"

@implementation BDFCommonConstant

/** 首页字体大小*/
int const BDFHomeNewsTextFont = 16;
/** 首页用户姓名字体大小*/
int const BDFHomeNewsUserNameFont = 13;
/** 首页时间大小*/
int const BDFHomeNewsTimeFont = 10;

/** 当前纬度*/
NSString *const BDFUserCurrentLatitude = @"BDFUserCurrentLatitude";
/** 当前经度*/
NSString *const BDFUserCurrentLongitude = @"BDFUserCurrentLongitude";
/** 是否登陆*/
NSString *const BDFHasLoginFlag = @"BDFHasLoginFlag";
/** 网络请求成功*/
NSString *const BDFRequestSuccessNotification = @"BDFRequestSuccessNotification";

@end
