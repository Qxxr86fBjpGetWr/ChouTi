//
//  BDFNotificationViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/20.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFNotificationViewController.h"
#import "BDFCustomCommonEmptyView.h"

@interface BDFNotificationViewController ()

@property (nonatomic, strong) BDFCustomCommonEmptyView *emptyView;

@end

@implementation BDFNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hidden = YES;
    self.emptyView.hidden = !self.tableView.hidden;
}

- (BDFCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        BDFCustomCommonEmptyView *empty = [[BDFCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"" iconname:@"empty"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}


@end
