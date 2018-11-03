//
//  BDFHomeTopicDetailController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeTopicDetailController.h"
#import "BDFHomeTopicDetailRequest.h"
#import "BDFUntil.h"
#import "BDFHomeTopicListDetailModel.h"
#import "BDFHomeHotNewsFrame.h"

@interface BDFHomeTopicDetailController ()
@property (nonatomic, strong) NSString *topicId;
@end

@implementation BDFHomeTopicDetailController

-(instancetype)initWithTopicId:(NSString *)topicId {
    self = [super init];
    if (self) {
        self.topicId = topicId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData {
    
    [self.hotNewsFrameArray removeAllObjects];
    BDFHomeTopicDetailRequest *request = [BDFHomeTopicDetailRequest bdf_requestWithUrl:BDFHOMECATEGORYTOPICLISTDETAIL];
    request.pageNumber = @"1";
    request.topicId = self.topicId;
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        self.emptyView.hidden = !NULLDic(response);
        [self handResponseData:response];
        [BDFUntil endRefreshForScrollView:self.hotTableView];
        self.hotTableView.hotNewsFrameArray = self.hotNewsFrameArray;
    }];
}

- (void)handResponseData:(id)response {
    BDFHomeTopicListDetailModel *hotNewsModel = [BDFHomeTopicListDetailModel modelWithDictionary:response];
    for (BDFHomeHotNewsModelLink *obj in hotNewsModel.records) {
        BDFHomeHotNewsFrame *newsFrame = [[BDFHomeHotNewsFrame alloc] init];
        newsFrame.hotNewsModel = obj;
        [self.hotNewsFrameArray addObject:newsFrame];
    }
}

- (void)bdf_refresh {
    [self loadData];
}

- (void)bdf_loadMore {
}

@end
