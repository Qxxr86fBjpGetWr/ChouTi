//
//  BDFMessageTableViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/25.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFMessageTableViewController.h"
#import "BDFMessageTableViewCell.h"
#import "BDFMessageRequest.h"
#import "BDFMessageModel.h"

@interface BDFMessageTableViewController ()

@end

@implementation BDFMessageTableViewController

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setController];
    
    [self loadData];
}

-(void)setController {
    self.needCellSepLine = NO;
    self.refreshType = BDFBaseTableVcRefreshTypeRefreshAndLoadMore;
}

-(void)loadData {
    BDFMessageRequest *request = [BDFMessageRequest bdf_request];
    request.bdf_url = BDFBINGIMAGEAPI;
    request.p = 1;
    request.size = 10;
    
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        if (success) {
            BDFMessageModel *model = [BDFMessageModel modelWithDictionary:response];
            BDFLog(@"status:%@-----data%@",model.status,model.data);
            
            BDFMessageDataModel *dataModel = model.data[0];
            BDFLog(@"%ld%@",dataModel.ID,dataModel.desc);
            
            [self.dataArray addObjectsFromArray:model.data];
            [self bdf_reloadData];
        }
    }];
}

-(NSInteger)bdf_numberOfSections {
    return 1;
}

-(NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}


-(BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    BDFMessageTableViewCell *cell = [BDFMessageTableViewCell cellWithTableView:self.tableView];
    cell.dataModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
