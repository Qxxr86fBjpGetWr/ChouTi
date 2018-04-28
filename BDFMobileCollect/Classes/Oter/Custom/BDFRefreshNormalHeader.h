//
//  BDFRefreshNormalHeader.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/25.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "MJRefreshNormalHeader.h"

@protocol BDFRefreshNormalHeaderDelegate <NSObject>

- (void)refreshCompleWithOffset:(UIScrollView *)scrollView;

@end

@interface BDFRefreshNormalHeader : MJRefreshNormalHeader

@property (nonatomic, weak) id <BDFRefreshNormalHeaderDelegate> refreshDelegate;

@end
