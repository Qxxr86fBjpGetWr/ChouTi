//
//  BDFSearchPublishToolButton.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/11.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFSearchPublishToolButton.h"

@implementation BDFSearchPublishToolButton

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setTitleColor:kOrangeColor forState:normal];
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.width, 0, -self.titleLabel.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.width, 0, self.imageView.width);
}
@end
