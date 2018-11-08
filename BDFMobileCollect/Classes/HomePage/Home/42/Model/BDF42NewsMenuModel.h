//
//  BDF42NewsMenuModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/8.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDF42NewsMenuRespModel;

@interface BDF42NewsMenuModel : BDFBaseModel

@property (nonatomic, strong) NSMutableArray <BDF42NewsMenuRespModel *> *resp;

@property (nonatomic, assign) NSInteger code;

@end

@interface BDF42NewsMenuRespModel : BDFBaseModel

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *value;

- (instancetype)initWithVale:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
