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

-(void)dealloc {
    NSLog(@"%s 已经被销毁！",__func__);
}

@end
