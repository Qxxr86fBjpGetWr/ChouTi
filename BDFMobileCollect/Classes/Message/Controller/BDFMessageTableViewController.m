//
//  BDFMessageTableViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/25.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFMessageTableViewController.h"
#import "BDFMessageTableViewCell.h"
#import "BDFMessageRequest.h"
#import "BDFMessageModel.h"
#import "BDFUserInfoManager.h"
#import "BDFMessageWithOutLoginView.h"
#import <SVProgressHUD.h>
#import "BDFLogAndRegViewController.h"
#import "BDFHomeSliderViewController.h"
#import "BDFHomeHeaderOptionView.h"
#import "BDFHomePageViewController.h"
#import "BDFNotificationViewController.h"

@interface BDFMessageTableViewController ()<BDFCustomSlideViewControllerDelegate, BDFCustomSlideViewControllerDataSource>

@property (nonatomic, strong) BDFMessageWithOutLoginView *loginView;

@property (nonatomic, strong) BDFHomeHeaderOptionView *optionalView;

@property (nonatomic, strong) BDFHomeSliderViewController *slideViewController;

@end

@implementation BDFMessageTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    WeakSelf(weakSelf);
    self.optionalView.titles = @[@"通知", @"提醒", @"聊天"];
    self.optionalView.homeHeaderOptionalViewItemClickHandle = ^(BDFHomeHeaderOptionView *optialView, NSString *title, NSInteger currentIndex) {
        weakSelf.slideViewController.seletedIndex = currentIndex;
    };
    [self.slideViewController reloadData];
    [self configUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setController];
}

- (void)setController {
    self.needCellSepLine = NO;
    self.refreshType = BDFBaseTableVcRefreshTypeRefreshAndLoadMore;
}

- (void)configUI {
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    self.loginView.hidden = isLogin;
    self.tableView.hidden = !isLogin;
    if (isLogin) {
        [self.loginView removeFromSuperview];
        self.loginView = nil;
    }
}

-(NSInteger)bdf_numberOfSections {
    return 1;
}

-(NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

-(BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    BDFMessageTableViewCell *cell = [BDFMessageTableViewCell cellWithTableView:self.tableView];
    cell.dataModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - BDFCustomSlideViewControllerDelegate
- (void)customSlideViewController:(BDFHomeSliderViewController *)slideViewController slideIndex:(NSInteger)slideIndex {}

- (void)customSlideViewController:(BDFHomeSliderViewController *)slideViewController slideOffset:(CGPoint)slideOffset {
    self.optionalView.contentOffset = slideOffset;
}

#pragma mark - BDFCustomSlideViewControllerDataSource
- (UIViewController *)slideViewController:(BDFHomeSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    UIViewController *viewController = nil;
    
    if (index == 0) {
        viewController = [[BDFNotificationViewController alloc] init];
    }else if (index == 1) {
        viewController = [[BDFNotificationViewController alloc] init];
    } else {
        viewController = [[BDFNotificationViewController alloc] init];
    }
    return viewController;
}

- (NSInteger)numberOfChildViewControllersInSlideViewController:(BDFHomeSliderViewController *)slideViewController {
    return self.optionalView.titles.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BDFMessageWithOutLoginView *)loginView {
    if (!_loginView) {
        WeakSelf(weakSelf);
        _loginView = [[BDFMessageWithOutLoginView alloc] initWithFrame:self.view.bounds];
        _loginView.origin = CGPointZero;
        _loginView.loginBlock = ^{
            [weakSelf presentVc:[[BDFLogAndRegViewController alloc]init]];
        };
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

- (BDFHomeHeaderOptionView *)optionalView {
    if (!_optionalView) {
        BDFHomeHeaderOptionView *optional = [[BDFHomeHeaderOptionView alloc] init];
        optional.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        [self.view addSubview:optional];
        _optionalView = optional;
        optional.backgroundColor = kWhiteColor;
    }
    return _optionalView;
}

- (BDFHomeSliderViewController *)slideViewController {
    if (!_slideViewController) {
        BDFHomeSliderViewController *slide = [[BDFHomeSliderViewController alloc] init];
        [slide willMoveToParentViewController:self];
        [self addChildViewController:slide];
        [self.view addSubview:slide.view];
        slide.view.frame = CGRectMake(0, self.optionalView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.optionalView.height);
        slide.delgate = self;
        slide.dataSource = self;
        slide.scorllEnable = YES;
        _slideViewController = slide;
    }
    return _slideViewController;
}

@end
