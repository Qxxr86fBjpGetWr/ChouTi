//
//  BDFCommentTreeManager.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/13.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDFCommentTreeItemModel.h"

@interface BDFCommentTreeManager : NSObject

/** 获取可见的节点 */
@property (nonatomic, readonly, strong) NSMutableArray<BDFCommentTreeItemModel *> *showItems;

/**
 唯一初始化方法
 
 @param items 原始数据包装成 treeItems 数组
 @param level 折叠/展开等级，为 0 全部折叠，为 1 展开一级，以此类推，为 NSIntegerMax 全部展开
 @return treeManager 实例对象
 */
- (instancetype)initWithItems:(NSArray<BDFCommentTreeItemModel *> *)items andExpandLevel:(NSInteger)level;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/** 展开/收起 Item，返回所改变的 Item 的个数 */
- (NSInteger)expandItem:(BDFCommentTreeItemModel *)item;
- (NSInteger)expandItem:(BDFCommentTreeItemModel *)item isExpand:(BOOL)isExpand;
/** 展开/折叠到多少层级 */
- (void)expandItemWithLevel:(NSInteger)expandLevel completed:(void(^)(NSArray *noExpandArray))noExpandCompleted andCompleted:(void(^)(NSArray *expandArray))expandCompleted;
/** 根据 id 获取 item */
- (BDFCommentTreeItemModel *)getItemWithItemId:(NSNumber *)itemId;
/** 获取所有 items */
- (NSArray *)getAllItems;

@end
