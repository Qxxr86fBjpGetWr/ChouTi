//
//  BDFHomeCommentsCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/28.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeCommentsCell.h"
#import "BDFBaseImageView.h"
#import "BDFUntil.h"

@interface BDFHomeCommentsCell ()

@property (nonatomic, weak) BDFBaseImageView *userImageView;

@property (nonatomic, weak) UILabel *userNameLabel;

@property (nonatomic, weak) UILabel *timeLabel;
/** 顶 */
@property (nonatomic, weak) UIButton *upsButton;
/** 踩 */
@property (nonatomic, weak) UIButton *dowsButton;

@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation BDFHomeCommentsCell

-(void)setCommentFrameModel:(BDFCommentFrameModel *)commentFrameModel {
    
    if (!commentFrameModel) {
        return;
    }
    _commentFrameModel = commentFrameModel;
    
    BDFHomeCommenntUserModel *user = commentFrameModel.commentModel.user;
    
    self.userImageView.frame = commentFrameModel.userImageF;
    [self.userImageView setImageWithString:user.img_url placeHolder:[UIImage imageNamed:@"tou_25"]];
    
    self.userNameLabel.frame = commentFrameModel.userNameF;
    self.userNameLabel.text = user.nick;
    
    self.timeLabel.frame = commentFrameModel.timeAndModuleF;
    NSString *stringTime = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",commentFrameModel.commentModel.created_time / 1000000]];
    self.timeLabel.text = [BDFUntil compareCurrentTime:stringTime];
    
    self.upsButton.frame = commentFrameModel.upsButtonF;
    
    self.dowsButton.frame = commentFrameModel.downButtonF;
    
    self.contentLabel.frame = commentFrameModel.contentF;
    self.contentLabel.text = commentFrameModel.commentModel.content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)allKindOfButtonAction:(id)sender {
    
}

- (BDFBaseImageView *)userImageView {
    if (!_userImageView) {
        BDFBaseImageView *imageView = [[BDFBaseImageView alloc] init];
        _userImageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _userImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:BDFHomeNewsUserNameFont];
        label.textColor = kGrayColor;
        _userNameLabel = label;
        [self.contentView addSubview:label];
    }
    return _userNameLabel;
}

- (UIButton *)upsButton {
    if (!_upsButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_good"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_good_pre"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14.];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [button setTitleColor:kGrayColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allKindOfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _upsButton = button;
    }
    return _upsButton;
}

- (UIButton *)dowsButton {
    if (!_dowsButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [button setTitleColor:kGrayColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allKindOfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _dowsButton = button;
    }
    return _dowsButton;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:BDFHomeNewsTimeFont];
        label.textColor = kGrayColor;
        _timeLabel = label;
        [self.contentView addSubview:label];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:BDFHomeNewsCommentFont];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.textColor = kBlackColor;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

@end
