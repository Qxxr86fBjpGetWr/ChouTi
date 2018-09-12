//
//  BDFCustomSliderHeaderItem.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>

@interface BDFCustomSliderHeaderItem : UILabel

/** 填充色，从左开始*/
@property (nonatomic, strong) UIColor *fillColor;
/** 滑动进度*/
@property (nonatomic, assign) CGFloat progress;

@end
