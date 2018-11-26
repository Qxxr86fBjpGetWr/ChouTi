//
//  BDFSystemMessageModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDFSystemMessageNoticeModel,BDFSystemMessageNoticeUserModel;

@interface BDFSystemMessageModel : BDFBaseModel
@property (nonatomic, strong) NSMutableArray <BDFSystemMessageNoticeModel *> *notice;
@end

@interface BDFSystemMessageNoticeModel : BDFBaseModel

@property (nonatomic, assign) NSInteger action;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger imgUrlType;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) BDFSystemMessageNoticeUserModel *adviceUser;

@property (nonatomic, strong) NSString *destJid;

@property (nonatomic, assign) NSInteger actionTime;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, strong) NSString *fromJid;

@end

@interface BDFSystemMessageNoticeUserModel : BDFBaseModel

@property (nonatomic, assign) NSInteger attentState;

@property (nonatomic, assign) NSInteger isBindPhone;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, assign) BOOL blackUser;

@property (nonatomic, assign) BOOL sex;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) NSInteger submitted_count;

@property (nonatomic, strong) NSString *proveName;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger ct;

@property (nonatomic, strong) NSString *sign;

@property (nonatomic, strong) NSString *nick;

@property (nonatomic, strong) NSString *dissentFlag;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, assign) BOOL audit;

@property (nonatomic, assign) BOOL commentLimit;

@property (nonatomic, assign) NSInteger liked_count;

@property (nonatomic, strong) NSString *strtmp1;

@property (nonatomic, assign) NSInteger banedRemainTime;

@property (nonatomic, strong) NSString *cityName;

@end

NS_ASSUME_NONNULL_END
