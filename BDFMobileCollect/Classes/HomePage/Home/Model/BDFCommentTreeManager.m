//
//  BDFCommentTreeManager.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/13.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFCommentTreeManager.h"

@interface BDFCommentTreeManager() {
    BOOL _flag; // 判断是否需要计算等级的标识
}

@property (nonatomic, strong) NSDictionary *itemsMap;
@property (nonatomic, strong) NSMutableArray <BDFCommentTreeItemModel *>*topItems;
@property (nonatomic, strong) NSMutableArray <BDFCommentTreeItemModel *>*tmpItems;
@property (nonatomic, assign) NSInteger maxLevel;   // 最大等级
@property (nonatomic, assign) NSInteger showLevel;  // 展开的最大等级

@end

@implementation BDFCommentTreeManager

#pragma mark -- 初始化
- (instancetype)initWithItems:(NSArray<BDFCommentTreeItemModel *> *)items andExpandLevel:(NSInteger)level
{
    if (self = [super init]) {
        
        // 1. 建立 MAP
        [self setupItemsMapByItems:items];
        
        // 2. 建立父子关系，并得到顶级节点
        [self setupTopItems];
        
        // 3. 设置等级
        [self setupItemsLevel];
        
        // 4. 根据展开等级设置 showItems
        [self setupShowItemsWithShowLevel:level];
    }
    return self;
}

// 建立 MAP
- (void)setupItemsMapByItems:(NSArray *)items
{
    _flag = YES;
    NSMutableDictionary *itemsMap = @{}.mutableCopy;
    for (BDFCommentTreeItemModel *item in items) {
        [itemsMap setObject:item forKey:item.ID];
        if (item.level != -1) _flag = NO;
    }
    self.itemsMap = itemsMap.copy;
}

// 建立父子关系，并得到顶级节点
- (void)setupTopItems
{
    self.tmpItems = self.itemsMap.allValues.mutableCopy;
    
    // 建立父子关系
    NSMutableArray *topItems = @[].mutableCopy;
    for (BDFCommentTreeItemModel *item in self.tmpItems) {
        item.isExpand = YES;
        if ([item.parentID isKindOfClass:[NSString class]]) {
            BDFCommentTreeItemModel *parent = self.itemsMap[item.parentID];
            if (parent) {
                item.parentItem = parent;
                if (![parent.childItems containsObject:item]) {
                    [parent.childItems addObject:item];
                }
            }
        }
        if (!item.parentItem) [topItems addObject:item];
        if (!_flag) self.maxLevel = MAX(item.level, self.maxLevel);
    }
    // 排序
    self.topItems = [topItems sortedArrayUsingComparator:^NSComparisonResult(BDFCommentTreeItemModel *item1, BDFCommentTreeItemModel *item2) {
        return [item1.orderNo compare:item2.orderNo];
    }].mutableCopy;
}

// 设置等级
- (void)setupItemsLevel
{
    if (!_flag) return;
    
    for (BDFCommentTreeItemModel *item in self.tmpItems) {
        NSInteger tempLevel = 0;
        BDFCommentTreeItemModel *parent = item.parentItem;
        while (parent) {
            tempLevel ++;
            parent = parent.parentItem;
        }
        item.level = tempLevel;
        self.maxLevel = MAX(self.maxLevel, tempLevel);
    }
}

// 根据展开等级设置 showItems
- (void)setupShowItemsWithShowLevel:(NSInteger)level
{
    self.showLevel = MAX(level, 0);
    self.showLevel = MIN(level, self.maxLevel);
    
    NSMutableArray *showItems = @[].mutableCopy;
    for (BDFCommentTreeItemModel *item in self.topItems) {
        [self addItem:item toShowItems:showItems andAllowShowLevel:self.showLevel];
    }
    _showItems = showItems;
}

