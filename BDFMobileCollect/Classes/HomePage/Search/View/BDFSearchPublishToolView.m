//
//  BDFSearchPublishToolView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/6.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFSearchPublishToolView.h"
#import "BDFSearchPublishToolButton.h"

@interface BDFSearchPublishToolView()
@property (nonatomic, weak) BDFSearchPublishToolButton *timeButton;
@property (nonatomic, weak) BDFSearchPublishToolButton *categoryButton;
@property (nonatomic, weak) BDFSearchPublishToolButton *hotButton;
@end

@implementation BDFSearchPublishToolView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.timeButton.hidden = NO;
    self.categoryButton.hidden = NO;
    self.hotButton.hidden = NO;
}

- (void)timeAction:(id)sender {
    if ([self.toolVDelegate respondsToSelector:@selector(searchPublishTimeAction:)]) {
        [self.toolVDelegate searchPublishTimeAction:sender];
    }
}

- (void)categoryAction:(id)sender {
    if ([self.toolVDelegate respondsToSelector:@selector(searchPublishCategoryAction:)]) {
        [self.toolVDelegate searchPublishCategoryAction:sender];
    }
}

- (void)hotAction:(id)sender {
    if ([self.toolVDelegate respondsToSelector:@selector(searchPublishHotAction:)]) {
        [self.toolVDelegate searchPublishHotAction:sender];
    }
}

- (BDFSearchPublishToolButton *)timeButton {
    if (!_timeButton) {
        BDFSearchPublishToolButton *button = [[BDFSearchPublishToolButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3., 44)];
        [button setTitle:@"全部时间" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_drop_pre"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _timeButton = button;
    }
    return _timeButton;
}

- (BDFSearchPublishToolButton *)categoryButton {
    if (!_categoryButton) {
        BDFSearchPublishToolButton *button = [[BDFSearchPublishToolButton alloc] initWithFrame:CGRectMake(self.timeButton.right, 0, SCREEN_WIDTH / 3., 44)];
        [button setTitle:@"全部分类" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_drop_pre"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _categoryButton = button;
    }
    return _categoryButton;
}

- (BDFSearchPublishToolButton *)hotButton {
    if (!_hotButton) {
        BDFSearchPublishToolButton *button = [[BDFSearchPublishToolButton alloc] initWithFrame:CGRectMake(self.categoryButton.right, 0, SCREEN_WIDTH / 3., 44)];
        [button setTitle:@"只看热榜" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"login_drop_pre"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hotAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _hotButton = button;
    }
    return _hotButton;
}

@end
