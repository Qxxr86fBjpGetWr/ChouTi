//
//  BDFBaseTableViewController.m
//  
//
//  Created by 张声扬 on 2017/1/9.
//
//

#import "BDFBaseTableViewController.h"
#import "BDFUntil.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"
#import "BDFTableViewHeaderFooterView.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <objc/runtime.h>

const char BDFBaseTableVcNavRightItemHandleKey;
const char BDFBaseTableVcNavLeftItemHandleKey;

@interface BDFBaseTableViewController ()

@property (nonatomic, weak) UIImageView *refreshImg;

@end

@implementation BDFBaseTableViewController

@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize navItemTitle = _navItemTitle;
@synthesize navRightItem = _navRightItem;
@synthesize navLeftItem = _navLeftItem;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

/**
 *  加载tableview
 */
- (BDFBaseTableView *)tableView {
    if(!_tableView){
        BDFBaseTableView *tab = [[BDFBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.separatorColor = [UIColor blackColor];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;  
}

#pragma mark - loading & alert
- (void)bdf_showLoading {
    //    [FMHUD showLoading];
}

- (void)bdf_hiddenLoading {
    //    [FMHUD hideHUD];
}

- (void)bdf_showTitle:(NSString *)title after:(NSTimeInterval)after {
    //    [FDHUD showTitle:title];
    //    [FDHUD hideHUDAfterTimeout:after];
}

/** 添加空界面文字*/
- (void)bdf_addEmptyPageWithText:(NSString *)text {
    //    [[bdfEmptyPageManager sharedManager] setDelegateForScrollView:self.tableView emptyText:text];
}

/** 设置导航栏右边的item*/
- (void)bdf_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle {
    [self bdf_setUpNavItemTitle:itemTitle handle:handle leftFlag:NO];
}

/** 设置导航栏左边的item*/
- (void)bdf_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *leftItemTitle))handle {
    [self bdf_setUpNavItemTitle:itemTitle handle:handle leftFlag:YES];
}

- (void)bdf_setUpNavItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *itemTitle))handle leftFlag:(BOOL)leftFlag {
    if (itemTitle.length == 0 || !handle) {
        if (itemTitle == nil) {
            itemTitle = @"";
        } else if ([itemTitle isKindOfClass:[NSNull class]]) {
            itemTitle = @"";
        }
        if (leftFlag) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        }
    } else {
        if (leftFlag) {
            objc_setAssociatedObject(self, &BDFBaseTableVcNavLeftItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(bdf_navItemHandle:)];
        } else {
            objc_setAssociatedObject(self, &BDFBaseTableVcNavRightItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(bdf_navItemHandle:)];
        }
    }
}

- (void)bdf_navItemHandle:(UIBarButtonItem *)item {
    void (^handle)(NSString *) = objc_getAssociatedObject(self, &BDFBaseTableVcNavRightItemHandleKey);
    if (handle) {
        handle(item.title);
    }
}

/** 监听通知*/
- (void)bdf_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:notiName object:nil];
}

/** 设置刷新类型*/
- (void)setRefreshType:(BDFBaseTableVcRefreshType)refreshType {
    _refreshType = refreshType;
    switch (refreshType) {
        case BDFBaseTableVcRefreshTypeNone: // 没有刷新
            break ;
        case BDFBaseTableVcRefreshTypeOnlyCanRefresh: { // 只有下拉刷新
            [self bdf_addRefresh];
        } break ;
        case BDFBaseTableVcRefreshTypeOnlyCanLoadMore: { // 只有上拉加载
            [self bdf_addLoadMore];
        } break ;
        case BDFBaseTableVcRefreshTypeRefreshAndLoadMore: { // 下拉和上拉都有
            [self bdf_addRefresh];
            [self bdf_addLoadMore];
        } break ;
        default:
            break ;
    }
}

-(void)bdf_addRefresh {
    [BDFUntil addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self bdf_refresh];
    }];
}

-(void)bdf_addLoadMore {
    [BDFUntil addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self bdf_loadMore];
    }];
}

- (NSString *)navItemTitle {
    return self.navigationItem.title;
}

