//
//  BDFLogAndRegView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFLogAndRegView.h"

@interface BDFLogAndRegView ()

@property (nonatomic, weak) UITextField *userNameTextield;

@property (nonatomic, weak) UITextField *passWordTextField;

@property (nonatomic, weak) UIButton *loginButton;

@end

@implementation BDFLogAndRegView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *userNameTextield = [[UITextField alloc] initWithFrame:CGRectZero];
        userNameTextield.backgroundColor = [UIColor lightGrayColor];
        userNameTextield.layer.cornerRadius = 5.;
        userNameTextield.layer.masksToBounds = YES;
        [self addSubview:userNameTextield];
        self.userNameTextield = userNameTextield;
        
        UITextField *passWordTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        passWordTextField.layer.cornerRadius = 5.;
        passWordTextField.layer.masksToBounds = YES;
        passWordTextField.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:passWordTextField];
        self.passWordTextField = passWordTextField;
        
        UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        loginButton.layer.cornerRadius = 5.;
        loginButton.layer.masksToBounds = YES;
        loginButton.backgroundColor = [UIColor lightGrayColor];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginHandle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginButton];
        self.loginButton = loginButton;
    }
    return self;
}

//点击登录按钮的代理方法
-(void)loginHandle{
    if ([self.delegate respondsToSelector:@selector(clickLoginButtonComplie)]) {
        [self.delegate clickLoginButtonComplie];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    [self.userNameTextield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(230);
        make.size.mas_equalTo(CGSizeMake(260, 35));
    }];
    
    [self.passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.userNameTextield.mas_bottom).with.offset(20);
        make.size.mas_equalTo(weakSelf.userNameTextield);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.equalTo(weakSelf.passWordTextField.mas_bottom).with.offset(20);
    }];
}

@end
