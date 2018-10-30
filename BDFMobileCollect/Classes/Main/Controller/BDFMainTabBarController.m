//
//  BDFMainTabBarController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/6.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFMainTabBarController.h"
#import "BDFBaseNavigationController.h"
#import "BDFSubHomePageViewController.h"
#import "BDFMessageTableViewController.h"
#import "BDFMeViewController.h"

@interface BDFMainTabBarController ()

@end

@implementation BDFMainTabBarController

+ (void)initialize
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllerWithClassName:NSStringFromClass([BDFSubHomePageViewController class]) imageName:@"tab_home" selectName:@"tab_home_pre" title:@""];
    [self addChildViewControllerWithClassName:NSStringFromClass([BDFMessageTableViewController class]) imageName:@"tab_news" selectName:@"tab_news_pre" title:@""];
    [self addChildViewControllerWithClassName:NSStringFromClass([BDFMeViewController class]) imageName:@"tab_my" selectName:@"tab_my_pre" title:@""];
}

-(void)addChildViewControllerWithClassName:(NSString *)className imageName:(NSString *)imageName selectName:(NSString *)selectName title:(NSString *)title {
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    BDFBaseNavigationController *nav = [[BDFBaseNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:normalImage selectedImage:selectImage];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    NSLog(@"%s 已经被销毁！",__func__);
}

@end
