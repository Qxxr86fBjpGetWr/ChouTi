//
//  BDFCustomSliderViewController.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDFCustomSliderViewController;

@protocol BDFCustomSlideViewControllerDelegate <NSObject>
/** 滚动偏移量*/
- (void)customSlideViewController:(BDFCustomSliderViewController *)slideViewController slideOffset:(CGPoint)slideOffset;

- (void)customSlideViewController:(BDFCustomSliderViewController *)slideViewController slideIndex:(NSInteger)slideIndex;
@end

@protocol BDFCustomSlideViewControllerDataSource <NSObject>
/** 子控制器*/
- (UIViewController *)slideViewController:(BDFCustomSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index;

/** 子控制器数量*/
- (NSInteger)numberOfChildViewControllersInSlideViewController:(BDFCustomSliderViewController *)slideViewController;

@end


@interface BDFCustomSliderViewController : UIViewController

@property (nonatomic, weak) id <BDFCustomSlideViewControllerDelegate> delgate;
@property (nonatomic, weak) id <BDFCustomSlideViewControllerDataSource> dataSource;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL scrollEnabled;

- (void)reloadData;

@end
