//
//  BDFHomeTitleView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/20.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeTitleView.h"

@implementation BDFHomeTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"新热榜" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"btn_drop"] forState:UIControlStateNormal];
        /** 只有使用过一次之后，size才能准确拿到 */
        [self setTitleColor:kBlackColor forState:UIControlStateNormal];
        self.imageView.backgroundColor = kWhiteColor;
        CGSize titleW = self.titleLabel.bounds.size;
        CGSize imageW = self.imageView.bounds.size;
        self.imageEdgeInsets = UIEdgeInsetsMake(0,titleW.width, 0, -titleW.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW.width, 0, imageW.width);
        [self addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)pop {
    if ([self.delegate respondsToSelector:@selector(homeTitleCliclAction)]) {
        [self.delegate homeTitleCliclAction];
    }
}

@end
