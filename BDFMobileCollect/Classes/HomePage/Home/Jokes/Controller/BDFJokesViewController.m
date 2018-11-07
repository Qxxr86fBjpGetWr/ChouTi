//
//  BDFJokesViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/7.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFJokesViewController.h"
#import "BDFSubJokesViewController.h"

@interface BDFJokesViewController ()

@end

@implementation BDFJokesViewController

- (void)viewDidLoad {
    self.titles = @[@"最热",@"最新"];
    [super viewDidLoad];
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    if (index == 0) {
        viewController = [[BDFSubJokesViewController alloc] initWithType:MOSTHOT baseUrl:BDFHOMECATEGORYSCOFF];
    } else {
         viewController = [[BDFSubJokesViewController alloc] initWithType:MOSTNEW baseUrl:BDFHOMECATEGORYSCOFF];
    }
    return viewController;
}

@end
