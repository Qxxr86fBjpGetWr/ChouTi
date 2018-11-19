//
//  BDFMeCommentCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeCommentCell.h"
#import "BDFUntil.h"

@interface BDFMeCommentCell ()

@property (nonatomic, weak) UIButton *timeButton;

@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UILabel *originalTextLabel;

@end

@implementation BDFMeCommentCell

- (void)setModel:(BDFMeCommentFrameModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    self.timeButton.frame = model.timeLabelF;
    self.contentLabel.frame = model.commentLabelF;
    self.originalTextLabel.frame = model.textLabelF;
    
    NSString *stringTime = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",model.model.created_time / 1000000]];
    NSString *timeStr = [BDFUntil compareCurrentTime:stringTime];
    [self.timeButton setTitle:timeStr forState:UIControlStateNormal];
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.model.content];
    self.originalTextLabel.text = model.model.link.title;
}

- (UIButton *)timeButton {
    if (!_timeButton) {
        UIButton *label = [[UIButton alloc] init];
        label.titleLabel.font = kFont(12);
        [label setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
        [label setTitleColor:kLightGrayColor forState:UIControlStateNormal];
        [self.contentView addSubview:label];
        _timeButton = label;
    }
    return _timeButton;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = kFont(13);
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)originalTextLabel {
    if (!_originalTextLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = kFont(13);
        label.backgroundColor = kColorFromRGB(0xEDEDED);
        label.textColor = kLightGrayColor;
        [self.contentView addSubview:label];
        _originalTextLabel = label;
    }
    return _originalTextLabel;
}

@end
