//
//  BDFFocusOnPeopleController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/8.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFFocusOnPeopleController.h"
#import "BDFFocusOnPeopleRequest.h"
#import "BDFUntil.h"
#import "BDFHomeHotNewsFrame.h"

@interface BDFFocusOnPeopleController ()

@end

@implementation BDFFocusOnPeopleController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     关注人动态
     https://api.chouti.com/attente/flow.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&count=25&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     加载更多
     https://api.chouti.com/attente/flow.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&after_time=1540968244364000&count=25&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
}

- (void)loadData {
    
    [self.hotNewsFrameArray removeAllObjects];
    BDFFocusOnPeopleRequest *request = [BDFFocusOnPeopleRequest bdf_requestWithUrl:BDFHOMECATEGORYFLOWLIST];
    request.count = @"25";
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        self.emptyView.hidden = !NULLDic(response);
        [self handResponseData:response];
        [BDFUntil endRefreshForScrollView:self.hotTableView];
        self.hotTableView.hotNewsFrameArray = self.hotNewsFrameArray;
    }];
}

- (void)bdf_refresh {
    [self loadData];
}

- (void)bdf_loadMore {
    
    BDFHomeHotNewsFrame *frame = self.hotNewsFrameArray.lastObject;
    BDFFocusOnPeopleRequest *request = [BDFFocusOnPeopleRequest bdf_requestWithUrl:BDFHOMECATEGORYFLOWLIST];
    request.count = @"25";
    request.after_time = frame.hotNewsModel.operateTime;
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        [self handResponseData:response];
        [BDFUntil endLoadMoreForScrollView:self.hotTableView];
        [self.hotTableView reloadData];
    }];
}

@end
