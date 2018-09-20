//
//  BDFHomeHeaderOptionView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/1.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDFHomeHeaderOptionView : UIView

/** 标题数组*/
@property (nonatomic, strong) NSArray <NSString *>*titles;
/** 点击item回调*/
@property (nonatomic, copy) void(^homeHeaderOptionalViewItemClickHandle)(BDFHomeHeaderOptionView *optialView, NSString *title, NSInteger currentIndex);
/** 偏移量*/
@property (nonatomic, assign) CGPoint contentOffset;

@end
