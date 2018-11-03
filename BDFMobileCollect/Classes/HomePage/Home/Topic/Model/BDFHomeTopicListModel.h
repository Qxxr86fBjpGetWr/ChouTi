//
//  BDFHomeTopicListModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDFHomeTopicListRespRecordsModel, BDFHomeTopicListRespModel;

@interface BDFHomeTopicListModel : BDFBaseModel

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) BDFHomeTopicListRespModel *resp;

@property (nonatomic, assign) NSInteger code;

@end

@interface BDFHomeTopicListRespModel : BDFBaseModel

@property (nonatomic, assign) BOOL first;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, assign) NSInteger current;

@property (nonatomic, assign) BOOL last;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray *orderByList;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger offset;

@property (nonatomic, assign) NSInteger limit;

@property (nonatomic, strong) NSString *extend;

@property (nonatomic, assign) BOOL searchCount;

@property (nonatomic, assign) NSInteger offsetCurrent;

@property (nonatomic, strong) NSMutableArray <BDFHomeTopicListRespRecordsModel *> *records;

@end

@interface BDFHomeTopicListRespRecordsModel : BDFBaseModel

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL attention;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *description;

@property (nonatomic, strong) NSString *action;

@property (nonatomic, strong) NSString *actionTime;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *deleteInfo;

@property (nonatomic, strong) NSString *enName;

@property (nonatomic, strong) NSString *isPublic;

@property (nonatomic, strong) NSString *originalImgUrl;

@property (nonatomic, strong) NSString *showType;

@property (nonatomic, strong) NSString *sort;

@property (nonatomic, strong) NSString *story;

@property (nonatomic, strong) NSString *storyImgUrl;

@property (nonatomic, strong) NSString *supportImage;

@property (nonatomic, strong) NSString *supportLink;

@property (nonatomic, strong) NSString *supportWord;

@property (nonatomic, strong) NSString *type;


@end

NS_ASSUME_NONNULL_END
