//
//  BDFBaseImageView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/25.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <YYImage/YYImage.h>

@interface BDFBaseImageView : YYAnimatedImageView

-(void)setImageWithString:(NSString *)url;
-(void)setImageWithUrl:(NSURL *)URL;

-(void)setImageWithString:(NSString *)url placeHolder:(UIImage *)placeImage;
-(void)setImageWithUrl:(NSURL *)URL placeHolder:(UIImage *)placeImage;

-(void)setImageWithString:(NSString *)url placeHolder:(UIImage *)placeImage finish:(void(^)(BOOL finish, UIImage *image))handleBlock;
-(void)setImageWithUrl:(NSURL *)URL placeHolder:(UIImage *)placeImage finish:(void(^)(BOOL finish, UIImage *image))handleBlock;

-(void)setImageWithString:(NSString *)url placeHolder:(UIImage *)placeImage progress:(void(^)(CGFloat progress))progressBlcok finish:(void(^)(BOOL finish, UIImage *image))handleBlock;
-(void)setImageWithUrl:(NSURL *)URL placeHolder:(UIImage *)placeImage progress:(void(^)(CGFloat progress))progressBlcok finish:(void(^)(BOOL finish, UIImage *image))handleBlock;

@end
