//
//  BDFLoginSucModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

@interface BDFLoginSucModel : BDFBaseModel

@property (nonatomic, assign) NSInteger attentState;

@property (nonatomic, assign) NSInteger serverTime;

@property (nonatomic, assign) NSInteger isBindPhone;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, assign) BOOL blackUser;

@property (nonatomic, assign) BOOL sex;

@property (nonatomic, assign) NSInteger fansCount;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) NSInteger submitted_count;

@property (nonatomic, strong) NSString *proveName;

@property (nonatomic, strong) NSString *jid;

@property (nonatomic, assign) NSInteger ct;

@property (nonatomic, assign) NSInteger selfCommentsCount;

@property (nonatomic, strong) NSString *sign;

@property (nonatomic, strong) NSString *nick;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, assign) NSInteger save_count;

@property (nonatomic, assign) NSInteger liked_count;

@property (nonatomic, assign) NSInteger followCount;

@property (nonatomic, assign) NSInteger banedRemainTime;

@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, assign) BOOL isBan;

@end
