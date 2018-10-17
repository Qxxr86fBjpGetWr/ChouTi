//
//  BDFMeHeaderView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFTableViewHeaderFooterView.h"
#import "BDFLogAndRegViewDelegate.h"

@protocol BDFMeAttentionDelegate <NSObject>
/** 关注列表 */
- (void)bdfMeAttention;
/** 被关注列表 */
- (void)bdfAttentionMe;
@end

@class BDFMeLoginDelegate;

@interface BDFMeHeaderView : BDFTableViewHeaderFooterView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *view;

@property (nonatomic, weak) id <BDFMeAttentionDelegate> delegete;

@property (nonatomic, weak) id <BDFLogAndRegViewDelegate> loginDelegate;

- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                         subViews:(UIView*)subview;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@end
