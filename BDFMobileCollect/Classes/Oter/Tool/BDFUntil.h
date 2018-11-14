//
//  BDFUntil.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XRRefreshAndLoadMoreHandle)(void);

@interface BDFUntil : NSObject

+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock;

+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock;

+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;

+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;

+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;

+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;

+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;

+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**判断头部是否在刷新*/
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;

/**判断是否尾部在刷新*/
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView;

/**
 多久之前
 */
+ (NSString *) compareCurrentTime:(NSString *)str;

/**
 时间戳——字符串时间
 */
+ (NSString *)cStringFromTimestamp:(NSString *)timestamp;

/**
注册年限
 */
+ (NSString *)registerYearsWithTime:(NSInteger)time;

/**
把文本转化为需要显示的富文本
 */
+ (NSAttributedString *)handAttributeWithText:(NSString *)text;

@end
