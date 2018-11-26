//
//  BDFMessageWarnCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMessageWarnCell.h"
#import "BDFBaseImageView.h"
#import "BDFUntil.h"

@interface BDFMessageWarnCell ()

@property (nonatomic, strong) BDFBaseImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *linkLabel;

@end

@implementation BDFMessageWarnCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setFrameModel:(BDFMessaageWarnFrameModel *)frameModel {
    
    _frameModel = frameModel;
    BDFMessageWarnDataFromUserModel *fromUser = frameModel.dataModel.fromUser;
    
    self.headImageView.frame = frameModel.headImageR;
    self.headImageView.layerCornerRadius = frameModel.headImageR.size.width / 2.;
    [self.headImageView setImageWithString:fromUser.img_url];
    
    self.nameLabel.frame = frameModel.nickNameR;
    self.nameLabel.text = fromUser.nick;
    
    self.timeLabel.frame = frameModel.timeR;
    self.timeLabel.text = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",frameModel.dataModel.createTime / 1000000]];
    
    self.commentLabel.frame = frameModel.commentR;
    self.commentLabel.text = frameModel.dataModel.content;
    
    self.linkLabel.frame = frameModel.linkR;
    self.linkLabel.text = frameModel.dataModel.parentComments.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (BDFBaseImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[BDFBaseImageView alloc] init];
        [self.contentView addSubview:_headImageView];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont(13);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kFont(13);
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = kFont(13);
        _commentLabel.numberOfLines = 0;
        _commentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_commentLabel];
    }
    return _commentLabel;
}

- (UILabel *)linkLabel {
    if (!_linkLabel) {
        _linkLabel = [[UILabel alloc] init];
        _linkLabel.font = kFont(13);
        _linkLabel.numberOfLines = 0;
        _linkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _linkLabel.backgroundColor = kColorFromRGB(0xEDEDED);
        [self.contentView addSubview:_linkLabel];
    }
    return _linkLabel;
}


@end
