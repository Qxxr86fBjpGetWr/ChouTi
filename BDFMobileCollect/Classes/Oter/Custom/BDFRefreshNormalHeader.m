//
//  BDFRefreshNormalHeader.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/25.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFRefreshNormalHeader.h"

@implementation BDFRefreshNormalHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if ([self.refreshDelegate respondsToSelector:@selector(refreshCompleWithOffset:)]) {
        [self.refreshDelegate refreshCompleWithOffset:self.scrollView];
    }
}

@end
