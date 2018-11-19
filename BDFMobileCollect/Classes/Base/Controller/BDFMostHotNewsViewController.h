//
//  BDFMostHotNewsViewController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseViewController.h"
#import "BDFHomeHeaderOptionView.h"
#import "BDFHomeSliderViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFMostHotNewsViewController : BDFBaseViewController

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) BDFHomeHeaderOptionView *optionalView;
@property (nonatomic, strong) BDFHomeSliderViewController *slideViewController;

@end

NS_ASSUME_NONNULL_END
