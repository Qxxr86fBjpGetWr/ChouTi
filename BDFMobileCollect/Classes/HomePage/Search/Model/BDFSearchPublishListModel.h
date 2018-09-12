//
//  BDFSearchPublishListModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/9.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFHomeHotNewsModel.h"

@interface BDFSearchPublishListModel : BDFBaseModel

@property (nonatomic, strong) NSArray <BDFHomeHotNewsModelLink *>*linksList;

@property (nonatomic, strong) NSString *destJid;

@property (nonatomic, assign) NSInteger linksItems;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger page;

@end
