//
//  BDFHomePageViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFHomePageViewController.h"
#import "BDFHomePageHotNewsRequest.h"
#import "BDFHomeHotNewsModel.h"
#import "BDFHomeHotNewsCell.h"
#import "BDFTableViewHeaderFooterView.h"

@interface BDFHomePageViewController ()

//@property (nonatomic, strong)BDFHomeHotNewsModel *hotNewsModel;

@property (nonatomic, strong) NSMutableArray *hotNewsFrameArray;

@end

@implementation BDFHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needCellSepLine = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.refreshType = BDFBaseTableVcRefreshTypeRefreshAndLoadMore;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -54, 375, 54)];
    view.backgroundColor = [UIColor purpleColor];
    [self.tableView insertSubview:view atIndex:0];
    
    
    
    [self setNav];
    [self loadData];
}

- (void)setNav {
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftButton setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self setNavLeftItem:leftBarItem];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setImage:[UIImage imageNamed:@"nav_pub"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self setNavRightItem:rightBarItem];
    
    
}

- (void)loadData {
    BDFHomePageHotNewsRequest *request = [BDFHomePageHotNewsRequest bdf_requestWithUrl:BDFHOMEPAGEHOTNNEWS];
    request.brush = @"0";
    
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFHomeHotNewsModel *hotNewsModel = [BDFHomeHotNewsModel modelWithDictionary:response];
        for (BDFHomeHotNewsModelLink *obj in hotNewsModel.links) {
            BDFHomeHotNewsFrame *newsFrame = [[BDFHomeHotNewsFrame alloc] init];
            newsFrame.hotNewsModel = obj;
            [self.hotNewsFrameArray addObject:newsFrame];
        }
        [self bdf_reloadData];
    }];
}

-(void)bdf_refresh {
    [self bdf_endRefresh];
}

-(void)loginOut{
    [self dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)bdf_numberOfSections {
    return self.hotNewsFrameArray.count;
}

-(NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsCell *cell = [BDFHomeHotNewsCell cellWithTableView:self.tableView];
    cell.newsFrame = self.hotNewsFrameArray[indexPath.section];
    return cell;
}

- (CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFHomeHotNewsFrame *cellFrame = self.hotNewsFrameArray[indexPath.section];
    return CGRectGetMaxY(cellFrame.upsButtonF);
}

- (UIView *)bdf_footerAtSection:(NSInteger)section {
    
    BDFTableViewHeaderFooterView *footerView = [BDFTableViewHeaderFooterView headerFooterViewWithTableView:self.tableView];
    return footerView;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {

    view.tintColor = kClearColor;
}

- (CGFloat)bdf_sectionFooterHeightAtSection:(NSInteger)section {
    return 5;
}

- (NSMutableArray *)hotNewsFrameArray {
    
    if (!_hotNewsFrameArray) {
        _hotNewsFrameArray = @[].mutableCopy;
    }
    return _hotNewsFrameArray;
}

@end
