//
//  BDFUntil.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFUntil.h"
#import "BDFRefreshFooter.h"
#import <MJRefresh.h>
#import "BDFRefreshNormalHeader.h"

@interface BDFUntil ()<BDFRefreshNormalHeaderDelegate>

@end

@implementation BDFUntil

/**下拉*/
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock {
    __weak typeof(UIScrollView *)weakScrollView = scrollView;
    if (scrollView == nil || pullRefreshCallBackBlock == nil) {
        return ;
    }
    BDFRefreshNormalHeader *header = [BDFRefreshNormalHeader headerWithRefreshingBlock:^{
        if (pullRefreshCallBackBlock) {
            pullRefreshCallBackBlock();
        }
        if (weakScrollView.mj_footer.hidden == NO) {
            [weakScrollView.mj_footer resetNoMoreData];
        }
    }];
    header.backgroundColor = [UIColor grayColor];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    scrollView.mj_header = header;
}

/**上拉*/
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock {
    
    if (scrollView == nil || loadMoreCallBackBlock == nil) {
        return ;
    }
    BDFRefreshFooter *footer = [BDFRefreshFooter footerWithRefreshingBlock:^{
        if (loadMoreCallBackBlock) {
            loadMoreCallBackBlock();
        }
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在为您加载数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = kRGBColor(90, 90, 90);
    footer.stateLabel.font = kFont(13.0);
    //    footer.automaticallyHidden = YES;
    scrollView.mj_footer = footer;
    footer.backgroundColor = kClearColor;
}

/** 开始下拉刷新*/
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header beginRefreshing];
}

/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}

/**停止上拉加载*/
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshing];
}

/** 隐藏footer*/
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView {
    // 不确定是哪个类型的footer
    scrollView.mj_footer.hidden = YES;
}

/**隐藏header*/
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_header.hidden = YES;
}

/**提示没有更多数据的情况*/
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**判断头部是否在刷新*/
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView {
    
    BOOL flag =  scrollView.mj_header.isRefreshing;
    return flag;
}

/**判断是否尾部在刷新*/
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView {
    return  scrollView.mj_footer.isRefreshing;
}

+ (NSString *) compareCurrentTime:(NSString *)str
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

//时间戳——字符串时间
+(NSString *)cStringFromTimestamp:(NSString *)timestamp{
    
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

-(void)refreshCompleWithOffset:(UIScrollView *)scrollView {
    scrollView.mj_offsetY = 100;
}

@end
