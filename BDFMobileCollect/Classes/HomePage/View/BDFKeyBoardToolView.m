//
//  BDFKeyBoardToolView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/7/10.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFKeyBoardToolView.h"
#import "UIVisualEffectView+Addition.h"
#import "UIView+Tap.h"

@interface BDFKeyBoardToolView()

@property (nonatomic, weak) UIButton *likeButton;
@property (nonatomic, weak) UIButton *copButton;
@property (nonatomic, weak) UIButton *warnButton;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIView *commentButView;

@end

@implementation BDFKeyBoardToolView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = kWhiteColor;
    
    CGFloat moduleW = SCREEN_WIDTH / 4;
    CGFloat moduleX = (moduleW - _likeButton.width) / 2;
    
    self.likeButton.x = moduleX;
    self.copButton.x = moduleW + moduleX;
    self.warnButton.x = moduleW * 2 + moduleX;
    self.shareButton.x = moduleW * 3 + moduleX;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:@"commentToolFavorite"] forState:UIControlStateNormal];
        [button setBackgroundColor:kColorFromRGB(0xf5f5f5)];
        _likeButton = button;
        [self.commentButView addSubview:button];
    }
    return _likeButton;
}

- (UIButton *)copButton {
    if (!_copButton) {
         UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:@"commentToolCopy"] forState:UIControlStateNormal];
        [button setBackgroundColor:kColorFromRGB(0xf5f5f5)];
        _copButton = button;
        [self.commentButView addSubview:button];
    }
    return _copButton;
}

- (UIButton *)warnButton {
    if (!_warnButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:@"commentToolReport"] forState:UIControlStateNormal];
        [button setBackgroundColor:kColorFromRGB(0xf5f5f5)];
        _warnButton = button;
        [self.commentButView addSubview:button];
    }
    return _warnButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:@"commentToolShare"] forState:UIControlStateNormal];
        [button setBackgroundColor:kColorFromRGB(0xf5f5f5)];
        _shareButton = button;
        [self.commentButView addSubview:button];
    }
    return _shareButton;
}

- (YYTextView *)textView {
    
    if (!_textView) {
        YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 30)];
        textView.backgroundColor = kWhiteColor;
        textView.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        textView.placeholderFont = kFont(16);
        textView.placeholderAttributedText = [[NSAttributedString alloc] initWithString:@"回复XXXX" attributes:@{NSForegroundColorAttributeName : kLightGrayColor}];
        textView.font = kFont(16);
        _textView = textView;
        [self.commentButView addSubview:_textView];
    }
    return _textView;
}

- (UIView *)commentButView {
    if (!_commentButView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = kColorFromRGB(0xf5f5f5);
        _commentButView = view;
        [self addSubview:view];
    }
    return _commentButView;
}

//- (UIVisualEffectView *)effectView {
//    if (!_effectView) {
//        UIVisualEffectView *view = [[UIVisualEffectView alloc] initVisualEffectView];
//        [self addSubview:view];
//        view.hidden = YES;
//        WeakSelf(weakSelf);
//        [view setTapActionWithBlock:^{
//            [weakSelf endEditing:YES];
//        }];
//        _effectView = view;
//    }
//    return _effectView;
//}

@end
