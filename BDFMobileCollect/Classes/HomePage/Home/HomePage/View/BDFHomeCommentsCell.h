//
//  BDFHomeCommentsCell.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/28.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableViewCell.h"
#import "BDFCommentFrameModel.h"
#import "BDFCommentTreeItemModel.h"

@interface BDFHomeCommentsCell : BDFBaseTableViewCell

@property (nonatomic,strong) BDFCommentFrameModel *commentFrameModel;

@property (nonatomic, strong) BDFCommentTreeItemModel *treeItem;

@end
