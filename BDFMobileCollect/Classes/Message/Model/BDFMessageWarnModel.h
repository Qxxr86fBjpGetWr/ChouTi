//
//  BDFMessageWarnModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDFMessageWarnDataModel,BDFMessageWarnDataLinksModel,BDFMessageWarnDataFromUserModel,BDFMessageWarnDataCommentsModel;

@interface BDFMessageWarnModel : BDFBaseModel

@property (nonatomic, assign) BOOL success;

@property (nonatomic, strong) NSMutableArray <BDFMessageWarnDataModel *> *data;

@property (nonatomic, assign) NSInteger code;

@end

@interface BDFMessageWarnDataModel : BDFBaseModel

@property (nonatomic, assign) NSInteger linkId;

@property (nonatomic, assign) NSInteger commentsType;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger messageId;

@property (nonatomic, strong) BDFMessageWarnDataLinksModel *links;

@property (nonatomic, assign) NSInteger commentsId;

@property (nonatomic, strong) BDFMessageWarnDataFromUserModel *fromUser;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, strong) BDFMessageWarnDataCommentsModel *parentComments;

@end

@interface BDFMessageWarnDataLinksModel : BDFBaseModel

@property (nonatomic, assign) BOOL commentHavePicture;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, assign) NSInteger action_time;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) NSInteger action;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) BOOL isTopLinks;

@property (nonatomic, strong) NSDictionary *submitted_user;

@property (nonatomic, strong) NSString *original_img_url;

@property (nonatomic, assign) BOOL has_saved;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger subject_id;

@property (nonatomic, assign) BOOL has_uped;

@property (nonatomic, assign) NSInteger pool;

@property (nonatomic, strong) NSString *originalUrl;

@property (nonatomic, strong) NSString *subjectStr;

@property (nonatomic, assign) NSInteger created_time;

@property (nonatomic, assign) NSInteger ups;

@property (nonatomic, assign) NSInteger time_into_pool;

@property (nonatomic, assign) NSInteger fetchType;

@property (nonatomic, assign) BOOL noComments;

@end

@interface BDFMessageWarnDataFromUserModel : BDFBaseModel

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

@interface BDFMessageWarnDataCommentsModel : BDFBaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) NSInteger createTime;

@end

NS_ASSUME_NONNULL_END
