//
//  BDFHomeSearchTextField.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/8/5.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeSearchTextField.h"

@interface BDFHomeSearchTextField()

@property (nonatomic, assign) CGFloat leftmargin;

@end

@implementation BDFHomeSearchTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += self.leftmargin;
    return iconRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 10;
    return editingRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 10;
    return textRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    return placeholderRect;
}

- (instancetype)initWithFrame:(CGRect)frame
               leftViewMargin:(CGFloat)leftViewMargin
                    textColor:(UIColor *)textColor
                      bgColor:(UIColor *)bgColor
                   holdertext:(NSString *)holdertext
                leftViewimage:(NSString *)imagename
               rightViewimage:(NSString *)rightImagename {
    
    if (self = [super initWithFrame:frame]) {
        _leftmargin = leftViewMargin;
        self.borderStyle = UITextBorderStyleNone;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.backgroundColor = bgColor;
        self.layer.cornerRadius = 7.0f;
        self.layer.borderColor = self.backgroundColor.CGColor;
        self.textColor = textColor;
        self.font = kFont(14.0f);
        self.placeholder = holdertext;
        UIImage *image = [UIImage imageNamed:imagename ? imagename: @"searchicon"];
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, image.size.width, image.size.height)];
        leftImageView.tintColor = [UIColor whiteColor];
        leftImageView.contentMode = UIViewContentModeCenter;
        leftImageView.image = image;
        
        UIImage *rightImage = [UIImage imageNamed:rightImagename ? rightImagename : @"deleteinput"];
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width -  20, 0, image.size.width, image.size.height)];
        rightImageView.tintColor = [UIColor whiteColor];
        rightImageView.contentMode = UIViewContentModeCenter;
        rightImageView.image = rightImage;
        
        self.leftView = leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.returnKeyType = UIReturnKeySearch;
        
    }
    return self;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    if ([placeHolderColor isKindOfClass:[UIColor class]] == NO) {
        return ;
    }
    _placeHolderColor = placeHolderColor;
    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    
}

@end
