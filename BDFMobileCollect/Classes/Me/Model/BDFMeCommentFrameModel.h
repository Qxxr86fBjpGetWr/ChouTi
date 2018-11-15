//
//  BDFMeCommentFrameModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFMeCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFMeCommentFrameModel : BDFBaseModel

@property (nonatomic, strong) BDFMeCommentsCommentModel *model;

@property (nonatomic, assign) CGRect timeLabelF;

@property (nonatomic, assign) CGRect likeLabelF;

@property (nonatomic, assign) CGRect downLabelF;

@property (nonatomic, assign) CGRect commentLabelF;

@property (nonatomic, assign) CGRect textLabelF;

@end

NS_ASSUME_NONNULL_END
