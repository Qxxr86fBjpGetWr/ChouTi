//
//  BDFHomeTopicViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeTopicViewController.h"
#import "BDFHomeTopicRequest.h"
#import "BDFHomeTopicListTableCell.h"
#import "BDFHomeTopicDetailController.h"

@interface BDFHomeTopicViewController ()

@end

@implementation BDFHomeTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //话题：https://api.chouti.com/api/topic/list.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&pageNumber=1&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
    //点击cell ：https://api.chouti.com/api/topic/linkList.json?deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&pageNumber=1&source=c40fe2f61bcfd611177be71ec305196b&topicId=186&version=3.2.0.6
    self.refreshType = BDFBaseTableVcRefreshTypeRefreshAndLoadMore;
    [self loadData];
}

- (void)loadData {
    BDFHomeTopicRequest *request = [BDFHomeTopicRequest bdf_requestWithUrl:BDFHOMECATEGORYTOPICLIST];
    request.pageNumber = @"1";
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFHomeTopicListModel *model = [BDFHomeTopicListModel modelWithDictionary:response];
        self.dataArray = model.resp.records;
        [self bdf_reloadData];
    }];
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeTopicListRespRecordsModel *recordModel = self.dataArray[indexPath.row];
    BDFHomeTopicListTableCell *cell = [BDFHomeTopicListTableCell cellWithTableView:self.tableView];
    cell.recordModel = recordModel;
    return cell;
}

- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell {
    BDFHomeTopicListRespRecordsModel *recordModel = self.dataArray[indexPath.row];
    NSString *topicId = [NSString stringWithFormat:@"%ld",recordModel.id];
    BDFHomeTopicDetailController *vc = [[BDFHomeTopicDetailController alloc] initWithTopicId:topicId];
    [self pushVc:vc];
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
