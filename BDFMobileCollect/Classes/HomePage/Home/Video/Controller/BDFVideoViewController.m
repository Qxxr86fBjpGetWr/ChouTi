//
//  BDFVideoViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/8.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFVideoViewController.h"
#import "BDFBaseNewsHotViewController.h"

@implementation BDFVideoViewController

/**

 视频 最热
 https://api.chouti.com/v2/r/video.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
 视频 最热 加载更多
 https://api.chouti.com/v2/r/video.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&after_score=44007.221736895196955&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
 视频 最新
 https://api.chouti.com/v2/r/video/new.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
 视频 最新 加载更多
 https://api.chouti.com/v2/r/video/new.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&after_time=1541323330868000&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
 */

- (void)viewDidLoad {
    self.titles = @[@"最热",@"最新"];
    [super viewDidLoad];
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    if (index == 0) {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:MOSTHOT baseUrl:BDFHOMECATEGORYVIDEOHOTLIST];
    } else {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:MOSTNEW baseUrl:BDFHOMECATEGORYVIDEONEWLIST];
    }
    return viewController;
}

@end
