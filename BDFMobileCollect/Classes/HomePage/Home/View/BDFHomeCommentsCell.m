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

@interface BDFCommentLayer : CALayer
@end

@implementation BDFCommentLayer

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    }
    return self;
}

@end

@interface BDFHomeCommentsCell ()

@property (nonatomic, weak) BDFBaseImageView *userImageView;
@property (nonatomic, weak) UILabel *userNameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
/** 顶 */
@property (nonatomic, weak) UIButton *upsButton;
/** 踩 */
@property (nonatomic, weak) UIButton *dowsButton;
@property (nonatomic, weak) UILabel *contentLabel;
/** 缩进宽度，默认为30 */
@property (nonatomic, assign) CGFloat indenWidth;
@property (nonatomic, strong) CALayer *horizontalLine;
@property (nonatomic, strong) CALayer *verticalLine;
@property (nonatomic, strong) CALayer *separator;
/** 用于标记是否显示结构线 */
@property (nonatomic, assign) BOOL showStructureLine;

@end

@implementation BDFHomeCommentsCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _indenWidth = 30.f;
    CGFloat x = 0.f;
    CGFloat radius = 15.f;
    CGFloat maxWidth  = self.contentView.frame.size.width;
    CGFloat maxHeight = self.contentView.frame.size.height;
    
    // 禁用隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    if (_treeItem.level == 0) {
        x = 20.f;
        _horizontalLine.frame = CGRectZero;
    } else {
        x = (_treeItem.level) * (self.indenWidth) + 20;
        _horizontalLine.frame = CGRectMake(x - radius, 27.5f, 15.f, 1.f);
    }
    
    CGFloat verticalLineY = 16.f + radius * 2;
    CGFloat verticalLineWidth = (_treeItem.childItems.count == 0 || !_treeItem.isExpand) ? 0.f : 1.0f;
    
    _verticalLine.frame = CGRectMake(x + radius, verticalLineY, verticalLineWidth, maxHeight - verticalLineY);
    
    CGFloat containerHeight = (_showStructureLine) ? maxHeight : (maxHeight - 0.5f);
    //_containerView.frame = CGRectMake(x, 0.f, maxWidth - x, containerHeight);
    _separator.frame = CGRectMake(x, containerHeight, maxWidth - x, 0.5f);
    
    [CATransaction commit];
}

#pragma mark -- Setter && Getter
- (void)setShowStructureLine:(BOOL)showStructureLine
{
    _showStructureLine = showStructureLine;
    
    if (showStructureLine) {
        [_separator removeFromSuperlayer];
        _separator = nil;
        [self.contentView.layer addSublayer:self.horizontalLine];
        [self.contentView.layer addSublayer:self.verticalLine];
    } else {
        [_horizontalLine removeFromSuperlayer];
        [_verticalLine removeFromSuperlayer];
        _horizontalLine = nil;
        _verticalLine = nil;
        [self.contentView.layer addSublayer:self.separator];
    }
    [self drawStructureLine];
}

- (void)setCommentFrameModel:(BDFCommentFrameModel *)commentFrameModel {
    
    if (!commentFrameModel) {
        return;
    }
    _commentFrameModel = commentFrameModel;
    BDFHomeCommenntUserModel *user = commentFrameModel.commentModel.user;

    self.userImageView.frame = commentFrameModel.userImageF;
    self.userImageView.layerCornerRadius = CGRectGetWidth(commentFrameModel.userImageF) / 2.;
    [self.userImageView setImageWithString:user.img_url placeHolder:[UIImage imageNamed:@"tou_25"]];
    
    self.userNameLabel.frame = commentFrameModel.userNameF;
    self.userNameLabel.text = user.nick;
    
    self.timeLabel.frame = commentFrameModel.timeAndModuleF;
    NSString *stringTime = [BDFUntil cStringFromTimestamp:[NSString stringWithFormat:@"%ld",commentFrameModel.commentModel.created_time / 1000000]];
    self.timeLabel.text = [BDFUntil compareCurrentTime:stringTime];
    
    self.upsButton.frame = commentFrameModel.upsButtonF;
    NSInteger ups = commentFrameModel.commentModel.ups;
    if (ups > 0) {
        [self.upsButton setTitle:[NSString stringWithFormat:@"%ld",ups] forState:UIControlStateNormal];
    }
    
    self.dowsButton.frame = commentFrameModel.downButtonF;
    NSInteger downs = commentFrameModel.commentModel.downs;
    if (downs > 0) {
        [self.dowsButton setTitle:[NSString stringWithFormat:@"%ld",downs] forState:UIControlStateNormal];
    }
    self.contentLabel.frame = commentFrameModel.contentF;
    self.contentLabel.text = [NSString stringWithFormat:@"%@ %ld",commentFrameModel.commentModel.content, commentFrameModel.commentModel.id];
}

- (void)removeAllLineLayers
{
    NSArray<CALayer *> *subLayers = self.contentView.layer.sublayers;
    NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isMemberOfClass:[BDFCommentLayer class]];
    }]];
    [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
}

- (void)parentItem:(BDFCommentTreeItemModel *)pItem mutArray:(NSMutableArray<NSNumber *> *)mutArray
{
    if (pItem.level == 0) return;
    
    if (pItem.parentItem.childItems.lastObject == pItem) {
        [mutArray addObject:@(pItem.level - 1)];
    }
    [self parentItem:pItem.parentItem mutArray:mutArray];
}

- (void)drawStructureLine
{
    // 移除之前的结构线
    [self removeAllLineLayers];
    
    if (!_showStructureLine) return;
    
    // 由 treeItem 的父节点递归到根节点，寻找当前等级下的叶节点并保存
    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
    [self parentItem:_treeItem.parentItem mutArray:mutArray];
    
    CGFloat lineHeight = CGRectGetMaxY(self.commentFrameModel.contentF);
    
    for (NSInteger i = 0; i < _treeItem.level; i++) {
        // 若 treeItem 父节点为叶节点，则该 level 下不绘制结构线
        if ([mutArray containsObject:@(i)]) continue;
        
        CGFloat lineX = 0.f;
        
        if (i == 0) {
            lineX = 35.5f;
        } else if (i == 1) {
            lineX = 65.f;
        } else {
            lineX = 65.f + (i - 1) * (self.indenWidth);
        }
        // 判断 treeItem 是否为叶节点
        NSArray<BDFCommentTreeItemModel *> *items = _treeItem.parentItem.childItems;
        if ((items.lastObject == _treeItem) && i == _treeItem.level - 1) {
            lineHeight = 28.f;
        }
        // 绘制结构线
        BDFCommentLayer *otherLine = [BDFCommentLayer layer];
        otherLine.frame = CGRectMake(lineX, 0.f, 1.0, lineHeight);
        [self.contentView.layer addSublayer:otherLine];
    }
}

- (void)allKindOfButtonAction:(id)sender {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setTreeItem:(BDFCommentTreeItemModel *)treeItem {
    _treeItem = treeItem;
    
    self.commentFrameModel = treeItem.data;
    
    [self drawStructureLine];
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

- (CALayer *)horizontalLine {
    if (_horizontalLine == nil) {
        
        _horizontalLine = [CALayer layer];
        _horizontalLine.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    }
    return _horizontalLine;
}

- (CALayer *)verticalLine {
    if (_verticalLine == nil) {
        
        _verticalLine = [CALayer layer];
        _verticalLine.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00].CGColor;
    }
    return _verticalLine;
}

- (CALayer *)separator {
    if (_separator == nil) {
        
        _separator = [CALayer layer];
        _separator.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    return _separator;
}

@end
