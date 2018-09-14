//
//  BDFMeHeaderView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFTableViewHeaderFooterView.h"

@interface BDFMeHeaderView : BDFTableViewHeaderFooterView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *view;

- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                         subViews:(UIView*)subview;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@end
