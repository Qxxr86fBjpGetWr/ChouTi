//
//  BDFSubMostHotNewsViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/7.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFSubMostHotNewsViewController.h"
#import "BDFMostHotNewsSubController.h"

@interface BDFSubMostHotNewsViewController ()

@end

@implementation BDFSubMostHotNewsViewController

- (void)viewDidLoad {
    self.titles = @[@"24小时",@"三天",@"一周",];
    [super viewDidLoad];
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    
    if (index == 0) {
        viewController = [[BDFMostHotNewsSubController alloc] initWithLimit:@"24hr"];
    }else if (index == 1) {
        viewController = [[BDFMostHotNewsSubController alloc] initWithLimit:@"72hr"];
    } else {
        viewController = [[BDFMostHotNewsSubController alloc] initWithLimit:@"168hr"];
    }
    return viewController;
}

@end
