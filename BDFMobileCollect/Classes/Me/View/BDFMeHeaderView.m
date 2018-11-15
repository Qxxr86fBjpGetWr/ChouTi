//
//  BDFMeHeaderView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFMeHeaderView.h"
#import "BDFBaseImageView.h"
#import "BDFUserInfoManager.h"
#import "UIVisualEffectView+Addition.h"
#import "BDFUntil.h"
#import "NSString+Size.h"

@interface BDFMeHeaderView (){
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) BDFBaseImageView *headerImageView;
@property (nonatomic, strong) BDFBaseImageView *backImageView;
@property (nonatomic, strong) BDFBaseImageView *sexImageView;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UILabel *yearsLabel;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation BDFMeHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    BDFLoginSucModel *model = nil;
    if (isLogin) {
        model = [BDFUserInfoManager sharedManager].currentUserInfo;
    }
   
    self.headerImageView.x = (_view.width - 80) / 2.;
    self.headerImageView.y = (_view.height - 80) / 2.;
    
    self.nameLabel.y = self.headerImageView.y - self.nameLabel.height;
    self.nameLabel.x = (_view.width - self.nameLabel.width) / 2.;;
    CGFloat nameLabelW = [model.nick widthWithFont:self.nameLabel.font constrainedToHeight:self.nameLabel.height];
    self.nameLabel.width = nameLabelW;
    self.nameLabel.text = model.nick;
    
    self.loginButton.x = self.headerImageView.x - _loginButton.width - 20;
    self.loginButton.y = (_view.size.height - 30) / 2.;
    NSString *loginTitle = nil;
    if (isLogin) {
        loginTitle = [NSString stringWithFormat:@"关注%ld",model.followCount];
    } else {
        loginTitle = @"登录";
    }
    [self.loginButton setTitle:loginTitle forState:UIControlStateNormal];
    
    self.registerButton.x = self.headerImageView.right + 20;
    self.registerButton.y = (_view.size.height - 30) / 2.;
    NSString *registerTitle = nil;
    if (isLogin) {
        registerTitle = [NSString stringWithFormat:@"被关注%ld",model.fansCount];
    } else {
        registerTitle = @"注册";
    }
    [self.registerButton setTitle:registerTitle forState:UIControlStateNormal];
    
    NSString *yearString = [BDFUntil registerYearsWithTime:model.createTime / 1000000];
    self.yearsLabel.text = yearString;
    self.yearsLabel.hidden = !isLogin;
    
    self.sexImageView.frame = CGRectMake(self.headerImageView.x, self.headerImageView.bottom + 20, 20, 20);
    self.sexImageView.image = model.sex ? [UIImage imageNamed:@"boy"] : [UIImage imageNamed:@"girl"];
    self.sexImageView.hidden = !isLogin;
    
    self.locationButton.frame = CGRectMake(self.sexImageView.right + 20, self.sexImageView.y, 100, self.sexImageView.height);
    [self.locationButton setTitle:model.cityName forState:UIControlStateNormal];
    self.locationButton.hidden = !isLogin;
    
    self.editButton.frame = CGRectMake(0, self.sexImageView.bottom, 100, 30);
    self.editButton.x = (_view.width - _editButton.width) / 2;
    self.editButton.hidden = !isLogin;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.backImageView setImageWithString:model.img_url placeHolder:[UIImage imageNamed:@"tou_70"]];
        [self.headerImageView setImageWithString:model.img_url placeHolder:[UIImage imageNamed:@"tou_25"]];
    });
}

- (void)stretchHeaderForTableView:(UITableView *)tableView withView:(UIView *)view subViews:(UIView *)subview {
    _tableView = tableView;
    _view      = view;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height;
    
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView = emptyTableHeaderView;
    
    self.effectView.height = _view.height;
    
    [_view addSubview:_headerImageView];
    [_view addSubview:_loginButton];
    [_view addSubview:_registerButton];
    [_view addSubview:_sexImageView];
    [_view addSubview:_locationButton];
    [_view addSubview:_editButton];
    [_view addSubview:_nameLabel];
    
    [_tableView addSubview:_view];
    [_tableView addSubview:subview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect f     = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame  = f;
    
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        
        initialFrame.origin.y = - offsetY * 1;
        initialFrame.origin.x = - offsetY / 2;
        
        initialFrame.size.width  = _tableView.frame.size.width + offsetY;
        initialFrame.size.height = defaultViewHeight + offsetY;
        
        _view.frame = initialFrame;
        _backImageView.frame = _view.bounds;
        _effectView.frame = _view.bounds;
    }
}

- (void)bdfLogin {
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    if (isLogin) {
        if ([self.delegete respondsToSelector:@selector(bdfMeAttention)]) {
            [self.delegete bdfMeAttention];
        }
    }else {
        if ([self.delegete respondsToSelector:@selector(clickLoginButtonComplete)]) {
            [self.loginDelegate clickLoginButtonComplete];
        }
    }
}

- (void)bdfRegister {
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    if (isLogin) {
        if ([self.delegete respondsToSelector:@selector(bdfAttentionMe)]) {
            [self.delegete bdfAttentionMe];
        }
    }else {
        if ([self.delegete respondsToSelector:@selector(clickRegisterButtonComplete)]) {
            [self.loginDelegate clickRegisterButtonComplete];
        }
    }
}


- (BDFBaseImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[BDFBaseImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _headerImageView.layerCornerRadius = 40;
        _headerImageView.layerBorderWidth = 1;
        _headerImageView.layerBorderColor = kWhiteColor;
    }
    return _headerImageView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - self.headerImageView.width - 60)/2., 30)];
        _loginButton.layerCornerRadius = 15.f;
        _loginButton.layerBorderWidth = 1.0;
        _loginButton.layerBorderColor = kWhiteColor;
        [_loginButton addTarget:self action:@selector(bdfLogin) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - self.headerImageView.width - 60)/2., 30)];
        _registerButton.layerCornerRadius = 15.f;
        _registerButton.layerBorderWidth = 1.f;
        _registerButton.layerBorderColor = kWhiteColor;
        [_registerButton addTarget:self action:@selector(bdfRegister) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (BDFBaseImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[BDFBaseImageView alloc] initWithFrame:self.bounds];
        [_view addSubview:_backImageView];
        [_view sendSubviewToBack:_backImageView];
    }
    return _backImageView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initVisualEffectWithStyle:UIBlurEffectStyleDark];
        _effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _view.height);
        [_view addSubview:_effectView];
    }
    return _effectView;
}

- (UILabel *)yearsLabel {
    if (!_yearsLabel) {
        _yearsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _yearsLabel.backgroundColor = kOrangeColor;
        _yearsLabel.textColor = kBlackColor;
        _yearsLabel.layerCornerRadius = 15.f;
        [self.headerImageView addSubview:_yearsLabel];
    }
    return _yearsLabel;
}

- (BDFBaseImageView *)sexImageView {
    if (!_sexImageView) {
        _sexImageView = [[BDFBaseImageView alloc] initWithFrame:CGRectZero];
    }
    return _sexImageView;
}

- (UIButton *)locationButton {
    if (!_locationButton) {
        _locationButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _locationButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_locationButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }
    return _locationButton;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_editButton setImage:[UIImage imageNamed:@"my_write"] forState:UIControlStateNormal];
    }
    return _editButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = kFont(18);
        _nameLabel.textColor = kWhiteColor;
    }
    return _nameLabel;
}

@end
