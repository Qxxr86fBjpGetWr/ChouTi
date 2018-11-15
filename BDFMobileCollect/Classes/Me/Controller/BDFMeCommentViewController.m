//
//  BDFMeCommentViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeCommentViewController.h"
#import "BDFBaseRequest.h"
#import "BDFMeCommentCell.h"
#import "BDFMeCommentFrameModel.h"

@interface BDFMeCommentViewController ()
@property (nonatomic, strong) NSMutableArray *frameDataArray;
@end

@implementation BDFMeCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.frameDataArray = [NSMutableArray array];
    [self loadData];
}

-(void)loadData {
    BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:BDFHOMECOMMENTLIST];
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFMeCommentModel *model = [BDFMeCommentModel modelWithDictionary:response];
        [model.comments enumerateObjectsUsingBlock:^(BDFMeCommentsCommentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BDFMeCommentFrameModel *frame = [[BDFMeCommentFrameModel alloc] init];
            frame.model = obj;
            [self.frameDataArray addObject:frame];
            [self bdf_reloadData];
        }];
    }];
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.frameDataArray.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    BDFMeCommentCell *cell = [BDFMeCommentCell cellWithTableView:self.tableView];
    cell.model = self.frameDataArray[indexPath.row];
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    BDFMeCommentFrameModel *moel = self.frameDataArray[indexPath.row];
    return CGRectGetMaxY(moel.textLabelF)+20;
}

@end
