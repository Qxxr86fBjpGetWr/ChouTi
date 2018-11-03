//
//  BDFCommentFrameModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/4.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFHomeCommenntsModel.h"
#import "BDFHomeCommentIndexModel.h"

@interface BDFCommentFrameModel : BDFBaseModel

@property (nonatomic,strong) BDFHomeCommenntModel *commentModel;

@property (nonatomic, strong) BDFHomeCommentIndexModel *indexModel;

@property (nonatomic, assign) CGRect userImageF;

@property (nonatomic, assign) CGRect userNameF;

@property (nonatomic, assign) CGRect timeAndModuleF;

@property (nonatomic, assign) CGRect upsButtonF;

@property (nonatomic, assign) CGRect downButtonF;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) NSInteger deep;
/** 是否有父节点 */
@property (nonatomic, assign) BOOL hasParent;
/** 是否有子节点 */
@property (nonatomic, assign) BOOL hasChild;
/** 下面是否有平级节点 */
@property (nonatomic, assign) BOOL hasBrother;

@end
