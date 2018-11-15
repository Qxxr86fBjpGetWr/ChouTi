//
//  BDFMeCommentCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeCommentCell.h"

@interface BDFMeCommentCell ()

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UILabel *originalTextLabel;

@end

@implementation BDFMeCommentCell

- (void)setModel:(BDFMeCommentFrameModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    self.timeLabel.frame = model.timeLabelF;
    self.contentLabel.frame = model.commentLabelF;
    self.originalTextLabel.frame = model.textLabelF;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",model.model.created_time];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.model.content];
    self.originalTextLabel.text = model.model.link.title;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = kFont(13);
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = kFont(13);
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)originalTextLabel {
    if (!_originalTextLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = kFont(13);
        [self.contentView addSubview:label];
        _originalTextLabel = label;
    }
    return _originalTextLabel;
}

@end
