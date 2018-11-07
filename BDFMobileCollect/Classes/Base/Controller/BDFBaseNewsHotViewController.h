//
//  BDFBaseNewsHotViewController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/7.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseViewController.h"
#import "BDFNewsHotTableView.h"
#import "BDFCustomCommonEmptyView.h"
#import "BDFBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SubType) {
    MOSTNEW,
    MOSTHOT,
};

@interface BDFBaseNewsHotViewController : BDFBaseViewController

@property (nonatomic, strong) BDFNewsHotTableView *hotTableView;
@property (nonatomic, strong) NSMutableArray *hotNewsFrameArray;
@property (nonatomic, weak) BDFCustomCommonEmptyView *emptyView;
@property (nonatomic, assign) SubType subType;

- (void)bdf_refresh;
- (void)bdf_loadMore;
- (void)handResponseData:(id)response;

/** 子类继承 */
- (instancetype)initWithType:(SubType)type baseUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
