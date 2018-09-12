//
//  BDFSearchPublishToolView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BDFSearchPublishToolDelegate <NSObject>

/** 全部时间 按钮的代理方法 */
- (void)searchPublishTimeAction:(UIButton *)timeButton;
/** 全部分类 按钮的代理方法 */
- (void)searchPublishCategoryAction:(UIButton *)timeButton;
/** 是否只看热榜 按钮的代理方法 */
- (void)searchPublishHotAction:(UIButton *)timeButton;

@end

@interface BDFSearchPublishToolView : UIView

@property (nonatomic, weak) id <BDFSearchPublishToolDelegate> toolVDelegate;

@end
