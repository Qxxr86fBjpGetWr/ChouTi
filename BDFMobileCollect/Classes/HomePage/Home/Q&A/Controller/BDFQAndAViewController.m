//
//  BDFQAndAViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/7.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFQAndAViewController.h"
#import "BDFBaseNewsHotViewController.h"

@interface BDFQAndAViewController ()

@end

@implementation BDFQAndAViewController

- (void)viewDidLoad {
    
    /**
     你问我答 最热
     https://api.chouti.com/v2/r/ask.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     你问我答 最热 加载更多
     https://api.chouti.com/v2/r/ask.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&after_score=9048.409331805916736&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     你问我答 最新
     https://api.chouti.com/v2/r/ask/new.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     你问我答 最新 加载更多
     https://api.chouti.com/v2/r/ask/new.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&after_time=1541117754044000&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
    self.titles = @[@"最热",@"最新"];
    [super viewDidLoad];
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    if (index == 0) {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:MOSTHOT baseUrl:BDFHOMECATEGORYQAHOTLIST];
    } else {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:MOSTNEW baseUrl:BDFHOMECATEGORYQANEWLIST];
    }
    return viewController;
}

@end
