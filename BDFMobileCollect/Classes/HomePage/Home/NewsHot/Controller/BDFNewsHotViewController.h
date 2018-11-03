//
//  BDFNewsHotViewController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseViewController.h"
#import "BDFNewsHotTableView.h"
#import "BDFCustomCommonEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFNewsHotViewController : BDFBaseViewController

@property (nonatomic, strong) BDFNewsHotTableView *hotTableView;
@property (nonatomic, strong) NSMutableArray *hotNewsFrameArray;
@property (nonatomic, weak) BDFCustomCommonEmptyView *emptyView;

- (void)bdf_refresh;
- (void)bdf_loadMore;
- (void)handResponseData:(id)response;

@end

NS_ASSUME_NONNULL_END
