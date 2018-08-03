//
//  BDFBaseNavigationController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseNavigationController.h"

@interface BDFBaseNavigationController ()

@end

@implementation BDFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        if ([viewController isKindOfClass:[UIViewController class]] == NO) return ;
        if (viewController.hidesBottomBarWhenPushed == NO) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    } else {
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)dealloc {
    NSLog(@"%s 已经被销毁！",__func__);
}

@end
