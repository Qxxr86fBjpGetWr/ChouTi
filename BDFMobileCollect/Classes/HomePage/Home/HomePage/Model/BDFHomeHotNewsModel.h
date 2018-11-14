//
//  BDFHomeHotNewsModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

@class BDFHomeHotNewsModelLink,BDFHomeHotNewsModelLinkUser;

@interface BDFHomeHotNewsModel : BDFBaseModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray <BDFHomeHotNewsModelLink *>*links;

@end

@interface BDFHomeHotNewsModelLink : BDFBaseModel

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger ups;

@property (nonatomic, assign) BOOL is_top;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) BOOL is_break;

@property (nonatomic, assign) NSInteger inttmp3;

@property (nonatomic, strong) NSString *expireTopicTime;

@property (nonatomic, assign) BOOL hot;

@property (nonatomic, assign) NSInteger createtime;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) BOOL has_uped;

@property (nonatomic, assign) NSInteger tech_score;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) NSString *operator;

@property (nonatomic, assign) NSInteger operateTime;

@property (nonatomic, strong) NSString *expireTime;

@property (nonatomic, assign) NSInteger pool;

@property (nonatomic, assign) BOOL isTopLinks;

@property (nonatomic, strong) NSString *originalUrl;

@property (nonatomic, assign) BOOL isLocalSite;

@property (nonatomic, assign) NSInteger upsWithWeight;

@property (nonatomic, assign) NSInteger action_time;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) BOOL isYellow;

@property (nonatomic, assign) BOOL closeIp;

@property (nonatomic, assign) BOOL likedStatus;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *domain;

@property (nonatomic, assign) NSInteger shareCount;

@property (nonatomic, assign) BOOL hasFlash;

@property (nonatomic, strong) BDFHomeHotNewsModelLinkUser *submitted_user;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isTopicTopLinks;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, assign) NSInteger fetchType;

@property (nonatomic, assign) BOOL dislikedStatus;

@property (nonatomic, strong) NSString *original_img_url;

@property (nonatomic, assign) BOOL urlImage;

@property (nonatomic, assign) NSInteger action;

@property (nonatomic, assign) NSInteger created_time;

@property (nonatomic, assign) BOOL has_saved;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, assign) BOOL manSetImg;

@property (nonatomic, assign) BOOL noComments;

@property (nonatomic, assign) NSInteger subject_id;

@property (nonatomic, assign) NSInteger time_into_pool;

@property (nonatomic, assign) BOOL isBanUser;

@property (nonatomic, assign) NSInteger topicId;

@property (nonatomic, strong) NSString *topicName;

@property (nonatomic, strong) NSArray *multigraphList;

@property (nonatomic, strong) NSString *videoUrl;

@property (nonatomic, assign) NSInteger videoSize;

@property (nonatomic, assign) NSInteger videoDuration;

@property (nonatomic, strong) NSString *videoSourceType;

@property (nonatomic, assign) BOOL commentHavePicture;

@end

@interface BDFHomeHotNewsModelLinkUser : BDFBaseModel

@property (nonatomic, assign) BOOL sex;

@property (nonatomic, strong) NSString *nick;

@property (nonatomic, assign) BOOL isBindPhone;

@property (nonatomic, assign) NSInteger submitted_count;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) NSInteger liked_count;

@property (nonatomic, assign) NSInteger save_count;

@end
