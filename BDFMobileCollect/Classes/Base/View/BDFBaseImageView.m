//
//  BDFBaseImageView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/25.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseImageView.h"
#import <YYWebImage.h>

@implementation BDFBaseImageView

-(void)setImageWithString:(NSString *)url {
    [self setImageWithString:url placeHolder:nil];
}

-(void)setImageWithUrl:(NSURL *)URL {
    [self setImageWithUrl:URL placeHolder:nil];
}

-(void)setImageWithString:(NSString *)url placeHolder:(UIImage *)placeImage {
    [self setImageWithString:url placeHolder:placeImage finish:nil];
}

-(void)setImageWithUrl:(NSURL *)URL placeHolder:(UIImage *)placeImage {
    [self setImageWithUrl:URL placeHolder:placeImage finish:nil];
}

-(void)setImageWithString:(NSString *)url placeHolder:(UIImage *)placeImage finish:(void (^)(BOOL, UIImage *))handleBlock {
    [self setImageWithString:url placeHolder:placeImage progress:nil finish:handleBlock];
}

-(void)setImageWithUrl:(NSURL *)URL placeHolder:(UIImage *)placeImage finish:(void (^)(BOOL, UIImage *))handleBlock {
    [self setImageWithUrl:URL placeHolder:placeImage progress:nil finish:handleBlock];
}

-(void)setImageWithString:(NSString *)url placeHolder:(UIImage *)placeImage progress:(void (^)(CGFloat))progressBlcok finish:(void (^)(BOOL, UIImage *))handleBlock {
    [self setImageWithUrl:[NSURL URLWithString:url] placeHolder:placeImage progress:progressBlcok finish:handleBlock];
}

-(void)setImageWithUrl:(NSURL *)URL placeHolder:(UIImage *)placeImage progress:(void (^)(CGFloat))progressBlcok finish:(void (^)(BOOL, UIImage *))handleBlock {
    [self yy_setImageWithURL:URL placeholder:placeImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlcok) {
            progressBlcok(receivedSize * 1.0 / expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (handleBlock) {
            handleBlock(error == nil, image);
        }
    }];
}

@end
