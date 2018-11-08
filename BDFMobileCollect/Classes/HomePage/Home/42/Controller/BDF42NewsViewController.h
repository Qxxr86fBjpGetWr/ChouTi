//
//  BDF42NewsViewController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFNewsHotViewController.h"
#import "BDF42NewsMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDF42NewsViewController : BDFNewsHotViewController

- (instancetype)initWithBaseUrl:(NSString *)baseUrl withModel:(BDF42NewsMenuRespModel *)model;

@end

NS_ASSUME_NONNULL_END
