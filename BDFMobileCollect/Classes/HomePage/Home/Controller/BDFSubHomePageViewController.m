//
//  BDFSubHomePageViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/30.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFSubHomePageViewController.h"
#import "BDFHomeTitleView.h"
#import <DXPopover.h>
#import "BDFAllTypeNewsView.h"
#import "BDFHomeNewsSubjectsRequest.h"
#import "BDFHomeSearchController.h"
#import "BDFAllTypeCollectionCell.h"

@interface BDFSubHomePageViewController ()<BDFHomeTitleDelegate, BDFAllTypeNewsViewDidSelectDelegate>

@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) BDFAllTypeNewsView *newsView;

@end

@implementation BDFSubHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     42区：https://api.chouti.com/v2/r/news.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     话题：https://api.chouti.com/api/topic/list.jsondeviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&pageNumber=1&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     
     点击cell ：https://api.chouti.com/api/topic/linkList.jsondeviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&pageNumber=1&source=c40fe2f61bcfd611177be71ec305196b&topicId=186&version=3.2.0.6
     最热：URL    https://api.chouti.com/r/top.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&limit=72hr&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     24hr 72hr 168hr
     段子：https://api.chouti.com/v2/r/scoff.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     首页新闻分类       https://api.chouti.com/subjects.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&content_version_ios=110&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     
     //刷新消息提示
     //https://api.chouti.com/api/refreshHintsList.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
    
    [self setNav];
    [self setTitleView];
}

- (void)setTitleView {
    BDFHomeTitleView *titleView = [[BDFHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
}

- (void)loadData {
    [super loadData];
    /** 请求首页顶部分类数据 */
    BDFHomeNewsSubjectsRequest *jectsRequest = [BDFHomeNewsSubjectsRequest bdf_requestWithUrl:BDFHOMENEWSCATEGORY];
    jectsRequest.content_version_ios = @"110";
    [jectsRequest bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFHomeSubjectsModel *model = [BDFHomeSubjectsModel modelWithDictionary:response];
        self.newsView.subjectsModel = model;
    }];
}

- (void)setNav {
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftButton addTarget:self action:@selector(searchItemAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self setNavLeftItem:leftBarItem];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton addTarget:self action:@selector(publishItemAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"nav_pub"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self setNavRightItem:rightBarItem];
}

- (void)searchItemAction {
    BDFHomeSearchController *vc = [[BDFHomeSearchController alloc] init];
    [self pushVc:vc];
}

- (void)publishItemAction {
    
}

#pragma mark - BDFHomeTitleDelegate
- (void)homeTitleCliclAction {
    
    UIView *inView = self.tabBarController.view;
    CGPoint converPoint = CGPointMake(SCREEN_WIDTH / 2, 0);
    CGPoint inPoint = [self.view convertPoint:converPoint toView:inView];
    [self.newsView reloadData];
    [self.popover showAtPoint:inPoint popoverPostion:DXPopoverPositionDown withContentView:self.newsView inView:inView];
}

- (void)dismissPop {
    [self.popover dismiss];
    self.popover = nil;
}

#pragma mark - BDFAllTypeNewsViewDidSelectDelegate
/** 新热榜 */
- (void)bdfHomeSubjectsDidSelect_hotnews {
    [self dismissPop];
}
/** 42区 */
- (void)bdfHomeSubjectsDidSelect_news {
    [self dismissPop];
}
/** 段子 */
- (void)bdfHomeSubjectsDidSelect_scoff {
    [self dismissPop];
}
/** 图片 */
- (void)bdfHomeSubjectsDidSelect_pic {
    [self dismissPop];
}
/** 挨踢1024 */
- (void)bdfHomeSubjectsDidSelect_tec {
    [self dismissPop];
}
/** 你问我答 */
- (void)bdfHomeSubjectsDidSelect_ask {
    [self dismissPop];
}
/** 视频 */
- (void)bdfHomeSubjectsDidSelect_video {
    [self dismissPop];
}

/** 最热榜 */
- (void)bdfHomeSubjectsDidSelectMostHot {
    
}
/** 话题 */
- (void)bdfHomeSubjectsDidSelectTopic {
    
}
/** 关注人动态 */
- (void)bdfHomeSubjectsDidSelectAttention {
    
}
/** 人类发布 */
- (void)bdfHomeSubjectsDidSelectPeople {
    
}
/** 私藏 */
- (void)bdfHomeSubjectsDidSelectCollection {
    
}

- (DXPopover *)popover {
    if (!_popover) {
        DXPopover *popover = [DXPopover popover];
        WeakSelf(weakSelf);
        popover.didDismissHandler = ^{
            weakSelf.popover = nil;
        };
        _popover = popover;
    }
    return _popover;
}

- (BDFAllTypeNewsView *)newsView {
    if (!_newsView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        BDFAllTypeNewsView *newsView = [[BDFAllTypeNewsView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [newsView registerClass:[BDFAllTypeCollectionCell class] forCellWithReuseIdentifier:@"BDFAllTypeCollectionCell"];
        newsView.selectDelegate = self;
        _newsView = newsView;
    }
    return _newsView;
}

@end
