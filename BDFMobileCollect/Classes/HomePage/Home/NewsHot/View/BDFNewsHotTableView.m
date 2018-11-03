//
//  BDFNewsHotTableView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/2.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFNewsHotTableView.h"
#import "BDFHomeHotNewsCell.h"
#import <objc/runtime.h>
#import "BDFAvatarBrowser.h"
#import "BDFDetailWebViewController.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFUserInfoManager.h"
#import "BDFLogAndRegViewController.h"
#import "BDFHomeHotNewsAddRequest.h"
#import "BDFHomeCommentController.h"
#import "BDFHomeNewsMoreRequest.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFHomeHotNewsUpsRequest.h"

@interface BDFNewsHotTableView ()<UITableViewDelegate, UITableViewDataSource, BDFHomeHotNewsCellButtonDelegate>
@property (nonatomic, weak) BDFBaseViewController *delegateVc;
@end

static char const PREVIEWIMAGE;
@implementation BDFNewsHotTableView

- (instancetype)initWithFrame:(CGRect)frame withDelegateVc:(UIViewController *)vc {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.hotNewsFrameArray = @[].mutableCopy;
        self.delegateVc = (BDFBaseViewController *)vc;
    }
    return self;
}

- (void)setHotNewsFrameArray:(NSMutableArray *)hotNewsFrameArray {
    if (!hotNewsFrameArray) {
        return;
    }
    _hotNewsFrameArray = hotNewsFrameArray;
    [self reloadData];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotNewsFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDFHomeHotNewsCell *cell = [BDFHomeHotNewsCell cellWithTableView:self];
    cell.buttonDelegate = self;
    cell.newsFrame = self.hotNewsFrameArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        BDFHomeHotNewsFrame *frame = self.hotNewsFrameArray[indexPath.row];
        BDFDetailWebViewController *vc = [[BDFDetailWebViewController alloc] initWithUrl:frame.hotNewsModel.url];
        [self.delegateVc pushVc:vc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDFHomeHotNewsFrame *cellFrame = self.hotNewsFrameArray[indexPath.row];
    return CGRectGetMaxY(cellFrame.upsButtonF);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
    view.tintColor = kClearColor;
}

- (void)homeTableViewCell:(BDFHomeHotNewsCell *)cell didClickImageView:(BDFBaseImageView *)image currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls {
    
    objc_setAssociatedObject(self, &PREVIEWIMAGE, image, OBJC_ASSOCIATION_RETAIN);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [BDFAvatarBrowser showImage:image];
    }];
}

#pragma mark - BDFHomeHotNewsCellButtonDelegate
- (void)homeTableViewCell:(BDFHomeHotNewsCell *)cell didClickItemWithType:(BDFHomeTableViewCellItemType)itemType {
    
    /** 需要登录 */
    if (itemType == BDFHomeTableViewCellItemTypeLike || itemType == BDFHomeTableViewCellItemTypeCollection) {
        BOOL hasLogin = [BDFUserInfoManager sharedManager].isLogin;
        if (!hasLogin) {
            BDFLogAndRegViewController *loginVC = [[BDFLogAndRegViewController alloc] init];
            [self.delegateVc pushVc:loginVC];
            return;
        }
    }
    
    NSIndexPath *indexPath = [self indexPathForCell:cell];
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
        [self.delegateVc pushVc:commentVC];
        
    }else if (itemType == BDFHomeTableViewCellItemTypeShare) {/** 分享 */
        
    }else {
        return;
    }
}

@end
