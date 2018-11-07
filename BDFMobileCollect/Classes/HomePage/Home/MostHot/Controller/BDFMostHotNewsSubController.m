//
//  BDFMostHotNewsSubController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMostHotNewsSubController.h"
#import "BDFCustomCommonEmptyView.h"
#import "BDFNewsHotTableView.h"
#import "BDFUntil.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFHomeNewsMoreRequest.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFMostHotListRequest.h"

@interface BDFMostHotNewsSubController ()
@property (nonatomic, strong) NSString *limit;
@end

@implementation BDFMostHotNewsSubController

- (instancetype)initWithLimit:(NSString *)limit {
    self = [super init];
    if (self) {
        self.limit = limit;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData {
//    最热：URL    https://api.chouti.com/r/top.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&limit=72hr&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
//    24hr 72hr 168hr
    [self.hotNewsFrameArray removeAllObjects];
    
    BDFMostHotListRequest *request = [BDFMostHotListRequest bdf_requestWithUrl:BDFHOMEMOSTHOTLIST];
    request.limit = self.limit;
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
    BDFHomeNewsMoreRequest *request = [BDFHomeNewsMoreRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWS];
    request.after_time = frame.hotNewsModel.operateTime;
    request.brush = @"0";
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        [self handResponseData:response];
        [BDFUntil endLoadMoreForScrollView:self.hotTableView];
        [self.hotTableView reloadData];
    }];
}

@end
