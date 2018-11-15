//
//  BDFMeCommentModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFHomeHotNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BDFMeCommentsUserModel,BDFMeCommentsCommentModel;

@interface BDFMeCommentModel : BDFBaseModel

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableArray <BDFMeCommentsCommentModel *> *comments;

@end

@interface BDFMeCommentsCommentModel : BDFBaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger created_time;

@property (nonatomic, assign) NSInteger ups;

@property (nonatomic, assign) NSInteger downs;

@property (nonatomic, strong) BDFMeCommentsUserModel *user;

@property (nonatomic, assign) NSInteger link_id;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, strong) BDFHomeHotNewsModelLink *link;

@property (nonatomic, strong) NSString *link_title;

@property (nonatomic, assign) BOOL commentHavePicture;

@property (nonatomic, assign) NSInteger action;

@property (nonatomic, assign) BOOL isBanUser;

@property (nonatomic, assign) BOOL selfStatus;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger is_vote;

@property (nonatomic, strong) NSString *content;

@end

@interface BDFMeCommentsUserModel : BDFBaseModel

@property (nonatomic, assign) NSInteger liked_count;

@property (nonatomic, strong) NSString *nick;

@property (nonatomic, strong) NSString *dissentFlag;

@property (nonatomic, assign) NSInteger isBindPhone;

@property (nonatomic, assign) NSInteger submitted_count;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, assign) NSInteger attentState;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL sex;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, assign) NSInteger comments_count;

@end


NS_ASSUME_NONNULL_END
