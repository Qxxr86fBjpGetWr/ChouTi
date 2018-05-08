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
#import "BDFCommentFrameModel.h"

@interface BDFHomeCommentController ()<BDFHomeHotNewsCellButtonDelegate>

@property (nonatomic,strong) NSMutableArray <BDFCommentFrameModel *>*commentsArray;

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
            
            for (BDFHomeCommenntModel *obj in commentModel.commentsArray) {
                BDFCommentFrameModel *commentFraModel = [[BDFCommentFrameModel alloc] init];
                NSString *deep = model.comments.childrenMap[[NSString stringWithFormat:@"%ld",obj.id]];
                commentFraModel.deep = [deep integerValue];
                commentFraModel.commentModel = obj;
                [self.commentsArray addObject:commentFraModel];
            }
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
    
    if (indexPath.section == 0) {
         BDFBaseTableViewCell *cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
        [cell setValue:_cellFrame forKey:@"newsFrame"];
        return cell;
    }else {
        BDFHomeCommentsCell *cell = [BDFHomeCommentsCell cellWithTableView:self.tableView];
        cell.commentFrameModel = self.commentsArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGRectGetMaxY(self.cellFrame.shareButtomF);
    }else {
         BDFCommentFrameModel *commentFrameModel = self.commentsArray[indexPath.row];
        return CGRectGetMaxY(commentFrameModel.contentF);
    }
}

-(NSMutableArray<BDFCommentFrameModel *> *)commentsArray {
    if (!_commentsArray) {
        _commentsArray = [NSMutableArray array];
    }
    return _commentsArray;
}

@end
