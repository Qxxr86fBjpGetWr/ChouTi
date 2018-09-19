//
//  BDFLogAndRegViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/6.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFLogAndRegViewController.h"
#import "BDFLogAndRegView.h"
#import "BDFMainTabBarController.h"
#import "BDFLoginRequest.h"
#import "BDFCommentAPIConstant.h"
#import "BDFLoginSucModel.h"
#import "BDFUserInfoManager.h"

@interface BDFLogAndRegViewController ()<BDFLogAndRegViewDelegate>

@end

@implementation BDFLogAndRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置登录view
    BDFLogAndRegView *loginView = [[BDFLogAndRegView alloc] initWithFrame:self.view.frame];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    [self login];
}

- (void)login {
    BDFLoginRequest *loginRequest = [BDFLoginRequest bdf_requestWithUrl:BDFLOGINBASEAPI];
    loginRequest.access_token = @"c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED";
    
    [loginRequest bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        [response createPropertyCode];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BDFHasLoginFlag];
        [[BDFUserInfoManager sharedManager] didLoginInWithUserInfo:response];
        
        BDFLoginSucModel *loginSucModel = [BDFLoginSucModel modelWithDictionary:response];
        BDFLog(@"%@",loginSucModel);
    }];
}

- (void)clickLoginButtonComplete {
    [self login];
    //[self presentVc:[[BDFMainTabBarController alloc] init]];
    [self dismiss];
}

- (void)clickCloseButtonComplte {
    [self dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    
}

@end
