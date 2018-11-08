//
//  BDF42NewsViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDF42NewsViewController.h"
#import "BDFCustomCommonEmptyView.h"
#import "BDFNewsHotTableView.h"
#import "BDFUntil.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFHomeNewsMoreRequest.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFMostHotListRequest.h"
#import "BDF42NewsRequest.h"

@interface BDF42NewsViewController ()
@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) BDF42NewsMenuRespModel *model;
@end

@implementation BDF42NewsViewController

- (instancetype)initWithBaseUrl:(NSString *)baseUrl withModel:(BDF42NewsMenuRespModel *)model {
    self = [super init];
    if (self) {
        self.baseUrl = baseUrl;
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData {
    //42区：https://api.chouti.com/v2/r/news.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
    //https://api.chouti.com/api/category_news/menu.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
    
    [self.hotNewsFrameArray removeAllObjects];
    BDF42NewsRequest *request = [BDF42NewsRequest bdf_requestWithUrl:self.baseUrl];
    request.category = self.model.key;
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