/** 导航栏标题*/
- (void)setNavItemTitle:(NSString *)navItemTitle {
    if ([navItemTitle isKindOfClass:[NSString class]] == NO) return ;
    if ([navItemTitle isEqualToString:_navItemTitle]) return ;
    _navItemTitle = navItemTitle.copy;
    self.navigationItem.title = navItemTitle;
}

/** statusBar是否隐藏*/
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)hiddenStatusBar {
    return _hiddenStatusBar;
}

- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    if (_barStyle == barStyle) return ;
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

- (void)setShowRefreshIcon:(BOOL)showRefreshIcon {
    _showRefreshIcon = showRefreshIcon;
    self.refreshImg.hidden = !showRefreshIcon;
}

- (UIImageView *)refreshImg {
    if (!_refreshImg) {
        UIImageView *refreshImg = [[UIImageView alloc] init];
        [self.view addSubview:refreshImg];
        _refreshImg = refreshImg;
        [self.view bringSubviewToFront:refreshImg];
        refreshImg.image = [UIImage imageNamed:@"refresh"];
        WeakSelf(weakSelf);
        [refreshImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_offset(-20);
        }];
//        refreshImg.layerCornerRadius = 22;
        refreshImg.backgroundColor = kWhiteColor;
        
        [refreshImg setTapActionWithBlock:^{
            [self startAnimation];
            [weakSelf bdf_beginRefresh];
        }];
    }
    return _refreshImg;
}

- (void)startAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.refreshImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)endRefreshIconAnimation {
    [self.refreshImg.layer removeAnimationForKey:@"rotationAnimation"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}

/** 右边item*/
- (void)setNavRightItem:(UIBarButtonItem *)navRightItem {
    
    _navRightItem = navRightItem;
    self.navigationItem.rightBarButtonItem = navRightItem;
}

- (UIBarButtonItem *)navRightItem {
    return self.navigationItem.rightBarButtonItem;
}
/** 左边item*/
- (void)setNavLeftItem:(UIBarButtonItem *)navLeftItem {
    
    _navLeftItem = navLeftItem;
    self.navigationItem.leftBarButtonItem = navLeftItem;
}

- (UIBarButtonItem *)navLeftItem {
    return self.navigationItem.leftBarButtonItem;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}

/** 需要系统分割线*/
- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}

/** 分割线颜色*/
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) return;
    self.sepLineColor = sepLineColor;
    
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

- (UIColor *)sepLineColor {
    return self.sepLineColor ? self.sepLineColor : [UIColor whiteColor];
}

/** 刷新数据*/
- (void)bdf_reloadData {
    [self.tableView reloadData];
}

/** 开始下拉*/
- (void)bdf_beginRefresh {
    if (self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == BDFBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [BDFUntil beginPullRefreshForScrollView:self.tableView];
    }
}

/** 刷新*/
- (void)bdf_refresh {
    if (self.refreshType == BDFBaseTableVcRefreshTypeNone || self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanLoadMore) {
        return ;
    }
    self.isRefresh = YES; self.isLoadMore = NO;
}

/** 上拉加载*/
- (void)bdf_loadMore {
    if (self.refreshType == BDFBaseTableVcRefreshTypeNone || self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanRefresh) {
        return ;
    }
    if (self.dataArray.count == 0) {
        return ;
    }
    self.isRefresh = NO; self.isLoadMore = YES;
    
}

- (void)bdf_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass {
    [self bdf_commonConfigResponseWithResponse:response isRefresh:isRefresh modelClass:modelClass emptyText:nil];
}

