//
//  BDFCollectionViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/8.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFCollectionViewController.h"
#import "BDFBaseNewsHotViewController.h"

@interface BDFCollectionViewController ()

@end

@implementation BDFCollectionViewController

- (void)viewDidLoad {
    
    /**
     私藏 发布
     https://api.chouti.com/users/save.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     私藏 评论
     https://api.chouti.com/api/comments/self/get.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
    self.titles = @[@"发布",@"评论"];
    [super viewDidLoad];
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    if (index == 0) {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:MOSTHOT baseUrl:BDFHOMECATEGORYPUBLISHLIST];
    } else {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:MOSTNEW baseUrl:BDFHOMECATEGORYCOMMENTLIST];
    }
    return viewController;
}

@end
