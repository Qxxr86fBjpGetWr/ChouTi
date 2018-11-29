//
//  BDFHomeRefreshModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/28.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDFHomeRefreshRespModel;

@interface BDFHomeRefreshModel : BDFBaseModel

@property (nonatomic, strong) NSMutableArray <BDFHomeRefreshRespModel *> *resp;

@end

@interface BDFHomeRefreshRespModel : BDFBaseModel

@property (nonatomic, strong) NSString *activeTime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *enable;
@property (nonatomic, strong) NSString *id;

@end

NS_ASSUME_NONNULL_END
