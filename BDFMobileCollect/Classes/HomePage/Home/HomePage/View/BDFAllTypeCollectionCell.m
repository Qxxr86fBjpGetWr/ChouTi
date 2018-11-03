//
//  BDFAllTypeCollectionCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/30.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFAllTypeCollectionCell.h"

@implementation BDFAllTypeCollectionCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.center = self.contentView.center;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc] initWithFrame:self.bounds];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = kLightGrayColor;
        title.backgroundColor = kClearColor;
        _titleLabel = title;
        [self.contentView addSubview:title];
    }
    return _titleLabel;
}

@end