- (void)bdf_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText {
    if ([response isKindOfClass:[NSArray class]] == NO) return ;
    if (self.isRefresh) { // 刷新
        
        // 停止刷新
        [self bdf_endRefresh];
        
        // 设置模型数组
        [self.dataArray removeAllObjects];
        self.dataArray = [modelClass mj_objectArrayWithKeyValuesArray:response];
        
        // 设置空界面占位文字
        if (emptyText.length) {
            [self bdf_addEmptyPageWithText:emptyText];
        }
        
        // 刷新界面
        [self bdf_reloadData];
        
    } else { // 上拉加载
        
        // 停止上拉
        [self bdf_endLoadMore];
        
        // 没有数据提示没有更多了
        if ([response count] == 0) {
            [self bdf_noticeNoMoreData];
        } else {
            
            // 设置模型数组
            NSArray *newModels = [modelClass mj_objectArrayWithKeyValuesArray:response];
            if (newModels.count < 50) {
                [self bdf_hiddenLoadMore];
            }
            [self.dataArray addObjectsFromArray:newModels];
            
            // 刷新界面
            [self bdf_reloadData];
        }
    }
}

/** 停止刷新*/
- (void)bdf_endRefresh {
    if (self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == BDFBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [BDFUntil endRefreshForScrollView:self.tableView];
    }
}

/** 停止上拉加载*/
- (void)bdf_endLoadMore {
    if (self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == BDFBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [BDFUntil endLoadMoreForScrollView:self.tableView];
    }
}

/** 隐藏刷新*/
- (void)bdf_hiddenRrefresh {
    if (self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == BDFBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [BDFUntil hiddenHeaderForScrollView:self.tableView];
    }
}

/** 隐藏上拉加载*/
- (void)bdf_hiddenLoadMore {
    if (self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType ==BDFBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [BDFUntil hiddenFooterForScrollView:self.tableView];
    }
}

/** 提示没有更多信息*/
- (void)bdf_noticeNoMoreData {
    if (self.refreshType == BDFBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == BDFBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [BDFUntil noticeNoMoreDataForScrollView:self.tableView];
    }
}

/** 头部正在刷新*/
- (BOOL)isHeaderRefreshing {
    return [BDFUntil headerIsRefreshForScrollView:self.tableView];
}

//* 尾部正在刷新
- (BOOL)isFooterRefreshing {
    return [BDFUntil footerIsLoadingForScrollView:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(bdf_numberOfSections)]) {
        return self.bdf_numberOfSections;
    }
    return 0;
}

// 指定组返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(bdf_numberOfRowsInSection:)]) {
        return [self bdf_numberOfRowsInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(bdf_headerAtSection:)]) {
        return [self bdf_headerAtSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(bdf_footerAtSection:)]) {
        return [self bdf_footerAtSection:section];
    }
    return nil;
}

// 每一行返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self respondsToSelector:@selector(bdf_cellAtIndexPath:)]) {
        return [self bdf_cellAtIndexPath:indexPath];
    }
    // 1. 创建cell
    BDFBaseTableViewCell *cell = [BDFBaseTableViewCell cellWithTableView:self.tableView];
    
    // 2. 返回cell
    return cell;
}

// 点击某一行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BDFBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(bdf_didSelectCellAtIndexPath:cell:)]) {
        [self bdf_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

- (UIView *)refreshHeader {
    return self.tableView.mj_header;
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellSepLine) return ;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(bdf_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self bdf_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
}

// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(bdf_cellheightAtIndexPath:)]) {
        return [self bdf_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(bdf_sectionHeaderHeightAtSection:)]) {
        return [self bdf_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(bdf_sectionFooterHeightAtSection:)]) {
        return [self bdf_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}

- (NSInteger)bdf_numberOfSections { return 0; }

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section { return 0; }

- (UITableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath { return [BDFBaseTableViewCell cellWithTableView:self.tableView]; }

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath { return 50; }

- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell { }

- (UIView *)bdf_headerAtSection:(NSInteger)section { return [BDFTableViewHeaderFooterView headerFooterViewWithTableView:self.tableView]; }

- (UIView *)bdf_footerAtSection:(NSInteger)section { return [BDFTableViewHeaderFooterView headerFooterViewWithTableView:self.tableView]; }

- (CGFloat)bdf_sectionHeaderHeightAtSection:(NSInteger)section { return 0.01; }

- (CGFloat)bdf_sectionFooterHeightAtSection:(NSInteger)section { return 0.01; }

- (UIEdgeInsets)bdf_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath { return UIEdgeInsetsMake(0, 15, 0, 0); }

- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }


@end
