//
//  BDFCommentFrameModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/4.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFHomeCommenntsModel.h"

@interface BDFCommentFrameModel : BDFBaseModel

@property (nonatomic,strong) BDFHomeCommenntModel *commentModel;

@property (nonatomic, assign) CGRect userImageF;

@property (nonatomic, assign) CGRect userNameF;

@property (nonatomic, assign) CGRect timeAndModuleF;

@property (nonatomic, assign) CGRect upsButtonF;

@property (nonatomic, assign) CGRect downButtonF;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic,assign) NSInteger deep;

@end
