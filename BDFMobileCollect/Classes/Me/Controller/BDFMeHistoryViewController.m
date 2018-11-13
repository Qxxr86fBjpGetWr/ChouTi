//
//  BDFMeHistoryViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/13.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeHistoryViewController.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFUntil.h"
#import "BDFMeHistoryRequest.h"

@interface BDFMeHistoryViewController ()

@end

@implementation BDFMeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData {
    
    //https://api.chouti.com/user/link/history/list.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.2.2
    [self.hotNewsFrameArray removeAllObjects];
    BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:BDFHOMEHISTORYLIST];
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
    BDFMeHistoryRequest *request = [BDFMeHistoryRequest bdf_requestWithUrl:BDFHOMEHISTORYLIST];
    request.after_time = frame.hotNewsModel.operateTime;
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        [self handResponseData:response];
        [BDFUntil endLoadMoreForScrollView:self.hotTableView];
        [self.hotTableView reloadData];
    }];
}

@end
