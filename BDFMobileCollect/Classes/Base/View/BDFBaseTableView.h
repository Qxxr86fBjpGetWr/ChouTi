//
//  BDFBaseTableView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BDFBaseTableViewRowAnimation) {
    Fade      = UITableViewRowAnimationFade,
    Right     = UITableViewRowAnimationRight,
    Left      = UITableViewRowAnimationLeft,
    Top       = UITableViewRowAnimationTop,
    Bottom    = UITableViewRowAnimationBottom,
    None      = UITableViewRowAnimationNone,
    Middle    = UITableViewRowAnimationMiddle,
    Automatic = 100
};

@class BDFBaseTableViewCell;

@interface BDFBaseTableView : UITableView

#pragma mark -创建cell

/**
 *  刷新UITableVIew，有block
 */
-(void)updataWithUpdataBlock:(void(^)(BDFBaseTableView *tableView))updataBlock;

/**
 *  注册普通的UITableViewCell
 */
-(void)bdf_cellRegisterWithClass:(Class)cellClass identifier:(NSString *)identify;
/**
 *  从Xib创建UITableViewCell
 */
-(void)bdf_nibRegisterWithClass:(Class)nibClass identifier:(NSString *)identify;

/**
 *  根据indePath获取cell
 */
-(UITableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath;


/** 注册一个普通的UITableViewHeaderFooterView*/
- (void)bdf_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier;

/** 注册一个从xib中加载的UITableViewHeaderFooterView*/
- (void)bdf_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier;

#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果行不存在，默认insert操作
/** 刷新单行、动画默认*/
- (void)bdf_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 刷新单行、动画默认*/
- (void)bdf_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BDFBaseTableViewRowAnimation)animation;

/** 刷新多行、动画默认*/
- (void)bdf_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 刷新多行、动画默认*/
- (void)bdf_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BDFBaseTableViewRowAnimation)animation;

/** 刷新某个section、动画默认*/
- (void)bdf_reloadSingleSection:(NSInteger)section;

/** 刷新某个section、动画自定义*/
- (void)bdf_reloadSingleSection:(NSInteger)section animation:(BDFBaseTableViewRowAnimation)animation;

/** 刷新多个section、动画默认*/
- (void)bdf_reloadSections:(NSArray <NSNumber *>*)sections;

/** 刷新多个section、动画自定义*/
- (void)bdf_reloadSections:(NSArray <NSNumber *>*)sections animation:(BDFBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行删除操作
/** 删除单行、动画默认*/
- (void)bdf_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 删除单行、动画自定义*/
- (void)bdf_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BDFBaseTableViewRowAnimation)animation;

/** 删除多行、动画默认*/
- (void)bdf_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 删除多行、动画自定义*/
- (void)bdf_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BDFBaseTableViewRowAnimation)animation;

/** 删除某个section、动画默认*/
- (void)bdf_deleteSingleSection:(NSInteger)section;

/** 删除某个section、动画自定义*/
- (void)bdf_deleteSingleSection:(NSInteger)section animation:(BDFBaseTableViewRowAnimation)animation;

/** 删除多个section*/
- (void)bdf_deleteSections:(NSArray <NSNumber *>*)sections;

/** 删除多个section*/
- (void)bdf_deleteSections:(NSArray <NSNumber *>*)sections animation:(BDFBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行增加操作
/** 增加单行 动画无*/
- (void)bdf_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 增加单行，动画自定义*/
- (void)bdf_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BDFBaseTableViewRowAnimation)animation;

/** 增加单section，动画无*/
- (void)bdf_insertSingleSection:(NSInteger)section;

/** 增加单section，动画自定义*/
- (void)bdf_insertSingleSection:(NSInteger)section animation:(BDFBaseTableViewRowAnimation)animation;

/** 增加多行，动画无*/
- (void)bdf_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 增加多行，动画自定义*/
- (void)bdf_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BDFBaseTableViewRowAnimation)animation;

/** 增加多section，动画无*/
- (void)bdf_insertSections:(NSArray <NSNumber *>*)sections;

/** 增加多section，动画自定义*/
- (void)bdf_insertSections:(NSArray <NSNumber *>*)sections animation:(BDFBaseTableViewRowAnimation)animation;

@end
