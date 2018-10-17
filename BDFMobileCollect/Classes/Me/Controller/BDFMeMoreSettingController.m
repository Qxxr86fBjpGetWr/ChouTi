//
//  BDFMeMoreSettingController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeMoreSettingController.h"
#import "BDFUserInfoManager.h"

@interface BDFMeMoreSettingController ()

@end

@implementation BDFMeMoreSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatData];
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    BDFBaseTableViewCell *cell = [BDFBaseTableViewCell cellWithTableView:self.tableView];
    cell.textLabel.text = @"退出账号";
    return cell;
}

- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell {
    [[BDFUserInfoManager sharedManager] didLoginOut];
    [self popToRootVc];
    if ([self.moreDelegate respondsToSelector:@selector(didLoginOut)]) {
        [self.moreDelegate didLoginOut];
    }
}

#pragma mark - 创建数据
- (void)creatData {
    
}

@end
