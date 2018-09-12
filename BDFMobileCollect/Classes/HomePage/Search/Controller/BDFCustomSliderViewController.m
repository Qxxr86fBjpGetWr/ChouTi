//
//  BDFCustomSliderViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFCustomSliderViewController.h"

@interface BDFCustomSliderViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableDictionary *allDisPlayVc;

@property (nonatomic, strong) NSMutableDictionary *memoryCache;

@end

@implementation BDFCustomSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [self childViewControllersCount], SCREEN_HEIGHT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadData {
    [self.memoryCache removeAllObjects];
    [self.allDisPlayVc removeAllObjects];
    
    for (NSInteger index = 0; index < self.childViewControllers.count; index++) {
        UIViewController *viewController = self.childViewControllers[index];
        [viewController.view removeFromSuperview];
        //调用removeFromParentViewController之前必须调用willMoveToParentViewController且参数为nil
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * [self childViewControllersCount], SCREEN_HEIGHT);
    [self scrollViewDidScroll:self.scrollView];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSInteger start = (currentIndex == 0) ? currentIndex : currentIndex;
    NSInteger end = (currentIndex == [self childViewControllersCount] - 1) ? currentIndex : currentIndex;
    //获取当前控制器并显示
    for (NSInteger i = start; i <= end; i++) {
        UIViewController *vc = [self.allDisPlayVc objectForKey:@(i)];
        if (!vc) {
            [self getCurrentViewControllerWithIndex:i];
        }
    }
    //将除了当前的控制器之外的控制器都缓存起来
    for (NSInteger i = 0; i < start; i++) {
        UIViewController *vc = [self.allDisPlayVc objectForKey:@(i)];
        [self removeViewController:vc index:i];
    }
    
    for (NSInteger i = end + 1; i <= [self childViewControllersCount] + 1; i++) {
        UIViewController *vc = [self.allDisPlayVc objectForKey:@(i)];
        [self removeViewController:vc index:i];
    }
    //执行代理更新偏移量
    if ([self.delgate respondsToSelector:@selector(customSlideViewController:slideOffset:)]) {
        [self.delgate customSlideViewController:self slideOffset:scrollView.contentOffset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delgate respondsToSelector:@selector(customSlideViewController:slideIndex:)]) {
        [self.delgate customSlideViewController:self slideIndex:scrollView.contentOffset.x / SCREEN_WIDTH];
    }
}

#pragma mark - 获取当前显示的控制器
- (void)getCurrentViewControllerWithIndex:(NSInteger)index {
    //从缓存中取
    UIViewController *vc = [self.memoryCache objectForKey:@(index)];
    if (!vc) {
        //缓存中没有，从代理里面拿
        if ([self.dataSource respondsToSelector:@selector(slideViewController:viewControllerAtIndex:)]) {
            vc = [self.dataSource slideViewController:self viewControllerAtIndex:index];
            [self addChildViewController:vc index:index];
        }
    }else {
        [self addChildViewController:vc index:index];
    }
}

#pragma mark - 为当前控制器容器添加子控制器
- (void)addChildViewController:(UIViewController *)vc index:(NSInteger)index {
    if ([self.childViewControllers containsObject:vc]) {
        return;
    }
    [self addChildViewController:vc];
    [self.allDisPlayVc setObject:vc forKey:@(index)];
    [vc didMoveToParentViewController:self];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark - 移除控制器后并缓存
- (void)removeViewController:(UIViewController *)vc index:(NSInteger)index {
    
    if (!vc) {
        return;
    }
    [vc.view removeFromSuperview];
    [vc willMoveToParentViewController:self];
    [vc removeFromParentViewController];
    [self.allDisPlayVc removeObjectForKey:@(index)];
    if (![self.memoryCache objectForKey:@(index)]) {
        [self.memoryCache setObject:vc forKey:@(index)];
    }
}

#pragma mark - lazy load
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *view = [[UIScrollView alloc] init];
        view.showsHorizontalScrollIndicator = YES;
        view.showsVerticalScrollIndicator = YES;
        view.backgroundColor = kColorFromRGB(0xf5f5f5);
        view.delegate = self;
        view.scrollEnabled = self.scrollEnabled;
        view.pagingEnabled = YES;
        view.bounces = NO;
        [self.view addSubview:view];
        _scrollView = view;
    }
    return _scrollView;
}

- (NSMutableDictionary *)memoryCache {
    if (!_memoryCache) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _memoryCache = dic;
    }
    return _memoryCache;
}

- (NSMutableDictionary *)allDisPlayVc {
    if (!_allDisPlayVc) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        _allDisPlayVc = dic;
    }
    return _allDisPlayVc;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    
    _selectIndex = selectIndex;
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * selectIndex, 0)];
}

- (NSInteger)childViewControllersCount {
    if ([self.dataSource respondsToSelector:@selector(numberOfChildViewControllersInSlideViewController:)]) {
       return [self.dataSource numberOfChildViewControllersInSlideViewController:self];
    }
    return 0;
}

@end
