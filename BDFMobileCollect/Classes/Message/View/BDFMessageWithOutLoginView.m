//
//  BDFMessageWithOutLoginView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/12.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFMessageWithOutLoginView.h"

@interface BDFMessageWithOutLoginView ()

@property (nonatomic, strong) UIImageView *tipImageView;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation BDFMessageWithOutLoginView

- (void)layoutSubviews {
    self.tipImageView.y = 100;
    self.loginButton.y = self.tipImageView.bottom + 50;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50., 0, SCREEN_WIDTH - 100, SCREEN_WIDTH - 100)];
        _tipImageView.image = [UIImage imageNamed:@"landing_image"];
        [self addSubview:_tipImageView];
    }
    return _tipImageView;
}

- (void)loginAction:(id)sender {
    if (self.loginBlock) {
        self.loginBlock();
    }
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH - 50, 30)];
        _loginButton.backgroundColor = kOrangeColor;
        _loginButton.layerCornerRadius = 30 / 2.;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginButton];
    }
    return _loginButton;
}

@end
