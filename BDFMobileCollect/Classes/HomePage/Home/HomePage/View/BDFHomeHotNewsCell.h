//
//  BDFHomeHotNewsCell.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableViewCell.h"
#import "BDFHomeHotNewsFrame.h"
#import "BDFBaseImageView.h"

typedef NS_ENUM(NSUInteger, BDFHomeTableViewCellItemType) {
    /** 点赞*/
    BDFHomeTableViewCellItemTypeLike = 1,
    /** 喜欢*/
    BDFHomeTableViewCellItemTypeCollection,
    /** 评论*/
    BDFHomeTableViewCellItemTypeComment,
    /** 分享*/
    BDFHomeTableViewCellItemTypeShare
};

@class BDFHomeHotNewsCell;

@protocol BDFHomeHotNewsCellButtonDelegate <NSObject>

/** 底部Item */
- (void)homeTableViewCell:(BDFHomeHotNewsCell *)cell didClickItemWithType:(BDFHomeTableViewCellItemType)itemType;

/** 查看大图 */
- (void)homeTableViewCell:(BDFHomeHotNewsCell *)cell didClickImageView:(BDFBaseImageView *)image currentIndex:(NSInteger)currentIndex urls:(NSArray <NSURL *>*)urls;

@end

@interface BDFHomeHotNewsCell : BDFBaseTableViewCell

@property (nonatomic,weak) id<BDFHomeHotNewsCellButtonDelegate> buttonDelegate;

@property (nonatomic, strong) BDFHomeHotNewsFrame *newsFrame;

- (void)ups;

- (void)collection;

@end
