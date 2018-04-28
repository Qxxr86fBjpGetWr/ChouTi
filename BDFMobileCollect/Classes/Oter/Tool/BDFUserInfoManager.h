//
//  BDFUserInfoManager.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/6.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDFLoginSucModel.h"

@interface BDFUserInfoManager : NSObject

+(instancetype)sharedManager;

/**
 *  登录成功
 */
- (void)didLoginInWithUserInfo:(id)userInfo;

/**
 *  退出
 */
- (void)didLoginOut;

/**
 *  获取用户信息
 */
- (BDFLoginSucModel *)currentUserInfo;

/**
 *  更新缓存中的用户信息
 */
- (void)resetUserInfoWithUserInfo:(BDFLoginSucModel *)userInfo;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;

@end
