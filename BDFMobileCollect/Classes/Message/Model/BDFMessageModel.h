//
//  BDFMessageModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import <MJExtension.h>

@class BDFMessageStatusModel, BDFMessageDataModel;

@interface BDFMessageModel : BDFBaseModel

@property (nonatomic, strong) BDFMessageStatusModel *status;

@property (nonatomic, strong) NSMutableArray <BDFMessageDataModel *>*data;

@end

@interface BDFMessageDataModel : BDFBaseModel

@property (nonatomic, strong) NSString *urlbase;

@property (nonatomic, strong) NSString *continent;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *country;

@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, assign) NSInteger downloads;

@property (nonatomic, strong) NSString *startdate;

@property (nonatomic, strong) NSString *original_pic;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *attribute;

@property (nonatomic, strong) NSString *hsh;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *thumbnail_pic;

@property (nonatomic, strong) NSString *enddate;

@property (nonatomic, strong) NSString *bmiddle_pic;

@property (nonatomic, assign) NSInteger views;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *fullstartdate;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *copyrightlink;

@property (nonatomic, strong) NSString *qiniu_url;

@property (nonatomic, assign) NSInteger weibo;

@property (nonatomic, strong) NSString *copyright;

@property (nonatomic, strong) NSString *desc;

@end

@interface BDFMessageStatusModel : BDFBaseModel

@property (nonatomic, strong) NSString *message;

@property (nonatomic, assign) NSInteger code;

@end
