//
//  BDFMeViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFMeViewController.h"
#import "BDFMeTableViewCell.h"
#import "BDFMeDataModel.h"
#import "BDFMeHeaderView.h"
#import "BDFMeRequest.h"
#import "BDFLoginSucModel.h"
#import "BDFUserInfoManager.h"
#import "BDFMeMoreSettingController.h"
#import "BDFLogAndRegViewController.h"
#import "BDFLogAndRegViewDelegate.h"
#import "BDFMainTabBarController.h"
#import "AppDelegate.h"
#import "BDFCollectionViewController.h"
#import "BDFMeHistoryViewController.h"
#import "BDFRecommendCommendPublishViewController.h"

#define TITLE @"meCellTitle"
#define ICON @"meCellIcon"
#define TYPE @"type"
#define DATA @"data"
#define ACTION @"action"

typedef NS_ENUM(NSInteger, BDFMeCellType) {
    BDFMeCellNormal,
    BDFMeCellDetail,
    BDFMeCellSwitch,
};

@interface BDFMeViewController () <BDFMeAttentionDelegate, BDFMeMoreSettingDelegate, BDFLogAndRegViewDelegate>
@property (nonatomic, strong) NSDictionary <NSNumber *, NSArray<NSDictionary *> *> *dateSource;

@property (nonatomic, strong) BDFMeHeaderView *headerView;
@property (nonatomic, strong) BDFLoginSucModel *sucModel;
@end

