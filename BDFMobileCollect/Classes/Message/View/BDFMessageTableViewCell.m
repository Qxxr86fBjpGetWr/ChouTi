//
//  BDFMessageTableViewCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/25.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFMessageTableViewCell.h"
#import "BDFBaseImageView.h"

@interface BDFBaseTableViewCell ()

@property(nonatomic, weak) BDFBaseImageView *testImageView;

@property(nonatomic, weak) UILabel *testImageLabel;

@end

@implementation BDFMessageTableViewCell

-(void)setDataModel:(BDFMessageDataModel *)dataModel {
    _dataModel = dataModel;
    
    BDFBaseImageView *imageView = [[BDFBaseImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 295)];
    imageView.layerCornerRadius = 8;
    [imageView setImageWithString:dataModel.original_pic];
    [self.contentView addSubview:imageView];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.backgroundColor = [UIColor clearColor];
}

@end
