//
//  BDFBaseViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/6.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseViewController.h"
#import "NSNotificationCenter+Addition.h"
#import "YYWebImageManager.h"
#import "YYDiskCache.h"
#import "YYMemoryCache.h"
#import <AFNetworking.h>
#import <SDImageCache.h>

@interface BDFBaseViewController ()

@end

@implementation BDFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView setAnimationsEnabled:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:BDFRequestSuccessNotification];
}

- (void)requestSuccessNotification {
    [self hideLoadingAnimation];
}

- (void)hideLoadingAnimation {
//    [_animationView dismiss];
//    _animationView = nil;
}

- (void)showLoadingAnimation {
//    NHCustomLoadingAnimationView *animation = [[NHCustomLoadingAnimationView alloc] init];
//    [animation showInView:self.view];
//    _animationView = animation;
//    [self.view bringSubviewToFront:animation];
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

-(BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(void)loadData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
