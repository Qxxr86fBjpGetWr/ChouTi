//
//  BDFHomeCommenntsModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/3.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

@class BDFHomeCommenntModel, BDFHomeCommenntUserModel;

@interface BDFHomeCommenntsModel : BDFBaseModel

@property (nonatomic,strong) NSMutableArray <BDFHomeCommenntModel *> *commentsArray;

@end

@interface BDFHomeCommenntModel : BDFBaseModel

@property (nonatomic, assign) NSInteger downs;

@property (nonatomic, assign) NSInteger created_time;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger ups;

@property (nonatomic, strong) BDFHomeCommenntUserModel *user;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, assign) NSInteger action;

@property (nonatomic, assign) BOOL isBanUser;

@property (nonatomic, assign) BOOL selfStatus;

@property (nonatomic, assign) NSInteger is_vote;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) NSString *content;

@end

@interface BDFHomeCommenntUserModel : BDFBaseModel

@property (nonatomic, strong) NSString *nick;

@property (nonatomic, assign) BOOL isBindPhone;

@property (nonatomic, assign) BOOL isBan;

@property (nonatomic, assign) NSInteger attentState;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, assign) BOOL sex;

@end
