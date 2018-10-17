//
//  BDFMeTableViewCell.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/14.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFMeTableViewCell.h"

@interface BDFMeTableViewCell ()

@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UISwitch *cellSwitch;

@end

@implementation BDFMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.y = (self.height - self.iconImageView.height) / 2;
    self.titleLabel.y = (self.height - self.titleLabel.height) / 2.;
    self.detailLabel.y = (self.height - self.detailLabel.height) / 2.;
    self.arrowImageView.y = (self.height - self.arrowImageView.height) / 2;
    self.cellSwitch.y = (self.height - self.cellSwitch.height) / 2;
}

- (void)setDataModel:(BDFMeDataModel *)dataModel {
    if (!dataModel) {
        return;
    }
    NSInteger cellType = [dataModel.type integerValue];
    if (cellType == 0) {
        self.detailLabel.hidden = YES;
        self.cellSwitch.hidden = YES;
    } else if (cellType == 1) {
        self.detailLabel.hidden = NO;
        self.cellSwitch.hidden = YES;
        self.detailLabel.text = dataModel.data;
    } else {
        self.detailLabel.hidden = YES;
        self.cellSwitch.hidden = NO;
    }
    self.iconImageView.image = [UIImage imageNamed:dataModel.meCellIcon];
    self.titleLabel.text = dataModel.meCellTitle;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 0, 15, 15)];
        _arrowImageView.image = [UIImage imageNamed:@"set_next"];
        [self.contentView addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 15, 15)];
        _iconImageView.image = [UIImage imageNamed:@"set_next"];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + 20, 0, 150, 30)];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.arrowImageView.x - 80, 0, 80, 30)];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UISwitch *)cellSwitch {
    if (!_cellSwitch) {
        _cellSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.detailLabel.x, self.detailLabel.y, 50, 30)];
        [self.contentView addSubview:_cellSwitch];
    }
    return _cellSwitch;
}

@end
