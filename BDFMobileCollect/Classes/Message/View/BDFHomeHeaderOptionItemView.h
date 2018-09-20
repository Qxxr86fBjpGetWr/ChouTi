//
//  BDFHomeHeaderOptionItemView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/6/1.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDFHomeHeaderOptionItemView : UILabel

/** 填充色，从左开始*/
@property (nonatomic, strong) UIColor *fillColor;
/** 滑动进度*/
@property (nonatomic, assign) CGFloat progress;

@end
