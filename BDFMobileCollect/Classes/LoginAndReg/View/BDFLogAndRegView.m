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

@property (nonatomic, weak) UIButton *registerButton;

@property (nonatomic, strong) UIButton *forgetPassWordButton;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *userNameButton;

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
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.1, 44, 44)];
        [closeButton setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.effectView.contentView addSubview:closeButton];
        self.closeButton = closeButton;
        
        UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        registerButton.left = SCREEN_WIDTH - 100;
        registerButton.top = SCREEN_HEIGHT * 0.1;
        [self.effectView.contentView addSubview:registerButton];
        self.registerButton = registerButton;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = @"Hi , 抽友";
        titleLabel.font = [UIFont systemFontOfSize:36];
        titleLabel.textColor = kOrangeColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.effectView.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *userLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        userLeftView.image = [UIImage imageNamed:@"login_phone"];
        
        UIImage *backImage = [UIImage imageNamed:@"loginTextBack"];
        backImage = [backImage stretchableImageWithLeftCapWidth:backImage.size.width * 0.5 topCapHeight:backImage.size.height * 0.5];
        
        UITextField *userNameTextield = [[UITextField alloc] initWithFrame:CGRectZero];
        userNameTextield.layer.cornerRadius = 5.;
        userNameTextield.layer.masksToBounds = YES;
        userNameTextield.leftView = userLeftView;
        userNameTextield.leftViewMode = UITextFieldViewModeAlways;
        userNameTextield.background = backImage;
        userNameTextield.placeholder = @"请输入手机号";
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
        passWordTextField.placeholder = @"请输入密码";
        [self.effectView.contentView addSubview:passWordTextField];
        self.passWordTextField = passWordTextField;
        
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        loginButton.layer.cornerRadius = 15.;
        loginButton.layer.masksToBounds = YES;
        loginButton.backgroundColor = [UIColor lightGrayColor];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginHandle) forControlEvents:UIControlEventTouchUpInside];
        [self.effectView.contentView addSubview:loginButton];
        self.loginButton = loginButton;
        
        UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        [self.effectView.contentView addSubview:forgetButton];
        self.forgetPassWordButton = forgetButton;
        
        UIButton *userNameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        userNameButton.right = registerButton.right;
        userNameButton.top = forgetButton.top;
        [userNameButton setTitle:@"用户名登录" forState:UIControlStateNormal];
        [userNameButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        [self.effectView.contentView addSubview:userNameButton];
        self.userNameButton = userNameButton;
        
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
        make.top.equalTo(weakSelf.passWordTextField.mas_bottom).with.offset(44);
    }];
    
//    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//    }];
    
    [self.forgetPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.closeButton.mas_left); make.top.equalTo(weakSelf.loginButton.mas_bottom).with.offset(20);
    }];
    
    [self.userNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.registerButton.mas_right);
        make.top.equalTo(weakSelf.forgetPassWordButton.mas_top);
    }];
}

@end
