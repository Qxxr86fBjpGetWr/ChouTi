//
//  BDFSearchPublishViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFSearchPublishViewController.h"
#import "BDFSearchPublishRequest.h"
#import "BDFSearchPublishListModel.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFHomeHotNewsCell.h"
#import "BDFDetailWebViewController.h"
#import "BDFHomeHotNewsUpsRequest.h"
#import "BDFUserInfoManager.h"
#import "BDFLogAndRegViewController.h"
#import "BDFHomeHotNewsAddRequest.h"
#import "BDFHomeCommentController.h"
#import "BDFSearchPublishToolView.h"
#import "BDFSearchPublishMenuView.h"

@interface BDFSearchPublishViewController ()<BDFHomeHotNewsCellButtonDelegate, BDFSearchPublishToolDelegate>

@property (nonatomic, copy) NSString *searchWord;

@property (nonatomic, strong) NSMutableArray *hotNewsFrameArray;

@property (nonatomic, weak) BDFSearchPublishToolView *toolView;

@property (nonatomic, weak) UIView *tempView;

@property (nonatomic, strong) BDFSearchPublishMenuView *menuView;

@end

@implementation BDFSearchPublishViewController


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needCellSepLine = NO;
    self.tableView.hidden = YES;
    self.refreshType = BDFBaseTableVcRefreshTypeRefreshAndLoadMore;
    self.tableView.y = self.toolView.bottom;
    
    [self loadData];
}

- (instancetype)initWithSearchWord:(NSString *)word
{
    self = [super init];
    if (self) {
        self.searchWord = word;
    }
    return self;
}

- (void)loadData {
    BDFSearchPublishRequest *request = [BDFSearchPublishRequest bdf_requestWithUrl:BDFHOMESEARCHPUBLISH isPost:YES];
    request.words = _searchWord;
    request.searchType = 2;
    request.page = 1;
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        
        BDFSearchPublishListModel *model = [BDFSearchPublishListModel modelWithDictionary:response];
        for (BDFHomeHotNewsModelLink *obj in model.linksList) {
            BDFHomeHotNewsFrame *newsFrame = [[BDFHomeHotNewsFrame alloc] init];
            newsFrame.hotNewsModel = obj;
            [self.hotNewsFrameArray addObject:newsFrame];
        }
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }];
}

- (void)setSearchWord:(NSString *)searchWord {
    if (!searchWord) {
        return;
    }
    _searchWord = searchWord;
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.hotNewsFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsCell *cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
    cell.buttonDelegate = self;
    cell.newsFrame = self.hotNewsFrameArray[indexPath.row];
    BDFLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    return cell;
}

- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell {
    BDFHomeHotNewsFrame *frame = self.hotNewsFrameArray[indexPath.row];
    BDFDetailWebViewController *vc = [[BDFDetailWebViewController alloc] initWithUrl:frame.hotNewsModel.url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsFrame *cellFrame = self.hotNewsFrameArray[indexPath.row];
    return CGRectGetMaxY(cellFrame.upsButtonF);
}

#pragma mark - BDFSearchPublishToolDelegate
- (void)searchPublishTimeAction:(UIButton *)timeButton {
    
    BDFSearchPublishMenuView *view = [[BDFSearchPublishMenuView alloc] initWithFrame:CGRectMake(0, SCREEN_StatusBarAndNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_StatusBarAndNavBarHeight)];
    [view show];
}

- (void)searchPublishCategoryAction:(UIButton *)timeButton {
    
}

- (void)searchPublishHotAction:(UIButton *)timeButton {
    
}

#pragma mark - BDFHomeHotNewsCellButtonDelegate
-(void)homeTableViewCell:(BDFHomeHotNewsCell *)cell didClickItemWithType:(BDFHomeTableViewCellItemType)itemType {
    
    /** 需要登录 */
    if (itemType == BDFHomeTableViewCellItemTypeLike || itemType == BDFHomeTableViewCellItemTypeCollection) {
        BOOL hasLogin = [BDFUserInfoManager sharedManager].isLogin;
        if (!hasLogin) {
            BDFLogAndRegViewController *loginVC = [[BDFLogAndRegViewController alloc] init];
            [self pushVc:loginVC];
            return;
        }
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    // 数据
    BDFHomeHotNewsFrame *cellFrame = [self.hotNewsFrameArray objectAtIndex:indexPath.row];
    
    if (itemType == BDFHomeTableViewCellItemTypeLike) {/** 推荐 */
        BDFHomeHotNewsUpsRequest *request = [BDFHomeHotNewsUpsRequest bdf_requestWithUrl:nil isPost:YES];
        request.link_id = cellFrame.hotNewsModel.id;
        if (cellFrame.hotNewsModel.has_uped) {
            request.bdf_url = BDFHOMEPAGEHOTNNEWSREMOVEUPS;
        }else {
            request.bdf_url = BDFHOMEPAGEHOTNNEWSUPS;
        }
        [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
            
            cellFrame.hotNewsModel.ups = [response[@"ups"] integerValue];
            cellFrame.hotNewsModel.has_uped = !cellFrame.hotNewsModel.has_uped;
            [cell ups];
        }];
        
    }else if (itemType == BDFHomeTableViewCellItemTypeCollection) {/** 私藏 */
        
        BDFHomeHotNewsAddRequest *request = [BDFHomeHotNewsAddRequest bdf_requestWithUrl:nil isPost:YES];
        request.ids = [NSString stringWithFormat:@"%ld",cellFrame.hotNewsModel.id];
        if (cellFrame.hotNewsModel.has_saved) {
            request.bdf_url = BDFHOMEPAGEHOTNNEWSDELADD;
        }else {
            request.bdf_url = BDFHOMEPAGEHOTNNEWSADD;
        }
        [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
            //cellFrame.hotNewsModel.id = [response[@"ids"] integerValue];
            cellFrame.hotNewsModel.has_saved = !cellFrame.hotNewsModel.has_saved;
            [cell collection];
        }];
        
    }else if (itemType == BDFHomeTableViewCellItemTypeComment) {/** 评论 */
        BDFHomeCommentController *commentVC = [[BDFHomeCommentController alloc] init];
        commentVC.cellFrame = cellFrame;
        [self pushVc:commentVC];
        
    }else if (itemType == BDFHomeTableViewCellItemTypeShare) {/** 分享 */
        
    }else {
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)hotNewsFrameArray {
    if (!_hotNewsFrameArray) {
        NSMutableArray *array = [NSMutableArray array];
        _hotNewsFrameArray = array;
    }
    return _hotNewsFrameArray;
}

- (BDFSearchPublishToolView *)toolView {
    if (!_toolView) {
        BDFSearchPublishToolView *toolView = [[BDFSearchPublishToolView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        toolView.backgroundColor = kWhiteColor;
        toolView.toolVDelegate = self;
        _toolView = toolView;
        [self.view addSubview:self.toolView];
    }
    return _toolView;
}

- (UIView *)tempView {
    if (!_tempView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH, 100)];
        view.backgroundColor = kPurpleColor;
        [self.view addSubview:view];
        _tempView = view;
    }
    return _tempView;
}

- (BDFSearchPublishMenuView *)menuView {
    if (!_menuView) {
        BDFSearchPublishMenuView *view = [[BDFSearchPublishMenuView alloc] initWithFrame:CGRectMake(0, SCREEN_StatusBarAndNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_StatusBarAndNavBarHeight)];
        _menuView = view;
    }
    return _menuView;
}

@end
