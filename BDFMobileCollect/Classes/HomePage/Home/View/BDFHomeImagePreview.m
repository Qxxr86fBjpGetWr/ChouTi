//
//  BDFHomeImagePreview.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeImagePreview.h"
#import "BDFBaseImageView.h"
#import "UIVisualEffectView+Addition.h"

@interface BDFHomeImagePreview()

@property (nonatomic, weak) BDFBaseImageView *preViewImage;

@end

@implementation BDFHomeImagePreview


- (instancetype)initWithImage:(UIImage *)image {
   
    self = [super init];
    if (self) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self = [[BDFHomeImagePreview alloc] initWithEffect:blurEffect];
        self.preViewImage.image = image;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.preViewImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
    self.preViewImage.center = self.center;
}

- (BDFBaseImageView *)preViewImage {
    if (!_preViewImage) {
        BDFBaseImageView *image = [[BDFBaseImageView alloc] init];
        _preViewImage = image;
        [self.contentView addSubview:image];
    }
    return _preViewImage;
}

@end
