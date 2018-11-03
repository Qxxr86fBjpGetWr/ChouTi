//
//  BDFHomeCommentIndexModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/3.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

@class BDFHomeHotNewsModelLink, BDFHomeCommentIndexComment;

@interface BDFHomeCommentIndexModel : BDFBaseModel

@property (nonatomic, strong) BDFHomeHotNewsModelLink *link;

@property (nonatomic, strong) BDFHomeCommentIndexComment *comments;

@end

@interface BDFHomeCommentIndexComment : BDFBaseModel

@property (nonatomic, strong) NSDictionary *depthMap;

@property (nonatomic, strong) NSArray *ids;

@property (nonatomic, strong) NSDictionary *scores;

@property (nonatomic, strong) NSDictionary *actionMap;

@property (nonatomic, strong) NSDictionary *childrenMap;

@property (nonatomic, strong) NSDictionary *timeMap;

@property (nonatomic, strong) NSDictionary *treeMap;

@end
