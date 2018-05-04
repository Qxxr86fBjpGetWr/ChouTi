//
//  BDFHomeCommentController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/28.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeCommentController.h"
#import "BDFHomeHotNewsCell.h"
#import "BDFHomeCommentsCell.h"
#import "BDFHomeHotNewsUpsRequest.h"
#import "BDFHomeCommentIndexModel.h"
#import "BDFHomeHotNewsAddRequest.h"
#import "BDFHomeCommenntsModel.h"

@interface BDFHomeCommentController ()<BDFHomeHotNewsCellButtonDelegate>

@property (nonatomic,strong) NSArray <BDFHomeCommenntModel *>*commentsArray;

@end

@implementation BDFHomeCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needCellSepLine = NO;

    [self loadData];
}

-(void)loadData {
    [super loadData];
    
    BDFHomeHotNewsUpsRequest *indexRequest = [BDFHomeHotNewsUpsRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWSCOMMENTINDEX isPost:YES];
    indexRequest.link_id = _cellFrame.hotNewsModel.id;
    [indexRequest bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {

        BDFHomeCommentIndexModel *model =
        [BDFHomeCommentIndexModel modelWithDictionary:response];

        BDFHomeHotNewsAddRequest *commentsRequest = [BDFHomeHotNewsAddRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWSCOMMENT isPost:NO];
        commentsRequest.ids = [model.comments.ids componentsJoinedByString:@","];
        [commentsRequest bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
            BDFHomeCommenntsModel *commentModel = [[BDFHomeCommenntsModel alloc] init];
            commentModel.commentsArray = [BDFHomeCommenntModel modelArrayWithDictArray:response];
            BDFLog(@"%@",commentModel.commentsArray);
            self.commentsArray = [commentModel.commentsArray copy];
            [self bdf_reloadData];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)bdf_numberOfSections {
    return 2;
}

-(NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.commentsArray.count;
    }
}

-(BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
        cell.newsFrame = self.cellFrame;
    }else {
        cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
        BDFHomeCommenntModel *model = self.commentsArray[indexPath.row];
        if (model) {
            cell.textLabel.text = model.content;
        }
    }
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGRectGetMaxY(self.cellFrame.shareButtomF);
    }
    return 50;
}

@end
