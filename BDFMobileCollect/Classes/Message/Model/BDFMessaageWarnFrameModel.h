//
//  BDFMessaageWarnFrameModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFMessageWarnModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFMessaageWarnFrameModel : BDFBaseModel

@property (nonatomic, strong) BDFMessageWarnDataModel *dataModel;

@property (nonatomic, assign) CGRect headImageR;
@property (nonatomic, assign) CGRect nickNameR;
@property (nonatomic, assign) CGRect timeR;
@property (nonatomic, assign) CGRect actionR;
@property (nonatomic, assign) CGRect commentR;
@property (nonatomic, assign) CGRect linkR;

@end

NS_ASSUME_NONNULL_END
