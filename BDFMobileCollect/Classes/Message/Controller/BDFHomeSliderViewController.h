//
//  BDFHomeSliderViewController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/1.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDFHomeSliderViewController;

@protocol BDFCustomSlideViewControllerDelegate <NSObject>
@optional
/** 滚动偏移量*/
- (void)customSlideViewController:(BDFHomeSliderViewController *)slideViewController slideOffset:(CGPoint)slideOffset;

- (void)customSlideViewController:(BDFHomeSliderViewController *)slideViewController slideIndex:(NSInteger)slideIndex;

@end

@protocol BDFCustomSlideViewControllerDataSource <NSObject>
/** 子控制器*/
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index;

/** 子控制器数量*/
- (NSInteger)numberOfChildViewControllersInSlideViewController:(BDFHomeSliderViewController *)slideViewController;

@end

@interface BDFHomeSliderViewController : UIViewController

@property (nonatomic, weak) id <BDFCustomSlideViewControllerDelegate> delgate;

@property (nonatomic, weak) id <BDFCustomSlideViewControllerDataSource> dataSource;

@property (nonatomic, assign) NSInteger seletedIndex;

@property (nonatomic, assign) BOOL scorllEnable;

- (void)reloadData;

@end
