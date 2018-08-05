//
//  BDFSearchSuggestModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

@class BDFSearchSuggestModelObject;

@interface BDFSearchSuggestModel : BDFBaseModel

@property (nonatomic, assign) BOOL ok;

@property (nonatomic, strong) BDFSearchSuggestModelObject *object;

@property (nonatomic, strong) NSString *desc;

@end

@interface BDFSearchSuggestModelObject :BDFBaseModel

@property (nonatomic, assign) BOOL ack;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray *resultList;

@property (nonatomic, assign) NSInteger maxScore;

@property (nonatomic, assign) NSInteger from;

@end

@interface BDFSearchSuggestModelObjectResult :BDFBaseModel

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, assign) NSInteger searchCount;

@property (nonatomic, strong) NSString *exact_text;

@property (nonatomic, assign) NSInteger extractCount;

@end

