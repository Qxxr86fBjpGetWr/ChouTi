//
//  BDFRecommendCommendPublishViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/13.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFRecommendCommendPublishViewController.h"
#import "BDFBaseNewsHotViewController.h"
#import "BDFMeCommentViewController.h"

@interface BDFRecommendCommendPublishViewController ()
@property (nonatomic, assign) NSInteger index;
@end

@implementation BDFRecommendCommendPublishViewController

-(instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    self.titles = @[@"推荐",@"评论",@"发布",];
    [super viewDidLoad];
    self.slideViewController.seletedIndex = self.index;
    /**
     推荐
     https://api.chouti.com/users/liked.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     评论
     https://api.chouti.com/users/comments.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     发布
     https://api.chouti.com/users/publish.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    
    if (index == 0) {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:1 baseUrl:BDFHOMELIKELIST];
    }else if (index == 1) {
        viewController = [[BDFMeCommentViewController alloc] init];
    } else {
        viewController = [[BDFBaseNewsHotViewController alloc] initWithType:1 baseUrl:BDFHOMEPUBLISHLIST];
    }
    return viewController;
}

@end
