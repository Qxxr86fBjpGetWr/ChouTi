//
//  BDFHomePageViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFHomePageViewController.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFHomeHotNewsModel.h"
#import "BDFHomeHotNewsCell.h"
#import "BDFTableViewHeaderFooterView.h"
#import "BDFHomeNewsMoreRequest.h"
#import "BDFUserInfoManager.h"
#import "BDFLogAndRegViewController.h"
#import "BDFHomeHotNewsUpsRequest.h"
#import "BDFHomeHotNewsAddRequest.h"
#import "BDFHomeCommentController.h"

@interface BDFHomePageViewController ()<BDFHomeHotNewsCellButtonDelegate>

//@property (nonatomic, strong)BDFHomeHotNewsModel *hotNewsModel;

@property (nonatomic, strong) NSMutableArray *hotNewsFrameArray;

@end

@implementation BDFHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needCellSepLine = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.refreshType = BDFBaseTableVcRefreshTypeRefreshAndLoadMore;
    
    [self setNav];
    [self loadData];
}

- (void)setNav {
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftButton setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self setNavLeftItem:leftBarItem];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setImage:[UIImage imageNamed:@"nav_pub"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self setNavRightItem:rightBarItem];
}

- (void)loadData {
    
    [self.hotNewsFrameArray removeAllObjects];
    
    BDFHomePageHotNewsRequest *request = [BDFHomePageHotNewsRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWS];
    request.brush = @"0";
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFHomeHotNewsModel *hotNewsModel = [BDFHomeHotNewsModel modelWithDictionary:response];
        for (BDFHomeHotNewsModelLink *obj in hotNewsModel.links) {
            BDFHomeHotNewsFrame *newsFrame = [[BDFHomeHotNewsFrame alloc] init];
            newsFrame.hotNewsModel = obj;
            [self.hotNewsFrameArray addObject:newsFrame];
        }
        [self bdf_endRefresh];
        [self bdf_reloadData];
    }];
}

-(void)bdf_refresh {
    [self loadData];
}

-(void)bdf_loadMore {

    BDFHomeHotNewsFrame *frame = self.hotNewsFrameArray.lastObject;
    BDFHomeNewsMoreRequest *request = [BDFHomeNewsMoreRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWS];
    request.after_time = frame.hotNewsModel.operateTime;
    request.brush = @"0";
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFHomeHotNewsModel *hotNewsModel = [BDFHomeHotNewsModel modelWithDictionary:response];
        for (BDFHomeHotNewsModelLink *obj in hotNewsModel.links) {
            BDFHomeHotNewsFrame *newsFrame = [[BDFHomeHotNewsFrame alloc] init];
            newsFrame.hotNewsModel = obj;
            [self.hotNewsFrameArray addObject:newsFrame];
        }
        [self bdf_endLoadMore];
        [self bdf_reloadData];
    }];
}

-(void)loginOut{
    [self dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)bdf_numberOfSections {
    return 1;
}

-(NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    
    return self.hotNewsFrameArray.count;
}

-(BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsCell *cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
    cell.buttonDelegate = self;
    cell.newsFrame = self.hotNewsFrameArray[indexPath.row];
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsFrame *cellFrame = self.hotNewsFrameArray[indexPath.row];
    return CGRectGetMaxY(cellFrame.upsButtonF);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {

    view.tintColor = kClearColor;
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

-(void)homeTableViewCell:(BDFHomeHotNewsCell *)cell didClickImageView:(BDFBaseImageView *)image currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls {
    
}

#pragma mark scrollViewDidScroll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (NSMutableArray *)hotNewsFrameArray {
    
    if (!_hotNewsFrameArray) {
        _hotNewsFrameArray = @[].mutableCopy;
    }
    return _hotNewsFrameArray;
}

@end