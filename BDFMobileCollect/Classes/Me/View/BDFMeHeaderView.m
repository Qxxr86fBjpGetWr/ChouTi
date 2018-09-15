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

@interface BDFMeHeaderView (){
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) BDFBaseImageView *headerImageView;

@end

@implementation BDFMeHeaderView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.headerImageView.center = self.center;
    
    self.loginButton.center = self.center;
    self.loginButton.x = self.headerImageView.x - _loginButton.width - 20;
    
    self.registerButton.center = self.center;
    self.registerButton.x = self.headerImageView.right + 20;
    
    BOOL isLogin = [BDFUserInfoManager sharedManager].isLogin;
    if (isLogin) {
        BDFLoginSucModel *model = [BDFUserInfoManager sharedManager].currentUserInfo;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img_url]];
        UIImage *image = [UIImage imageWithData:data];
        self.layer.contents = (id)image.CGImage;
        [self.headerImageView setImageWithString:model.img_url];
    }else {
        
    }
}

- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view subViews:(UIView*)subview {
    _tableView = tableView;
    _view      = view;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height;
    
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView = emptyTableHeaderView;
    
    [_tableView addSubview:_view];
    [_tableView addSubview:subview];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
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
    }
}

- (BDFBaseImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[BDFBaseImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _headerImageView.layerCornerRadius = 25.f;
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _loginButton.layerCornerRadius = 15.f;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.contentView addSubview:_loginButton];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _registerButton.layerCornerRadius = 15.f;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [self.contentView addSubview:_registerButton];
    }
    return _registerButton;
}

@end
