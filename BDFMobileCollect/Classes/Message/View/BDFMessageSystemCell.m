//
//  BDFMessageSystemCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMessageSystemCell.h"
#import "BDFBaseImageView.h"
#import "BDFUntil.h"

@interface BDFMessageSystemCell ()

@property (nonatomic, strong) BDFBaseImageView *headImageV;
@property (nonatomic, strong) UILabel *nickNameL;
@property (nonatomic, strong) UILabel *timeNameL;

@end

@implementation BDFMessageSystemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat headImageX = 10;
    CGFloat headImageY = (self.height - (self.height * 0.7)) / 2.;
    self.headImageV.origin = CGPointMake(headImageX, headImageY);
    
    CGFloat nickNameX = self.headImageV.right + 20;
    CGFloat nickNameY = self.headImageV.y;
    CGFloat nickNameW = SCREEN_WIDTH - nickNameX;
    CGFloat nickNameH = self.headImageV.height / 2.;
    self.nickNameL.frame = CGRectMake(nickNameX, nickNameY, nickNameW, nickNameH);
    
    CGFloat timeNameY = self.nickNameL.bottom + 10;
    self.timeNameL.frame = CGRectMake(nickNameX, timeNameY, nickNameW, nickNameH);
}

- (void)setSystemMessage:(BDFSystemMessageNoticeModel *)systemMessage {
    _systemMessage = systemMessage;
    
    [self.headImageV setImageWithString:systemMessage.adviceUser.img_url];
    self.nickNameL.text = systemMessage.content;
    self.timeNameL.text = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",systemMessage.createTime / 1000000]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (BDFBaseImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[BDFBaseImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _headImageV.layerCornerRadius = 30;
        [self.contentView addSubview:_headImageV];
    }
    return _headImageV;
}

- (UILabel *)nickNameL {
    if (!_nickNameL) {
        _nickNameL = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nickNameL];
    }
    return _nickNameL;
}

- (UILabel *)timeNameL {
    if (!_timeNameL) {
        _timeNameL = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_timeNameL];
    }
    return _timeNameL;
}

@end
