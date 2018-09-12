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

@property (nonatomic, strong) CAShapeLayer *leftLine;//头像左侧的线条

@property (nonatomic, weak) CAShapeLayer *bottomLine;//头像下方的线条

@property (nonatomic, strong) UIBezierPath *movePath;

@end

@implementation BDFHomeCommentsCell

- (void)setCommentFrameModel:(BDFCommentFrameModel *)commentFrameModel {
    
    if (!commentFrameModel) {
        return;
    }
    _commentFrameModel = commentFrameModel;
    BDFHomeCommenntUserModel *user = commentFrameModel.commentModel.user;

    /*
    if (self.commentFrameModel.deep > 0) {
        [self setNeedsDisplayWithCGRect:commentFrameModel.userImageF];
    }
    */
    self.userImageView.frame = commentFrameModel.userImageF;
    [self.userImageView setImageWithString:user.img_url placeHolder:[UIImage imageNamed:@"tou_25"]];
    
    self.userNameLabel.frame = commentFrameModel.userNameF;
    self.userNameLabel.text = user.nick;
    
    self.timeLabel.frame = commentFrameModel.timeAndModuleF;
    NSString *stringTime = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",commentFrameModel.commentModel.created_time / 1000000]];
    self.timeLabel.text = [BDFUntil compareCurrentTime:stringTime];
    
    self.upsButton.frame = commentFrameModel.upsButtonF;
    self.upsButton.x = SCREEN_WIDTH - 100;
    NSInteger ups = commentFrameModel.commentModel.ups;
    if (ups > 0) {
        [self.upsButton setTitle:[NSString stringWithFormat:@"%ld",ups] forState:UIControlStateNormal];
    }
    
    self.dowsButton.frame = commentFrameModel.downButtonF;
    self.dowsButton.x = self.upsButton.right + 30;
    NSInteger downs = commentFrameModel.commentModel.downs;
    if (ups > 0) {
        [self.dowsButton setTitle:[NSString stringWithFormat:@"%ld",downs] forState:UIControlStateNormal];
    }
    
    self.contentLabel.frame = commentFrameModel.contentF;
    self.contentLabel.text = [NSString stringWithFormat:@"%@ %ld",commentFrameModel.commentModel.content, commentFrameModel.commentModel.id];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)allKindOfButtonAction:(id)sender {
    
}

- (void)setNeedsDisplayWithCGRect:(CGRect)rect {
    [self.movePath removeAllPoints];
    self.movePath = [UIBezierPath bezierPath];
    [self.movePath moveToPoint:CGPointMake(rect.origin.x - 10, 0)];
    [self.movePath addLineToPoint:CGPointMake(rect.origin.x - 10, rect.origin.y + rect.size.width / 2)];
    [self.movePath addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y + rect.size.width / 2)];
    
    [self.leftLine removeFromSuperlayer];
    self.leftLine = [CAShapeLayer layer];
    self.leftLine.frame = CGRectMake(0, 0, rect.origin.x, self.frame.size.height);
    self.leftLine.lineWidth = 1.0f;
    self.leftLine.strokeColor = kBlackColor.CGColor;
    self.leftLine.path = self.movePath.CGPath;
    self.leftLine.fillColor  = nil;
    [self.contentView.layer addSublayer:self.leftLine];
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