@implementation BDFMeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kColorFromRGB(0xf5f5f5);
    self.tableView.separatorColor = kColorFromRGB(0xededed);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.headerView stretchHeaderForTableView:self.tableView withView:self.headerView subViews:nil];
    [self loadData];
    
    /**
     
     黑名单
     https://api.chouti.com/users/getBlackList.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
    
}

-(void)loadData {
    BDFMeRequest *request = [BDFMeRequest bdf_requestWithUrl:BDFMEDATA];
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        self.sucModel = [BDFLoginSucModel modelWithDictionary:response];
        [self creatMeData];
        [self.tableView reloadData];
        [[BDFUserInfoManager sharedManager] resetUserInfoWithUserInfo:_sucModel];
    }];
}

- (NSInteger)bdf_numberOfSections {
    return self.dateSource.allKeys.count;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    NSNumber *sectionNum = [NSNumber numberWithInteger:section];
    NSArray *sectionArray = self.dateSource[sectionNum];
    return sectionArray.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFMeTableViewCell *cell = [BDFMeTableViewCell cellWithTableView:self.tableView];
    BDFMeDataModel *dataModel = [self getMeDataModeWithIndexPath:indexPath];
    cell.dataModel = dataModel;
    return cell;
}

- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell {
    BDFMeDataModel *dataModel = [self getMeDataModeWithIndexPath:indexPath];
    SEL cellAction = NSSelectorFromString(dataModel.action);
    if ([self respondsToSelector:cellAction]) {
        [self performSelector:cellAction];
    }
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView scrollViewDidScroll:scrollView];
}

- (BDFMeDataModel *)getMeDataModeWithIndexPath:(NSIndexPath *)indexPath {
    NSNumber *sectionNum = [NSNumber numberWithInteger:indexPath.section];
    NSArray *sectionArray = self.dateSource[sectionNum];
    BDFMeDataModel *dataModel = [BDFMeDataModel modelWithDictionary:sectionArray[indexPath.row]];
    return dataModel;
}

- (BDFMeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BDFMeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.delegete = self;
        _headerView.loginDelegate = self;
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 更多设置
- (void)moreSetting {
    BDFMeMoreSettingController *vc = [[BDFMeMoreSettingController alloc] init];
    vc.moreDelegate = self;
    [self pushVc:vc];
}

#pragma mark - BDFMeAttentionDelegate
- (void)bdfMeAttention {}

- (void)bdfAttentionMe {}

#pragma mark - BDFLogAndRegViewDelegate
- (void)clickLoginButtonComplete {
    BDFLogAndRegViewController *vc = [[BDFLogAndRegViewController alloc] init];
    vc.loginComplete = ^{
        [self.headerView setNeedsLayout];
        [self bdf_reloadData];
    };
    [self presentVc:vc];
}

- (void)clickRegisterButtonComplete {}

- (void)clickCloseButtonComplte {}

#pragma mark - BDFMeMoreSettingDelegate
- (void)didLoginOut {
    [self.headerView setNeedsLayout];
    [self bdf_reloadData];
}

- (void)historyCellAction {
    BDFMeHistoryViewController *history = [[BDFMeHistoryViewController alloc] init];
    [self pushVc:history];
}

- (void)collectionCellAction {
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    if (!isLogin) {
        [self clickLoginButtonComplete];
        return;
    }
    BDFCollectionViewController *collection = [[BDFCollectionViewController alloc] init];
    [self pushVc:collection];
}

- (void)recommendCommentPublishCellAction {
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    if (!isLogin) {
        [self clickLoginButtonComplete];
        return;
    }
    
    BDFRecommendCommendPublishViewController *vc = [[BDFRecommendCommendPublishViewController alloc] init];
    [self pushVc:vc];
}

- (void)creatMeData {
    
    NSString *likeCount = [NSString stringWithFormat:@"%ld",self.sucModel.liked_count];
    NSString *followCount = [NSString stringWithFormat:@"%ld",self.sucModel.followCount];
    NSString *commentCount = [NSString stringWithFormat:@"%ld",self.sucModel.selfCommentsCount];
    NSString *pulishCount = [NSString stringWithFormat:@"%ld",self.sucModel.submitted_count];
    NSString *ctCount = [NSString stringWithFormat:@"%ld",self.sucModel.ct];
    NSString *banCount = [NSString stringWithFormat:@"%ld",self.sucModel.isBindPhone];
    
    self.dateSource = @{
                        @0 : @[
                                @{
                                    TITLE : @"最近浏览",
                                    ICON : @"time",
                                    TYPE : @0,
                                    ACTION : @"historyCellAction",
                                    },
                                @{
                                    TITLE : @"私藏",
                                    ICON : @"my_collection",
                                    TYPE : @1,
                                    DATA : likeCount,
                                    ACTION : @"collectionCellAction",
                                    },
                                @{
                                    TITLE : @"推荐",
                                    ICON : @"my_good",
                                    TYPE : @1,
                                    DATA : followCount,
                                    ACTION : @"recommendCommentPublishCellAction",
                                    },
                                @{
                                    TITLE : @"评论",
                                    ICON : @"my_comment",
                                    TYPE : @1,
                                    DATA : commentCount,
                                    ACTION : @"recommendCommentPublishCellAction",
                                    },
                                @{
                                    TITLE : @"发布",
                                    ICON : @"my_pub",
                                    TYPE : @1,
                                    DATA : pulishCount,
                                    ACTION : @"recommendCommentPublishCellAction",
                                    },
                                @{
                                    TITLE : @"钱包",
                                    ICON : @"my_wallet",
                                    TYPE : @1,
                                    DATA : ctCount,
                                    ACTION : @"",
                                    },
                                @{
                                    TITLE : @"黑名单",
                                    ICON : @"my_hei",
                                    TYPE : @0,
                                    DATA : banCount,
                                    ACTION : @"",
                                    },
                                ],
                        @1 : @[
                                @{
                                    TITLE : @"夜间模式",
                                    ICON : @"my_night",
                                    TYPE : @2,
                                    ACTION : @"",
                                    },
                                @{
                                    TITLE : @"更多设置",
                                    ICON : @"my_set",
                                    TYPE : @0,
                                    ACTION : NSStringFromSelector(@selector(moreSetting)),
                                    },
                                ],
                        };
}

@end
