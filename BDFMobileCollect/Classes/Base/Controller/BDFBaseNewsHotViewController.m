//
//  BDFBaseNewsHotViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/7.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseNewsHotViewController.h"
#import "BDFHomeNewsMoreRequest.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFUntil.h"
#import "BDFBaseHotNewsRequest.h"
#import "BDFBaseMostNewsRequest.h"

@interface BDFBaseNewsHotViewController ()
@property (nonatomic, strong) NSString *url;
@end

@implementation BDFBaseNewsHotViewController

- (instancetype)initWithType:(SubType)type baseUrl:(nonnull NSString *)url {
    self = [super init];
    if (self) {
        self.subType = type;
        self.url = url;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotTableView.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.emptyView.hidden = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        [self loadData];
    });
}

- (void)loadData {
    
    [self.hotNewsFrameArray removeAllObjects];
    BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:self.url];
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        self.emptyView.hidden = !NULLDic(response);
        [self handResponseData:response];
        [BDFUntil endRefreshForScrollView:_hotTableView];
        self.hotTableView.hotNewsFrameArray = self.hotNewsFrameArray;
    }];
}

- (void)bdf_refresh {
    [self loadData];
}

- (void)bdf_loadMore {
    
    BDFHomeHotNewsFrame *frame = self.hotNewsFrameArray.lastObject;
    BDFBaseRequest *request = nil;
    if (self.subType == MOSTHOT) {
        BDFBaseHotNewsRequest *hotRequest = [BDFBaseHotNewsRequest bdf_requestWithUrl:self.url];
        hotRequest.after_score = frame.hotNewsModel.source;
        request = hotRequest;
    } else {
        BDFBaseMostNewsRequest *hotRequest = [BDFBaseMostNewsRequest bdf_requestWithUrl:self.url];
        hotRequest.after_time = frame.hotNewsModel.operateTime;
        request = hotRequest;
    }
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        [self handResponseData:response];
        [BDFUntil endLoadMoreForScrollView:_hotTableView];
        [self.hotTableView reloadData];
    }];
}

- (void)handResponseData:(id)response {
    BDFHomeHotNewsModel *hotNewsModel = [BDFHomeHotNewsModel modelWithDictionary:response];
    for (BDFHomeHotNewsModelLink *obj in hotNewsModel.links) {
        BDFHomeHotNewsFrame *newsFrame = [[BDFHomeHotNewsFrame alloc] init];
        newsFrame.hotNewsModel = obj;
        [self.hotNewsFrameArray addObject:newsFrame];
    }
}

- (BDFCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        BDFCustomCommonEmptyView *empty = [[BDFCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"年轻人等等就出来了" iconname:@"naodai"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

- (BDFNewsHotTableView *)hotTableView {
    if(!_hotTableView){
        _hotTableView = [[BDFNewsHotTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withDelegateVc:self];
        if (SCREEN_iPhoneX) {
            _hotTableView.height = SCREEN_HEIGHT - SCREEN_StatusBarAndNavBarHeight - SCREEN_TabbarHeight;
        }
        _hotTableView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        _hotTableView.separatorColor = [UIColor blackColor];
        [BDFUntil addLoadMoreForScrollView:_hotTableView loadMoreCallBack:^{
            [self bdf_loadMore];
        }];
        [BDFUntil addPullRefreshForScrollView:_hotTableView pullRefreshCallBack:^{
            [self bdf_refresh];
        }];
        [self.view addSubview:_hotTableView];
    }
    return _hotTableView;
}

- (NSMutableArray *)hotNewsFrameArray {
    
    if (!_hotNewsFrameArray) {
        _hotNewsFrameArray = @[].mutableCopy;
    }
    return _hotNewsFrameArray;
}

@end
