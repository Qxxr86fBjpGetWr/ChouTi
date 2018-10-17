//
//  BDFMeDataModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"

@interface BDFMeDataModel : BDFBaseModel

@property (nonatomic, strong) NSString *meCellTitle;
@property (nonatomic, strong) NSString *meCellIcon;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *action;

@end
