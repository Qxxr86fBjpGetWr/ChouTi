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

@interface BDFMessageTableViewController ()

@property (nonatomic, strong) BDFMessageWithOutLoginView *loginView;

@end

@implementation BDFMessageTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    [BDFUserInfoManager sharedManager].didLoginOut;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BDFMessageWithOutLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[BDFMessageWithOutLoginView alloc] initWithFrame:self.view.bounds];
        _loginView.origin = CGPointZero;
        _loginView.loginBlock = ^{
            [SVProgressHUD showSuccessWithStatus:@"稍等~"];
        };
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

@end
