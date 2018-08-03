//
//  BDFDetailWebViewController.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/7/9.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFDetailWebViewController.h"
#import <WebKit/WebKit.h>
#import "BDFHomeDetailWebView.h"

#define PROGRESSPATH @"estimatedProgress"

@interface BDFDetailWebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, weak)  BDFHomeDetailWebView *webView;
@property (nonatomic, strong) CALayer *progresslayer;
@property (nonatomic, strong) NSString *webUrl;

@end

@implementation BDFDetailWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        if (url) {
            self.webUrl = url;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViews];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_webUrl]];
    [self.webView loadRequest:request];
}

- (void)setSubViews {
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_StatusBarAndNavBarHeight, CGRectGetWidth(self.view.frame), 3)];
    [self.webView addSubview:progress];
    [self.webView bringSubviewToFront:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = kOrangeColor.CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:PROGRESSPATH]) {
        self.progresslayer.opacity = 1;
        
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (BDFHomeDetailWebView *)webView {
    if (!_webView) {
        BDFHomeDetailWebView *webView = [[BDFHomeDetailWebView alloc] initWithFrame:self.view.bounds];
        [webView addObserver:self forKeyPath:PROGRESSPATH options:NSKeyValueObservingOptionNew context:nil];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:PROGRESSPATH];
}

@end
