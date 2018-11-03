//
//  BDFNewsHotTableView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/2.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BDFNewsHotTableViewDelegate <NSObject>

@end

@interface BDFNewsHotTableView : BDFBaseTableView
@property (nonatomic, strong) NSMutableArray *hotNewsFrameArray;

- (instancetype) init __attribute__((unavailable("call initWithFrame:(CGRect)frame withDelegateVc")));
- (instancetype) initWithFrame __attribute__((unavailable("call initWithFrame:(CGRect)frame withDelegateVc")));
- (instancetype)initWithFrame:(CGRect)frame withDelegateVc:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
