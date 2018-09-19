//
//  BDFLogAndRegView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFLogAndRegView.h"
#import "UIVisualEffectView+Addition.h"

@interface BDFLogAndRegView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, weak) UITextField *userNameTextield;

@property (nonatomic, weak) UITextField *passWordTextField;

@property (nonatomic, weak) UIButton *loginButton;

@end

@implementation BDFLogAndRegView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        backImageView.frame = self.bounds;
        backImageView.alpha = 0.1;
        [self addSubview:backImageView];
        
        self.effectView = [[UIVisualEffectView alloc] initVisualEffectView];
        self.effectView.alpha = 1;
        [self addSubview:self.effectView];
        
        UIButton *cloasButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.2, SCREEN_HEIGHT * 0.1, 44, 44)];
        [cloasButton setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
        [cloasButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.effectView.contentView addSubview:cloasButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = @"Hi , 抽友";
        titleLabel.font = [UIFont systemFontOfSize:36];
        titleLabel.textColor = kOrangeColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.effectView.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *userLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        userLeftView.image = [UIImage imageNamed:@"login_phone"];
        
        UIImage *backImage = [UIImage imageNamed:@"Group 45"];
        backImage = [backImage stretchableImageWithLeftCapWidth:backImage.size.width * 0.5 topCapHeight:backImage.size.height * 0.5];
        
        UITextField *userNameTextield = [[UITextField alloc] initWithFrame:CGRectZero];
        userNameTextield.layer.cornerRadius = 5.;
        userNameTextield.layer.masksToBounds = YES;
        userNameTextield.leftView = userLeftView;
        userNameTextield.leftViewMode = UITextFieldViewModeAlways;
        userNameTextield.background = backImage;
        [self.effectView.contentView addSubview:userNameTextield];
        self.userNameTextield = userNameTextield;
        
        UIImageView *passLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        passLeftView.image = [UIImage imageNamed:@"login_password"];
        UIButton *showPassButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [showPassButton setImage:[UIImage imageNamed:@"login_closeeye"] forState:UIControlStateNormal];
        [showPassButton setImage:[UIImage imageNamed:@"login_eye"] forState:UIControlStateSelected];
        
        UITextField *passWordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        passWordTextField.layer.cornerRadius = 5.;
        passWordTextField.layer.masksToBounds = YES;
        passWordTextField.leftView = passLeftView;
        passWordTextField.rightView = showPassButton;
        passWordTextField.leftViewMode = UITextFieldViewModeAlways;
        passWordTextField.rightViewMode = UITextFieldViewModeAlways;
        passWordTextField.background = backImage;
        [self.effectView.contentView addSubview:passWordTextField];
        self.passWordTextField = passWordTextField;
        
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        loginButton.layer.cornerRadius = 5.;
        loginButton.layer.masksToBounds = YES;
        loginButton.backgroundColor = [UIColor lightGrayColor];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginHandle) forControlEvents:UIControlEventTouchUpInside];
        [self.effectView.contentView addSubview:loginButton];
        self.loginButton = loginButton;
    }
    return self;
}

//点击登录按钮的代理方法
- (void)loginHandle{
    if ([self.delegate respondsToSelector:@selector(clickLoginButtonComplete)]) {
        [self.delegate clickLoginButtonComplete];
    }
}

/** 关闭按钮方法 */
- (void)closeAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickCloseButtonComplte)]) {
        [self.delegate clickCloseButtonComplte];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(200);
    }];
    
    [self.userNameTextield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(260, 35));
    }];
    
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.userNameTextield.mas_bottom).with.offset(20);
        make.size.mas_equalTo(weakSelf.userNameTextield);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(260, 30));
        make.top.equalTo(weakSelf.passWordTextField.mas_bottom).with.offset(20);
    }];
}

@end
