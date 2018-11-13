//
//  BDFHomeSearchController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeSearchController.h"
#import "BDFHomeSearchTextField.h"
#import "BDFCustomCommonEmptyView.h"
#import "BDFSearchSuggestRequest.h"
#import "BDFSearchSuggestModel.h"
#import "UIView+Tap.h"
#import "BDFCustomSliderViewController.h"
#import "BDFCustomSliderHeaderView.h"
#import "BDFSearchPublishViewController.h"
#import "BDFSearchUsersViewController.h"

@interface BDFHomeSearchController ()<UITextFieldDelegate, BDFCustomSlideViewControllerDelegate, BDFCustomSlideViewControllerDataSource>

@property (nonatomic, strong) BDFHomeSearchTextField *searchTextField;

@property (nonatomic, strong) BDFCustomCommonEmptyView *emptyView;

@property (nonatomic, strong) BDFSearchSuggestModel *model;

@property (nonatomic, strong) BDFCustomSliderViewController *sliderVc;

@property (nonatomic, strong) BDFCustomSliderHeaderView *optionalView;

@property (nonatomic, copy) NSString *searchWord;

@end

@implementation BDFHomeSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hidden = YES;
    
    WeakSelf(weakSelf);
//    [self.view setTapActionWithBlock:^{
//        [weakSelf.searchTextField endEditing:YES];
//    }];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView: self.searchTextField];
    [self bdf_setUpNavRightItemTitle:@"取消" handle:^(NSString *rightItemTitle) {
        [weakSelf pop];
    }];
    [self.emptyView showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)suggestLoadDataWithKeyWord:(NSString *)word {
    BDFSearchSuggestRequest *request = [BDFSearchSuggestRequest bdf_requestWithUrl:BDFHOMESEARCHSUGGEST isPost:NO];
    request.keywords = word;
    [request bdf_sendRequestWithComple:^(id response, BOOL success, NSString *message) {
        BDFLog(@"%@",response);
        if (!NULLDic(response)) {
            self.model = [BDFSearchSuggestModel modelWithDictionary:response];
        }else {
            self.model = nil;
            [self.searchTextField endEditing:YES];
            [self removeChildVc:self.sliderVc];
            [self.optionalView removeFromSuperview];
            self.sliderVc = nil;
            self.optionalView = nil;
        }
        
        self.emptyView.hidden = _model;
        self.tableView.hidden = !self.emptyView.hidden;
        [self.tableView reloadData];
        
    }];
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    [self suggestLoadDataWithKeyWord:textField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (NULLString(textField.text)) {
        return NO;
    }
    self.searchWord = textField.text;
    [self.searchTextField endEditing:YES];
    [self creatSearchDataViews];
    
    return YES;
}

- (NSInteger)bdf_numberOfSections {
    return 1;
}

- (NSInteger)bdf_numberOfRowsInSection:(NSInteger)section {
    return self.model.object.resultList.count;
}

- (BDFBaseTableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFBaseTableViewCell *cell = [BDFBaseTableViewCell cellWithTableView:self.tableView];
    BDFSearchSuggestModelObjectResult *resultModel = self.model.object.resultList[indexPath.row];
    cell.textLabel.text = resultModel.text;
    
    return cell;
}

- (void)bdf_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(BDFBaseTableViewCell *)cell {
    [self.searchTextField endEditing:YES];
    
    [self creatSearchDataViews];
    
    BDFSearchSuggestModelObjectResult *resultModel = self.model.object.resultList[indexPath.row];
    self.searchWord = resultModel.text;
    
    /**
    搜索/发布 全部时间 全部分类 全部热度
     https://api.chouti.com/search/show.json
     access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&searchType=2&source=c40fe2f61bcfd611177be71ec305196b&version=3.1.6.1&words=%E5%85%B6%E5%AE%9E%E4%BD%A0%E7%9A%84%E4%BA%BA%E7%94%9F
     
    time：HOUR24 DAY3 WEEK1 MONTH1 time=YEAR1 access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&searchType=2&source=c40fe2f61bcfd611177be71ec305196b&time=HOUR24&version=3.1.6.1&words=%E5%85%B6%E5%AE%9E%E4%BD%A0%E7%9A%84%E4%BA%BA%E7%94%9F
     
     
     subjectId: 1 2 4 100 151 access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&searchType=2&source=c40fe2f61bcfd611177be71ec305196b&subjectId=1&time=YEAR1&version=3.1.6.1&words=%E5%85%B6%E5%AE%9E%E4%BD%A0%E7%9A%84%E4%BA%BA%E7%94%9F
     */
    
    /**
    搜索/发布 全部时间 全部分类 只看热榜 access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&linkType=HOT&page=1&searchType=2&source=c40fe2f61bcfd611177be71ec305196b&version=3.1.6.1&words=%E5%85%B6%E5%AE%9E%E4%BD%A0%E7%9A%84%E4%BA%BA%E7%94%9F
     */
    
    /**
    https://api.chouti.com/search/show.json access_token=c40fe2f61bcfd611177be71ec305196bB896036B802CBA1762D0D6C3A48792ED&deviceId=12ec7b9b922138b8a6bc55070a164669d050bb7a&page=1&searchType=3&source=c40fe2f61bcfd611177be71ec305196b&version=3.1.6.1&words=%E5%85%B6%E5%AE%9E%E4%BD%A0%E7%9A%84%E4%BA%BA%E7%94%9F
     */
}

-(CGFloat)bdf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - BDFCustomSlideViewControllerDelegate

#pragma mark - BDFCustomSlideViewControllerDataSource
- (NSInteger)numberOfChildViewControllersInSlideViewController:(BDFCustomSliderViewController *)slideViewController {
    return 2;
}

- (UIViewController *)slideViewController:(BDFCustomSliderViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    
    BDFBaseTableViewController *vc = [[BDFBaseTableViewController alloc] init];
    if (index == 0) {
        vc = [[BDFSearchPublishViewController alloc] initWithSearchWord:self.searchWord];
    }else if (index == 1) {
        vc = [[BDFSearchUsersViewController alloc] init];
    }
    return vc;
}

- (void)customSlideViewController:(BDFCustomSliderHeaderView *)slideViewController slideOffset:(CGPoint)slideOffset {
    self.optionalView.contentOffset = slideOffset;
}

- (void)customSlideViewController:(BDFCustomSliderViewController *)slideViewController slideIndex:(NSInteger)slideIndex {
    
}

- (void)creatSearchDataViews {
    
    WeakSelf(weakSelf);
    self.optionalView.titles = @[@"发布", @"用户"];
    self.optionalView.homeHeaderOptionalViewItemClickHandle = ^(BDFCustomSliderHeaderView *optialView, NSString *title, NSInteger currentIndex) {
        weakSelf.sliderVc.selectIndex = currentIndex;
    };
    self.sliderVc.scrollEnabled = YES;
    [self.sliderVc reloadData];
}

#pragma mark - lazy load
- (BDFHomeSearchTextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[BDFHomeSearchTextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)
            leftViewMargin:10 textColor:kBlackColor
            bgColor:kColorFromRGB(0xf0f0f0)
            holdertext:@"请输入您要搜索的内容"
            leftViewimage:@"searchicon"
            rightViewimage:@"deleteinput"];
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.delegate = self;
        _searchTextField.layerCornerRadius = 5.0f;
        _searchTextField.placeHolderColor = [UIColor lightGrayColor];
        [_searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchTextField;
}
- (BDFCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        BDFCustomCommonEmptyView *empty = [[BDFCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"" iconname:@"searchEmpyt"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

- (BDFCustomSliderViewController *)sliderVc {
    if (!_sliderVc) {
        BDFCustomSliderViewController *vc = [[BDFCustomSliderViewController alloc] init];
        [self addChildVc:vc];
        [self.view addSubview:vc.view];
        vc.view.frame = CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44);
        vc.dataSource = self;
        vc.delgate = self;
        _sliderVc = vc;
    }
    return _sliderVc;
}

- (BDFCustomSliderHeaderView *)optionalView {
    if (!_optionalView) {
        BDFCustomSliderHeaderView *optional = [[BDFCustomSliderHeaderView alloc] init];
        optional.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [self.view addSubview:optional];
        _optionalView = optional;
        optional.backgroundColor = kWhiteColor;
    }
    return _optionalView;
}

@end
