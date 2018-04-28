//
//  BDFBaseTableViewController.h
//  
//
//  Created by 张声扬 on 2017/1/9.
//
//

#import "BDFBaseViewController.h"
#import "BDFBaseTableView.h"
#import "BDFBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, BDFBaseTableVcRefreshType) {
    /** 无法刷新*/
    BDFBaseTableVcRefreshTypeNone = 0,
    /** 只能刷新*/
    BDFBaseTableVcRefreshTypeOnlyCanRefresh,
    /** 只能上拉加载*/
    BDFBaseTableVcRefreshTypeOnlyCanLoadMore,
    /** 能刷新*/
    BDFBaseTableVcRefreshTypeRefreshAndLoadMore
};

@interface BDFBaseTableViewController : BDFBaseViewController<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_dataArray;
}

/** 刚才执行的是刷新*/
@property (nonatomic, assign) NSInteger isRefresh;

/** 刚才执行的是上拉加载*/
@property (nonatomic, assign) NSInteger isLoadMore;

/** 隐藏statusBar*/
@property (nonatomic, assign) BOOL hiddenStatusBar;

/** statusBar风格*/
@property (nonatomic, assign) UIStatusBarStyle barStyle;

/** 导航右边Item*/
@property (nonatomic, strong) UIBarButtonItem *navRightItem;

/** 导航左边Item*/
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;

/** 标题*/
@property (nonatomic, copy) NSString *navItemTitle;

/** 表视图*/
@property (nonatomic, weak) BDFBaseTableView *tableView;

/** 表视图偏移*/
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 数据源数量*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 加载刷新类型*/
@property (nonatomic, assign) BDFBaseTableVcRefreshType refreshType;

/** 是否需要系统的cell的分割线*/
@property (nonatomic, assign) BOOL needCellSepLine;

/** 是否在下拉刷新*/
@property (nonatomic, assign, readonly) BOOL isHeaderRefreshing;

/** 是否在上拉加载*/
@property (nonatomic, assign, readonly) BOOL isFooterRefreshing;

@property (nonatomic, assign) BOOL showRefreshIcon;

@property (nonatomic, weak, readonly) UIView *refreshHeader;


/** 添加空界面文字*/
- (void)bdf_addEmptyPageWithText:(NSString *)text;

/** 设置导航栏右边的item*/
- (void)bdf_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 设置导航栏左边的item*/
- (void)bdf_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 监听通知*/
- (void)bdf_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action;

/** 刷新数据*/
- (void)bdf_reloadData;

/** 开始下拉*/
- (void)bdf_beginRefresh;

/** 停止刷新*/
- (void)bdf_endRefresh;

/** 停止上拉加载*/
- (void)bdf_endLoadMore;

/** 隐藏刷新*/
- (void)bdf_hiddenRrefresh;

/** 隐藏上拉加载*/
- (void)bdf_hiddenLoadMore;

/** 提示没有更多信息*/
- (void)bdf_noticeNoMoreData;

/** 配置数据*/
- (void)bdf_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass;

/** 配置数据*/
- (void)bdf_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText;

#pragma mark - 子类去重写
/** 分组数量*/
- (NSInteger)bdf_numberOfSections;

/** 某个分组的cell数量*/
- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section;

/** 某行的cell*/
- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 点击某行*/
- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell;

/** 某行行高*/
- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath;

/** 某个组头*/
- (UIView *)bdf_headerAtSection:(NSInteger)section;

/** 某个组尾*/
- (UIView *)bdf_footerAtSection:(NSInteger)section;

/** 某个组头高度*/
- (CGFloat)bdf_sectionHeaderHeightAtSection:(NSInteger)section;

/** 某个组尾高度*/
- (CGFloat)bdf_sectionFooterHeightAtSection:(NSInteger)section;

/** 分割线偏移*/
- (UIEdgeInsets)bdf_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类去继承
/** 刷新方法*/
- (void)bdf_refresh;

/** 上拉加载方法*/
- (void)bdf_loadMore;

- (void)endRefreshIconAnimation;

#pragma mark - loading & alert
- (void)bdf_showLoading;

- (void)bdf_hiddenLoading;

- (void)bdf_showTitle:(NSString *)title after:(NSTimeInterval)after;

@end
