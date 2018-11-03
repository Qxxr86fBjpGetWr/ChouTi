//
//  BDFHomeTopicListDetailModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFHomeHotNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFHomeTopicListDetailModel : BDFBaseModel

@property (nonatomic, strong) NSMutableArray <BDFHomeHotNewsModelLink *> *records;

@property (nonatomic, strong) NSString *pages;

@property (nonatomic, strong) NSString *size;

@property (nonatomic, strong) NSString *total;

@end

NS_ASSUME_NONNULL_END
