//
//  BDFMostHotView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/2.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMostHotView.h"
#import "BDFHomeHeaderOptionView.h"
#import "BDFHomeSliderViewController.h"
#import "BDFBaseTableViewController.h"

@interface BDFMostHotView ()<BDFCustomSlideViewControllerDelegate, BDFCustomSlideViewControllerDataSource>

@property (nonatomic, strong) BDFHomeHeaderOptionView *optionalView;

@property (nonatomic, strong) BDFHomeSliderViewController *slideViewController;
@end

@implementation BDFMostHotView

- (void)layoutSubviews {
    [super layoutSubviews];
    WeakSelf(weakSelf);
    self.optionalView.titles = @[@"通知", @"提醒", @"聊天"];
    self.optionalView.homeHeaderOptionalViewItemClickHandle = ^(BDFHomeHeaderOptionView *optialView, NSString *title, NSInteger currentIndex) {
        weakSelf.slideViewController.seletedIndex = currentIndex;
    };
    [self.slideViewController reloadData];
}

#pragma mark - BDFCustomSlideViewControllerDelegate
- (void)customSlideViewController:(BDFHomeSliderViewController *)slideViewController slideIndex:(NSInteger)slideIndex {}

- (void)customSlideViewController:(BDFHomeSliderViewController *)slideViewController slideOffset:(CGPoint)slideOffset {
    self.optionalView.contentOffset = slideOffset;
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    
    if (index == 0) {
        viewController = [[BDFBaseViewController alloc] init];
    }else if (index == 1) {
        viewController = [[BDFBaseViewController alloc] init];
    } else {
        viewController = [[BDFBaseViewController alloc] init];
    }
    return viewController;
}

- (NSInteger)numberOfChildViewControllersInSlideViewController:(BDFHomeSliderViewController *)slideViewController {
    return self.optionalView.titles.count;
}

- (BDFHomeHeaderOptionView *)optionalView {
    if (!_optionalView) {
        BDFHomeHeaderOptionView *optional = [[BDFHomeHeaderOptionView alloc] init];
        optional.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        [self addSubview:optional];
        _optionalView = optional;
        optional.backgroundColor = kWhiteColor;
    }
    return _optionalView;
}

- (BDFHomeSliderViewController *)slideViewController {
    if (!_slideViewController) {
        BDFHomeSliderViewController *slide = [[BDFHomeSliderViewController alloc] init];
//        [slide willMoveToParentViewController:self];
//        [self addChildViewController:slide];
        [self addSubview:slide.view];
        slide.view.frame = CGRectMake(0, self.optionalView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.optionalView.height);
        slide.delgate = self;
        slide.dataSource = self;
        slide.scorllEnable = YES;
        _slideViewController = slide;
    }
    return _slideViewController;
}


@end
