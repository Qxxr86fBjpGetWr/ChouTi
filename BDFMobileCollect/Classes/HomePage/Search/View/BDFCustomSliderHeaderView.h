//
//  BDFCustomSliderHeaderView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDFCustomSliderHeaderView : UIView

/** 标题数组*/
@property (nonatomic, strong) NSArray <NSString *>*titles;
/** 点击item回调*/
@property (nonatomic, copy) void(^homeHeaderOptionalViewItemClickHandle)(BDFCustomSliderHeaderView *optialView, NSString *title, NSInteger currentIndex);
/** 偏移量*/
@property (nonatomic, assign) CGPoint contentOffset;

@end
