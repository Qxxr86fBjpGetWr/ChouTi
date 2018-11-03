//
//  BDFHomeTopicListTableCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFHomeTopicListTableCell.h"
#import "BDFBaseImageView.h"

@interface BDFHomeTopicListTableCell ()

@property (nonatomic, strong) BDFBaseImageView *leftImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BDFHomeTopicListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.separatorInset = UIEdgeInsetsMake(0, 80, 0, -80);
    self.leftImageView.centerY = self.contentView.centerY;
    self.titleLabel.centerY = self.contentView.centerY;
}

- (void)setRecordModel:(BDFHomeTopicListRespRecordsModel *)recordModel {
    if (!recordModel) {
        return;
    }
    _recordModel = recordModel;
    [self.leftImageView setImageWithString:recordModel.imgUrl];
    self.titleLabel.text = recordModel.name;
}

- (BDFBaseImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[BDFBaseImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:_leftImageView];
    }
    return _leftImageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftImageView.right + 50, 0, 100, 30)];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
