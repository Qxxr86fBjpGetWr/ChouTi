//
//  BDFNotificationViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/20.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFNotificationViewController.h"
#import "BDFCustomCommonEmptyView.h"
#import "BDFBaseRequest.h"
#import "BDFSystemMessageModel.h"
#import "BDFMessageSystemCell.h"

@interface BDFNotificationViewController ()

@property (nonatomic, strong) BDFCustomCommonEmptyView *emptyView;

@property (nonatomic, strong) BDFSystemMessageModel *messageModel;

@end

@implementation BDFNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:BDFHOMEMESSAGEINFORMLIST];
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        self.messageModel = [BDFSystemMessageModel modelWithDictionary:response];
        self.emptyView.hidden = self.messageModel.notice;
        [self bdf_reloadData];
    }];
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.messageModel.notice.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    BDFMessageSystemCell *cell = [BDFMessageSystemCell cellWithTableView:self.tableView];
    cell.systemMessage = self.messageModel.notice[indexPath.row];
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (BDFCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        BDFCustomCommonEmptyView *empty = [[BDFCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"" iconname:@"empty"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}


@end
