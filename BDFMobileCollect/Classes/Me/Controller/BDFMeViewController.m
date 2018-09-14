//
//  BDFMeViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFMeViewController.h"
#import "BDFMeTableViewCell.h"
#import "BDFMeDataModel.h"
#import "BDFMeHeaderView.h"

#define TITLE @"meCellTitle"
#define ICON @"meCellIcon"

@interface BDFMeViewController ()
@property (nonatomic, strong) NSDictionary <NSNumber *, NSArray<NSDictionary *> *> *dateSource;

@property (nonatomic, strong) BDFMeHeaderView *headerView;
@end

@implementation BDFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kColorFromRGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.headerView stretchHeaderForTableView:self.tableView withView:self.headerView subViews:nil];
    [self creatMeData];
}

- (void)creatMeData {
    self.dateSource = @{
                       @0 : @[
                           @{TITLE : @"最近浏览",ICON : @"time",},
                           @{TITLE : @"私藏",ICON : @"my_collection",},
                           @{TITLE : @"推荐",ICON : @"my_good",},
                           @{TITLE : @"评论",ICON : @"my_comment",},
                           @{TITLE : @"发布",ICON : @"my_pub",},
                           @{TITLE : @"钱包",ICON : @"my_wallet",},
                           @{TITLE : @"黑名单",ICON : @"my_hei",},
                         ],
                       @1 : @[
                           @{TITLE : @"夜间模式",ICON : @"my_night",},
                           @{TITLE : @"更多设置",ICON : @"my_set",},
                           ],
                       };
}

- (NSInteger)bdf_numberOfSections {
    return self.dateSource.allKeys.count;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    NSNumber *sectionNum = [NSNumber numberWithInteger:section];
    NSArray *sectionArray = self.dateSource[sectionNum];
    return sectionArray.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *sectionNum = [NSNumber numberWithInteger:indexPath.section];
    NSArray *sectionArray = self.dateSource[sectionNum];
    
    BDFMeTableViewCell *cell = [BDFMeTableViewCell cellWithTableView:self.tableView];
    BDFMeDataModel *dataModel = [BDFMeDataModel modelWithDictionary:sectionArray[indexPath.row]];
    cell.dataModel = dataModel;
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView scrollViewDidScroll:scrollView];
}

- (BDFMeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BDFMeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
