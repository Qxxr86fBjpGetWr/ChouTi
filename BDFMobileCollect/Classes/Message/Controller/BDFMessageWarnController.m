//
//  BDFMessageWarnController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMessageWarnController.h"
#import "BDFBaseRequest.h"
#import "BDFMessageWarnModel.h"
#import "BDFMessaageWarnFrameModel.h"
#import "BDFMessageWarnCell.h"

@interface BDFMessageWarnController ()

@end

@implementation BDFMessageWarnController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:BDFHOMEMESSAGEWARNLIST];
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFMessageWarnModel *model = [BDFMessageWarnModel modelWithDictionary:response];
        for (BDFMessageWarnDataModel *data in model.data) {
            BDFMessaageWarnFrameModel *frameModel = [[BDFMessaageWarnFrameModel alloc] init];
            frameModel.dataModel = data;
            [self.dataArray addObject:frameModel];
        }
        [self.tableView reloadData];
    }];
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    BDFMessageWarnCell *cell = [BDFMessageWarnCell cellWithTableView:self.tableView];
    cell.frameModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    BDFMessaageWarnFrameModel *frameModel = self.dataArray[indexPath.row];
    return CGRectGetMaxY(frameModel.linkR) + 20;
}

@end
