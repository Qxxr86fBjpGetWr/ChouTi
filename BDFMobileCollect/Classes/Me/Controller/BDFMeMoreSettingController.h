//
//  BDFMeMoreSettingController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BDFMeMoreSettingDelegate <NSObject>

- (void)didLoginOut;

@end

@class BDFMeMoreSettingDelegate;
@interface BDFMeMoreSettingController : BDFBaseTableViewController

@property (nonatomic, weak) id <BDFMeMoreSettingDelegate> moreDelegate;

@end

NS_ASSUME_NONNULL_END
