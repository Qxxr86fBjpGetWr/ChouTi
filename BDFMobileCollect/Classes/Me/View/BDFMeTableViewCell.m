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
    self.arrowImageView.y = (self.height - self.arrowImageView.height) / 2;
    self.iconImageView.y = (self.height - self.iconImageView.height) / 2;
    self.titleLabel.y = (self.height - self.titleLabel.height) / 2.;
}

- (void)setDataModel:(BDFMeDataModel *)dataModel {
    if (!dataModel) {
        return;
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

@end