- (void)addItem:(BDFCommentTreeItemModel *)item toShowItems:(NSMutableArray *)showItems andAllowShowLevel:(NSInteger)level
{
    if (item.level > level) return;
    
    [showItems addObject:item];
    
    item.isExpand = (item.level != level);
    item.childItems = [item.childItems sortedArrayUsingComparator:^NSComparisonResult(BDFCommentTreeItemModel *item1, BDFCommentTreeItemModel *item2) {
        return [item1.orderNo compare:item2.orderNo];
    }].mutableCopy;
    
    for (BDFCommentTreeItemModel *childItem in item.childItems) {
        [self addItem:childItem toShowItems:showItems andAllowShowLevel:level];
    }
}

#pragma mark -- Expand Item
// 展开/收起 Item，返回所改变的 Item 的个数
- (NSInteger)expandItem:(BDFCommentTreeItemModel *)item
{
    return [self expandItem:item isExpand:!item.isExpand];
}

- (NSInteger)expandItem:(BDFCommentTreeItemModel *)item isExpand:(BOOL)isExpand
{
    if (item.isExpand == isExpand) return 0;
    
    item.isExpand = isExpand;
    NSMutableArray *tempMutArray = @[].mutableCopy;
    
    if (isExpand) { // 展开
        for (BDFCommentTreeItemModel *tempItem in item.childItems) {
            [self addItem:tempItem toTmpItems:tempMutArray];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self.showItems indexOfObject:item] + 1, tempMutArray.count)];
        [self.showItems insertObjects:tempMutArray atIndexes:indexSet];
    } else { // 折叠
        for (BDFCommentTreeItemModel *tempItem in self.showItems) {
            BOOL isParent = NO;
            BDFCommentTreeItemModel *parentItem = tempItem.parentItem;
            while (parentItem) {
                if (parentItem == item) {
                    isParent = YES;
                    break;
                }
                parentItem = parentItem.parentItem;
            }
            if (isParent) [tempMutArray addObject:tempItem];
        }
        [self.showItems removeObjectsInArray:tempMutArray];
    }
    
    return tempMutArray.count;
}

- (void)addItem:(BDFCommentTreeItemModel *)item toTmpItems:(NSMutableArray *)tmpItems
{
    [tmpItems addObject:item];
    
    item.childItems = [item.childItems sortedArrayUsingComparator:^NSComparisonResult(BDFCommentTreeItemModel *item1, BDFCommentTreeItemModel *item2) {
        return [item1.orderNo compare:item2.orderNo];
    }].mutableCopy;
    
    if (!item.isExpand) return;
    
    for (BDFCommentTreeItemModel *tmpItem in item.childItems) {
        [self addItem:tmpItem toTmpItems:tmpItems];
    }
}

// 展开/折叠到多少层级
- (void)expandItemWithLevel:(NSInteger)expandLevel completed:(void(^)(NSArray *noExpandArray))noExpandCompleted andCompleted:(void(^)(NSArray *expandArray))expandCompleted
{
    expandLevel = MAX(expandLevel, 0);
    expandLevel = MIN(expandLevel, self.maxLevel);
    
    // 先一级一级折叠
    for (NSInteger level = self.maxLevel; level >= expandLevel; level--) {
        NSMutableArray *itemsArray = @[].mutableCopy;
        for (NSInteger i = 0; i < self.showItems.count; i++) {
            BDFCommentTreeItemModel *item = self.showItems[i];
            if (item.isExpand && item.level == level) {
                [itemsArray addObject:item];
            }
        }
        if (itemsArray.count) {
            if (noExpandCompleted) {
                noExpandCompleted(itemsArray);
            }
        }
    }
    
    // 再一级一级展开
    for (NSInteger level = 0; level < expandLevel; level++) {
        NSMutableArray *itemsArray = @[].mutableCopy;
        for (NSInteger i = 0; i < self.showItems.count; i++) {
            BDFCommentTreeItemModel *item = self.showItems[i];
            if (!item.isExpand && item.level == level) {
                [itemsArray addObject:item];
            }
        }
        if (itemsArray.count) {
            if (expandCompleted) {
                expandCompleted(itemsArray);
            }
        }
    }
}

// 根据 id 获取 item
- (BDFCommentTreeItemModel *)getItemWithItemId:(NSNumber *)itemId
{
    return (itemId ? self.itemsMap[itemId] : nil);
}

// 获取所有 items
- (NSArray *)getAllItems
{
    return [self.itemsMap allValues];
}

@end
