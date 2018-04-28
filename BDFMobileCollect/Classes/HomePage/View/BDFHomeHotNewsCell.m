//
//  BDFHomeHotNewsCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeHotNewsCell.h"
#import "BDFHomeHotNewsModel.h"
#import "BDFBaseImageView.h"
#import "UIView+Layer.h"
#import "BDFUntil.h"

@interface BDFHomeHotNewsCell()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) BDFBaseImageView *mainImageView;

@property (nonatomic, weak) BDFBaseImageView *userImageView;

@property (nonatomic, weak) UILabel *userNameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIButton *upsButton;

@property (nonatomic, weak) UIButton *commentButton;

@property (nonatomic, weak) UIButton *likeButton;

@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, strong) BDFHomeHotNewsModelLink *hotNewsModel;

@end

@implementation BDFHomeHotNewsCell

-(void)setNewsFrame:(BDFHomeHotNewsFrame *)newsFrame {
    if (!newsFrame) {
        return;
    }
    self.hotNewsModel = newsFrame.hotNewsModel;
    
    self.titleLabel.frame = newsFrame.contentF;
    self.titleLabel.text = self.hotNewsModel.title;
    
    self.mainImageView.frame = newsFrame.mainImageF;
    self.mainImageView.shadowColor = kGrayColor;
    [self.mainImageView setImageWithString:self.hotNewsModel.img_url];
    
    self.upsButton.frame = newsFrame.upsButtonF;
    self.upsButton.titleLabel.text = [NSString stringWithFormat:@"%ld",_hotNewsModel.ups];
    
    self.commentButton.frame = newsFrame.commentButtonF;
    self.commentButton.titleLabel.text = [NSString stringWithFormat:@"%ld",_hotNewsModel.comments_count];
    
    self.likeButton.frame = newsFrame.likeButtonF;
    
    self.shareButton.frame = newsFrame.shareButtomF;
    
    self.userImageView.frame = newsFrame.userImageF;
    self.userImageView.layerCornerRadius = newsFrame.userImageF.size.width / 2.;
    
    [self.userImageView setImageWithString:_hotNewsModel.submitted_user.img_url];
    
    self.userNameLabel.frame = newsFrame.userNameF;
    self.userNameLabel.text = _hotNewsModel.submitted_user.nick;
    
    self.timeLabel.frame = newsFrame.timeAndModuleF;
    NSString *stringTime = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",_hotNewsModel.created_time / 1000000]];
    self.timeLabel.text = [BDFUntil compareCurrentTime:stringTime];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:BDFHomeNewsTextFont];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label.textColor = kBlackColor;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (BDFBaseImageView *)mainImageView {
    
    if (!_mainImageView) {
        BDFBaseImageView *imageView = [[BDFBaseImageView alloc] init];
        [self.contentView addSubview:imageView];
        _mainImageView = imageView;
    }
    return _mainImageView;
}

- (UIButton *)upsButton {
    if (!_upsButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_good"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _upsButton = button;
    }
    return _upsButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _commentButton = button;
    }
    return _commentButton;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_collection"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _likeButton = button;
    }
    return _likeButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_reply"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _shareButton = button;
    }
    return _shareButton;
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

@end
