//
//  BDFHomeSubjectsModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/30.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDFHomeSubjectModel;

@interface BDFHomeSubjectsModel : BDFBaseModel

@property (nonatomic, strong) NSMutableArray <BDFHomeSubjectModel *> *subjects;

@end

@interface BDFHomeSubjectModel : BDFBaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_prefix;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_cn;
@property (nonatomic, strong) NSString *name_en;
@property (nonatomic, strong) NSString *supportImage;
@property (nonatomic, strong) NSString *supportLink;
@property (nonatomic, strong) NSString *supportWord;
@property (nonatomic, strong) NSString *uri;

@end

NS_ASSUME_NONNULL_END
