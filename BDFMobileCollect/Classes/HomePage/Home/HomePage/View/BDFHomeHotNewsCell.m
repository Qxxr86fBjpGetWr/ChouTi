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
#import "UIView+Tap.h"
#import "UIView+Frame.h"
#import <ADTickerLabel.h>
#import "NSString+Html.h"

@interface BDFHomeHotNewsCell()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) BDFBaseImageView *mainImageView;

@property (nonatomic, weak) BDFBaseImageView *userImageView;

@property (nonatomic, weak) UILabel *userNameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, strong) BDFHomeHotNewsModelLink *hotNewsModel;

/** 顶 */
@property (nonatomic, weak) UIButton *upsButton;
/** 评论 */
@property (nonatomic, weak) UIButton *commentButton;
/** 收藏 */
@property (nonatomic, weak) UIButton *likeButton;
/** 分享 */
@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) ADTickerLabel *upsTickerLabel;

@property (nonatomic, weak) ADTickerLabel *commentTickerLabel;

@end

@implementation BDFHomeHotNewsCell

- (void)setNewsFrame:(BDFHomeHotNewsFrame *)newsFrame {
    if (!newsFrame) {
        return;
    }
    _newsFrame = newsFrame;
    self.hotNewsModel = newsFrame.hotNewsModel;
    
    self.titleLabel.frame = newsFrame.contentF;
//    NSMutableAttributedString *attTitle = [NSString attributeStringByHtmlString:self.hotNewsModel.title].mutableCopy;
//    [attTitle addAttribute:NSFontAttributeName value:kFont(16)
//                     range:NSMakeRange(0, attTitle.length)];
//    [attTitle addAttribute:NSKernAttributeName value:@1
//                     range:NSMakeRange(0, attTitle.length)];
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//    paragraph.lineSpacing = 5;
//    [attTitle addAttribute:NSParagraphStyleAttributeName value:paragraph
//                     range:NSMakeRange(0, attTitle.length)];
    self.titleLabel.text = self.hotNewsModel.title;
    
    self.mainImageView.frame = newsFrame.mainImageF;
    //self.mainImageView.shadowColor = kGrayColor;
    [self.mainImageView setImageWithString:self.hotNewsModel.img_url placeHolder:[UIImage imageNamed:@"chou_chou"]];
    
    self.upsButton.frame = newsFrame.upsButtonF;
    self.upsTickerLabel.text = [NSString stringWithFormat:@"%ld",_hotNewsModel.ups];
    [self.upsTickerLabel sizeToFit];
    self.upsButton.selected = self.hotNewsModel.has_uped;
    
    self.commentButton.frame = newsFrame.commentButtonF;
    self.commentTickerLabel.text = [NSString stringWithFormat:@"%ld",_hotNewsModel.comments_count];
    [self.commentTickerLabel sizeToFit];
    
    self.likeButton.frame = newsFrame.likeButtonF;
    self.likeButton.selected = self.hotNewsModel.has_saved;
    
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

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height -= 5;
    frame.size.width -= 0;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -
- (void)homeDidClickItemWithType:(BDFHomeTableViewCellItemType)itemType {
    if ([self.buttonDelegate respondsToSelector:@selector(homeTableViewCell:didClickItemWithType:)]) {
        [self.buttonDelegate homeTableViewCell:self didClickItemWithType:itemType];
    }
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
        WeakSelf(weakSelf);
        [imageView setTapActionWithBlock:^{
            if ([weakSelf.buttonDelegate respondsToSelector:@selector(homeTableViewCell:didClickImageView:currentIndex:urls:)]) {
                [weakSelf.buttonDelegate homeTableViewCell:weakSelf didClickImageView:_mainImageView currentIndex:0 urls:@[_hotNewsModel.img_url]];
            }
        }];
        [self.contentView addSubview:imageView];
        _mainImageView = imageView;
    }
    return _mainImageView;
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
//- (BDFCommentToolView *)toolView {
//    if (!_toolView) {
//        BDFCommentToolView *view = [[BDFCommentToolView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        view.buttonDelegate = self;
//        _toolView = view;
//        [self addSubview:view];
//    }
//    return _toolView;
//}

-(void)ups {
    self.upsButton.selected = !self.upsButton.selected;
    self.upsTickerLabel.text = [NSString stringWithFormat:@"%ld",self.hotNewsModel.ups];
    [self buttonAnimation:self.upsButton];
}

- (void)collection {
    self.likeButton.selected = !self.likeButton.selected;
    [self buttonAnimation:self.likeButton];
}

- (void)buttonAnimation:(UIButton *)button {
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
             button.imageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            button.imageView.transform = CGAffineTransformIdentity;
        }];
    } completion:nil];
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
        [self addSubview:button];
        _upsButton = button;
    }
    return _upsButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [button setTitleColor:kGrayColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allKindOfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _commentButton = button;
    }
    return _commentButton;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_collection"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_collection_pre"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(allKindOfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _likeButton = button;
    }
    return _likeButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_reply"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allKindOfButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _shareButton = button;
    }
    return _shareButton;
}

- (void)allKindOfButtonAction:(id)sender {
    BDFHomeTableViewCellItemType itemType;
    if (sender == _upsButton) {
        itemType = BDFHomeTableViewCellItemTypeLike;
    }else if (sender == _commentButton) {
        itemType = BDFHomeTableViewCellItemTypeComment;
    }else if (sender == _likeButton) {
        itemType = BDFHomeTableViewCellItemTypeCollection;
    }else if (sender == _shareButton) {
        itemType = BDFHomeTableViewCellItemTypeShare;
    }else {
        return;
    }
    if ([self.buttonDelegate respondsToSelector:@selector(homeTableViewCell:didClickItemWithType:)]) {
        [self.buttonDelegate homeTableViewCell:self didClickItemWithType:itemType];
    }
}

- (ADTickerLabel *)upsTickerLabel {
    if (!_upsTickerLabel) {
        ADTickerLabel *label = [[ADTickerLabel alloc] initWithFrame:CGRectMake(_newsFrame.upsButtonF.size.width - 30, (_newsFrame.upsButtonF.size.height - 16)/2., 30, 16)];
        label.font = [UIFont boldSystemFontOfSize:14.];
        label.textColor = kGrayColor;
        label.changeTextAnimationDuration = 0.;
        [self.upsButton addSubview:label];
        [self.upsButton bringSubviewToFront:label];
        _upsTickerLabel = label;
    }
    return _upsTickerLabel;
}

-(ADTickerLabel *)commentTickerLabel {
    if (!_commentTickerLabel) {
        ADTickerLabel *label = [[ADTickerLabel alloc] initWithFrame:CGRectMake(_newsFrame.commentButtonF.size.width - 30, (_newsFrame.commentButtonF.size.height - 16)/2., 30, 16)];
        label.font = [UIFont boldSystemFontOfSize:14.];
        label.textColor = kGrayColor;
        label.changeTextAnimationDuration = 0;
        [self.commentButton addSubview:label];
        [self.commentButton bringSubviewToFront:label];
        _commentTickerLabel = label;
    }
    return _commentTickerLabel;
}

@end
