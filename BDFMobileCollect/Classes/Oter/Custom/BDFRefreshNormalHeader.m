//
//  BDFRefreshNormalHeader.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/25.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFRefreshNormalHeader.h"
#import "BDFHomeRefreshModel.h"

@interface BDFRefreshNormalHeader ()

@property (nonatomic, weak) UIImageView *faceImageView;

@end

@implementation BDFRefreshNormalHeader

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
    }
    CGFloat arrowCenterY = self.mj_h * 0.3;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    if (self.faceImageView.constraints.count == 0) {
        self.faceImageView.mj_size = self.faceImageView.image.size;
        self.faceImageView.center = arrowCenter;
    }
    self.faceImageView.tintColor = self.stateLabel.textColor;
    self.stateLabel.centerY = self.faceImageView.bottom + 20;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.faceImageView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.faceImageView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.faceImageView.alpha = 1.0;
                [self stopAnimation];
                self.faceImageView.hidden = NO;
            }];
        } else {
            [self stopAnimation];
            self.faceImageView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.faceImageView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self stopAnimation];
        self.faceImageView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.faceImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.faceImageView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self startAnimation];
    }
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
    
    if ([change[@"old"] integerValue] == 0) {
        BDFHomeRefreshModel *model = [[BDFHomeRefreshModel alloc] unarchiver];
        NSInteger index = arc4random() % (model.resp.count - 1);
        BDFHomeRefreshRespModel *respModel = model.resp[index];
        [self setTitle:respModel.content forState:MJRefreshStatePulling];
        [self setTitle:respModel.content forState:MJRefreshStateRefreshing];
        [self setTitle:respModel.content forState:MJRefreshStateIdle];
    }
}

- (void)startAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.faceImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimation {
    [self.faceImageView.layer removeAllAnimations];
}

- (UIImageView *)faceImageView {
    if (!_faceImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"update"]];
        [self addSubview:_faceImageView = imageView];
    }
    return _faceImageView;
}

@end
