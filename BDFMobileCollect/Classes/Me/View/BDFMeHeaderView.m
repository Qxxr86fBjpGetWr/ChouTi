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

@interface BDFMeHeaderView (){
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) BDFBaseImageView *headerImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation BDFMeHeaderView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.headerImageView.x = (_view.size.width - 50) / 2.;
    self.headerImageView.y = (_view.size.height - 50) / 2.;
    
    self.loginButton.x = self.headerImageView.x - _loginButton.width - 20;
    self.loginButton.y = (_view.size.height - 30) / 2.;
    
    self.registerButton.x = self.headerImageView.right + 20;
    self.registerButton.y = (_view.size.height - 30) / 2.;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BDFLoginSucModel *model = [BDFUserInfoManager sharedManager].currentUserInfo;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img_url]];
        UIImage *image = [UIImage imageWithData:data];
        self.layer.contents = (id)image.CGImage;
        [self.headerImageView setImageWithString:model.img_url];
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
    [_view bringSubviewToFront:_headerImageView];
    [_view addSubview:_loginButton];
    [_view bringSubviewToFront:_loginButton];
    [_view addSubview:_registerButton];
    [_view bringSubviewToFront:_loginButton];
    
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
        _effectView.frame = _view.bounds;
    }
}

- (BDFBaseImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[BDFBaseImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _headerImageView.layerCornerRadius = 25.f;
    }
    return _headerImageView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _loginButton.layerCornerRadius = 15.f;
        _loginButton.layerBorderWidth = 1.0;
        _loginButton.layerBorderColor = kWhiteColor;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _registerButton.layerCornerRadius = 15.f;
        _registerButton.layerBorderWidth = 1.f;
        _registerButton.layerBorderColor = kWhiteColor;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initVisualEffectView];
        _effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _view.height);
        [_view addSubview:_effectView];
    }
    return _effectView;
}

@end
