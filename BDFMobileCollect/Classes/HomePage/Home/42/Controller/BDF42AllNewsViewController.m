//
//  BDF42AllNewsViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/8.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDF42AllNewsViewController.h"
#import "BDF42NewsViewController.h"
#import "BDF42NewsMenuModel.h"
#import "BDF42NewsViewController.h"

@interface BDF42AllNewsViewController ()

@property (nonatomic, strong) BDF42NewsMenuModel *model;

@end

@implementation BDF42AllNewsViewController

- (void)viewDidLoad {
    
    /**
     最新
     https://api.chouti.com/v2/r/news.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     最热
     https://api.chouti.com/v2/r/news/new.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     社会
     https://api.chouti.com/api/category_news/list.json?access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&category=sh&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&category=tech&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&category=gj&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&source=c40fe2f61bcfd611177be71ec305196b&version=3.2.0.6
     */
    BDF42NewsMenuModel *menuModel = [[BDF42NewsMenuModel alloc] unarchiver];
    if (!menuModel) {
        BDFBaseRequest *request = [BDFBaseRequest bdf_requestWithUrl:BDFHOMECATEGORY42MENU];
        [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
            self.model = [BDF42NewsMenuModel modelWithDictionary:response];
            [self insertDataWithModel:self.model];
            [self.model archive];
            [self handResponseModel:self.model];
        }];
    } else {
        [self handResponseModel:menuModel];
    }
}

- (void)insertDataWithModel:(BDF42NewsMenuModel *)model {
    BDF42NewsMenuRespModel *newsRespModel = [[BDF42NewsMenuRespModel alloc] initWithVale:@"最热"];
    BDF42NewsMenuRespModel *hotRespModel = [[BDF42NewsMenuRespModel alloc] initWithVale:@"最新"];
    NSRange range = {0,2};
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [model.resp insertObjects:@[newsRespModel, hotRespModel] atIndexes:indexSet];
}

- (void)handResponseModel:(BDF42NewsMenuModel *)menuModel {
    NSMutableArray *tempData = @[].mutableCopy;
    for (int i = 0; i < menuModel.resp.count; i++) {
        BDF42NewsMenuRespModel *menuResp = menuModel.resp[i];
        [tempData addObject:menuResp.value];
    }
    self.titles = tempData.copy;
    [super viewDidLoad];
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    NSString *baseUrl = nil;
    if (index == 0) {
        baseUrl = BDFHOMECATEGORY42;
    } else if (index == 1) {
        baseUrl = BDFHOMECATEGORY42HOT;
    } else {
        baseUrl = BDFHOMECATEGORY42CATEGORY;
    }
    BDF42NewsMenuRespModel *model = self.model.resp[index];
    BDF42NewsViewController *viewController = [[BDF42NewsViewController alloc] initWithBaseUrl:baseUrl withModel:model];
    return viewController;
}

@end
