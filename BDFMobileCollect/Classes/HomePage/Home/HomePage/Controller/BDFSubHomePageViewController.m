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
#import "BDFMostHotView.h"

#import "BDFNewsHotViewController.h"
#import "BDFSubMostHotNewsViewController.h"
#import "BDF42AllNewsViewController.h"
#import "BDFHomeTopicViewController.h"
#import "BDFHomeTopicViewController.h"

#import "BDFJokesViewController.h"
#import "BDFPictureViewController.h"
#import "BDF1024ViewController.h"
#import "BDFQAndAViewController.h"
#import "BDFFocusOnPeopleController.h"
#import "BDFVideoViewController.h"
#import "BDFHumanReleaseController.h"
#import "BDFCollectionViewController.h"
#import "BDFHomeRefreshModel.h"
#import "BDFRefreshNormalHeader.h"

@interface BDFSubHomePageViewController ()<BDFHomeTitleDelegate, BDFAllTypeNewsViewDidSelectDelegate>

@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) BDFAllTypeNewsView *newsView;
@property (nonatomic, strong) BDFHomeTitleView *titleView;

@end

@implementation BDFSubHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bdfHomeSubjectsDidSelect_hotnews];
    /**
     刷新消息提示
     https://api.chouti.com/api/refreshHintsList.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
    [self setNav];
    [self loadData];
    [self setCustomTitleView:nil];
}

- (void)setCustomTitleView:(NSString *)title {

    self.titleView.title = title;
    self.navigationItem.titleView = self.titleView;
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
    
    BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:BDFHOMEREFRESHTEXT];
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFHomeRefreshModel *model = [BDFHomeRefreshModel modelWithDictionary:response];
        [model archive];
//        BDFHomeRefreshRespModel *respModel = model.resp.firstObject;
//        [(BDFRefreshNormalHeader *)self.refreshHeader setTitle:respModel.content forState:MJRefreshStateIdle];
//        [(BDFRefreshNormalHeader *)self.refreshHeader setTitle:respModel.content forState:MJRefreshStateRefreshing];
//        [(BDFRefreshNormalHeader *)self.refreshHeader setTitle:respModel.content forState:MJRefreshStateIdle];
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

- (void)removeAllChildVC {
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeChildVc:obj];
    }];
}

#pragma mark - BDFAllTypeNewsViewDidSelectDelegate
/** 新热榜 */
- (void)bdfHomeSubjectsDidSelect_hotnews {
    [self setCustomTitleView:nil];
    [self handChageViewWithClass:[BDFNewsHotViewController class]];
}
/** 42区 */
- (void)bdfHomeSubjectsDidSelect_news {
    [self setCustomTitleView:@"42区"];
    [self handChageViewWithClass:[BDF42AllNewsViewController class]];
}
/** 段子 */
- (void)bdfHomeSubjectsDidSelect_scoff {
    [self setCustomTitleView:@"段子"];
    [self handChageViewWithClass:[BDFJokesViewController class]];
}
/** 图片 */
- (void)bdfHomeSubjectsDidSelect_pic {
    [self setCustomTitleView:@"图片"];
    [self handChageViewWithClass:[BDFPictureViewController class]];
}
/** 挨踢1024 */
- (void)bdfHomeSubjectsDidSelect_tec {
    [self setCustomTitleView:@"挨踢1024"];
    [self handChageViewWithClass:[BDF1024ViewController class]];
}
/** 你问我答 */
- (void)bdfHomeSubjectsDidSelect_ask {
    [self setCustomTitleView:@"你问我答"];
    [self handChageViewWithClass:[BDFQAndAViewController class]];
}
/** 视频 */
- (void)bdfHomeSubjectsDidSelect_video {
    [self setCustomTitleView:@"视频"];
    [self handChageViewWithClass:[BDFVideoViewController class]];
}
/** 最热榜 */
- (void)bdfHomeSubjectsDidSelectMostHot {
    [self setCustomTitleView:@"最热榜"];
    [self handChageViewWithClass:[BDFSubMostHotNewsViewController class]];
}
/** 话题 */
- (void)bdfHomeSubjectsDidSelectTopic {
    [self setCustomTitleView:@"话题"];
    [self handChageViewWithClass:[BDFHomeTopicViewController class]];
}
/** 关注人动态 */
- (void)bdfHomeSubjectsDidSelectAttention {
    [self setCustomTitleView:@"关注人动态"];
    [self handChageViewWithClass:[BDFFocusOnPeopleController class]];
}
/** 人类发布 */
- (void)bdfHomeSubjectsDidSelectPeople {
    [self setCustomTitleView:@"人类发布"];
    [self handChageViewWithClass:[BDFHumanReleaseController class]];
}
/** 私藏 */
- (void)bdfHomeSubjectsDidSelectCollection {
    [self setCustomTitleView:@"私藏"];
    [self handChageViewWithClass:[BDFCollectionViewController class]];
}

- (void)handChageViewWithClass:(Class)class {
    [self dismissPop];
    [self removeAllChildVC];
    if (!class) {
        return;
    }
    [self addChildVc:[[class alloc] init]];
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

- (BDFHomeTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[BDFHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        _titleView.delegate = self;
    }
    return _titleView;
}

@end
