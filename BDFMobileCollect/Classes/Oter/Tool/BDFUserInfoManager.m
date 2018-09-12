//
//  BDFUserInfoManager.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/6.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFUserInfoManager.h"
#import "BDFFileCacheManager.h"

static BDFUserInfoManager *_userInfoManager = nil;

@implementation BDFUserInfoManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfoManager = [[BDFUserInfoManager alloc] init];
    });
    return _userInfoManager;
}

-(void)didLoginInWithUserInfo:(id)userInfo {
    BDFLoginSucModel *model = [BDFLoginSucModel modelWithDictionary:userInfo];
    [model archive];
}

// 当前用户信息
- (BDFLoginSucModel *)currentUserInfo {
    NSString *classString = NSStringFromClass([BDFLoginSucModel class]);
    id obj = [BDFFileCacheManager getObjectByFileName:classString];
    if (obj != nil) {
        return  obj;
    }
    return nil;
}

// 重置用户信息
- (void)resetUserInfoWithUserInfo:(BDFLoginSucModel *)userInfo {
    [userInfo archive];
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:BDFHasLoginFlag];
}

- (void)didLoginOut {

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:BDFHasLoginFlag];
    BDFLoginSucModel *sucModel = [BDFUserInfoManager sharedManager].currentUserInfo;
    [sucModel remove];
}

@end
