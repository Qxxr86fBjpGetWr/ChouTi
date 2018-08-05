//
//  BDFAvatarBrowser.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFAvatarBrowser.h"
#import "UIView+Tap.h"

static CGRect oldframe;

@implementation BDFAvatarBrowser

+(void)showImage:(UIImageView *)avatarImageView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIImage *image=avatarImageView.image;
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backgroundView.backgroundColor = kWhiteColor;
    backgroundView.alpha = 0.7;
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        
        backgroundView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {

        [backgroundView removeFromSuperview];
    }];
    
}

@end
