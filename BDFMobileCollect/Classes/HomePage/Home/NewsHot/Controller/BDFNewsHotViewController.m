//
//  BDFNewsHotViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFNewsHotViewController.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFUntil.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFHomeNewsMoreRequest.h"

@interface BDFNewsHotViewController ()

@end

@implementation BDFNewsHotViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData {

    [self.hotNewsFrameArray removeAllObjects];
    /** 请求新热榜列表数据 */
    BDFHomePageHotNewsRequest *request = [BDFHomePageHotNewsRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWS];
    request.brush = @"0";
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
