//
//  BDFHomeSliderViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/1.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFHomeSliderViewController.h"

@interface BDFHomeSliderViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *displayVcs;
@property (nonatomic, strong) NSMutableDictionary *memoryCache;
@property (nonatomic, weak) UIViewController *currentViewController;

@end

@implementation BDFHomeSliderViewController

- (NSMutableDictionary *)displayVcs {
    if (!_displayVcs) {
        _displayVcs = [[NSMutableDictionary alloc] init];
    }
    return _displayVcs;
}

- (NSMutableDictionary *)memoryCache {
    if (!_memoryCache) {
        _memoryCache = [[NSMutableDictionary alloc] init];
    }
    return _memoryCache;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scroll = [[UIScrollView alloc] init];
        [self.view addSubview:scroll];
        _scrollView = scroll;
        scroll.delegate = self;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.pagingEnabled = YES;
        scroll.bounces = NO;
        scroll.scrollEnabled = self.scorllEnable;
    }
    return _scrollView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * [self childViewControllerCount], self.scrollView.frame.size.height);
}

- (void)setSeletedIndex:(NSInteger)seletedIndex {
    _seletedIndex = seletedIndex;
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * seletedIndex, 0) animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)reloadData {
    
    [self.memoryCache removeAllObjects];
    [self.displayVcs removeAllObjects];
    
    for (NSInteger index = 0; index < self.childViewControllers.count; index++) {
        UIViewController *viewController = self.childViewControllers[index];
        [viewController.view removeFromSuperview];
        //调用removeFromParentViewController之前必须调用willMoveToParentViewController且参数为nil
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * [self childViewControllerCount], self.scrollView.frame.size.height);
    [self scrollViewDidScroll:self.scrollView];
}
// 添加控制器
- (void)addChildViewController:(UIViewController *)childController atIndex:(NSInteger)index {
    
    if ([self.childViewControllers containsObject:childController]) {
        return ;
    }
    
    // 添加控制器 并放入正在展示的控制器中
    [self addChildViewController:childController];
    [self.displayVcs setObject:childController forKey:@(index)];
    [childController didMoveToParentViewController:self];
    [self.scrollView addSubview:childController.view];
    childController.view.frame = CGRectMake(index * [UIScreen mainScreen].bounds.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
}

// 移除控制器
- (void)removeChildViewController:(UIViewController *)childController atIndex:(NSInteger)index {
    
    if (childController == nil) {
        return ;
    }
    // 当前显示删除、放入缓存中
    [childController.view removeFromSuperview];
    [childController willMoveToParentViewController:nil];
    [childController removeFromParentViewController];
    
    [self.displayVcs removeObjectForKey:@(index)];
    if (![self.memoryCache objectForKey:@(index)]) {
        [self.memoryCache setObject:childController forKey:@(index)];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
    
    //    NSInteger start = currentPage == 0 ? currentPage : (currentPage + 1);
    //    NSInteger end = (currentPage == [self childViewControllerCount] - 1) ? currentPage : (currentPage);
    // 防止控制器切换的时候视频还在播放
    NSInteger start = currentPage == 0 ? currentPage : (currentPage);
    NSInteger end = (currentPage == [self childViewControllerCount] - 1) ? currentPage : (currentPage);
    
    for (NSInteger index = start; index <= end; index++) {
        UIViewController *viewController = [self.displayVcs objectForKey:@(index)];
        if (viewController == nil) {
            // 获取当前控制器
            [self initializedViewControllerAtIndex:index];
        }
    }
    
    // 将start之前和end之后的放入缓存中
    for (NSInteger index = 0; index <= start - 1; index++) {
        UIViewController *viewController = [self.displayVcs objectForKey:@(index)];
        [self removeChildViewController:viewController atIndex:index];
    }
    
    for (NSInteger index = end + 1; index <= [self childViewControllerCount] - 1; index++) {
        UIViewController *viewController = [self.displayVcs objectForKey:@(index)];
        [self removeChildViewController:viewController atIndex:index];
    }
    
    if ([self.delgate respondsToSelector:@selector(customSlideViewController:slideOffset:)]) {
        [self.delgate customSlideViewController:self slideOffset:scrollView.contentOffset];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delgate respondsToSelector:@selector(customSlideViewController:slideIndex:)]) {
        [self.delgate customSlideViewController:self slideIndex:scrollView.contentOffset.x / SCREEN_WIDTH];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delgate respondsToSelector:@selector(customSlideViewController:slideOffset:)]) {
        [self.delgate customSlideViewController:self slideOffset:scrollView.contentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delgate respondsToSelector:@selector(customSlideViewController:slideOffset:)]) {
        [self.delgate customSlideViewController:self slideOffset:scrollView.contentOffset];
    }
}

// 获取当前控制器
// 1. 从缓存中
// 2. 从代理中获取并且放入缓存中
- (void)initializedViewControllerAtIndex:(NSInteger)index {
    // 从缓存中取出控制器
    UIViewController *viewController = [self.memoryCache objectForKey:@(index)];
    if (viewController == nil) {
        if ([self.dataSource respondsToSelector:@selector(slideViewController:viewControllerAtIndex:)]) {
            UIViewController *viewController = [self.dataSource slideViewController:self viewControllerAtIndex:index];
            [self addChildViewController:viewController atIndex:index];
        }
    } else {
        [self addChildViewController:viewController atIndex:index];
    }
}

- (NSInteger)childViewControllerCount {
    if ([self.dataSource respondsToSelector:@selector(numberOfChildViewControllersInSlideViewController:)]) {
        return [self.dataSource numberOfChildViewControllersInSlideViewController:self];
    }
    return 0;
}


@end
