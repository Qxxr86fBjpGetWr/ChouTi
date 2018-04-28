//
//  BDFBaseTableView.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableView.h"

@implementation BDFBaseTableView

-(void)bdf_cellRegisterWithClass:(Class)cellClass identifier:(NSString *)identify {
    if (cellClass && identify) {
        [self registerClass:cellClass forCellReuseIdentifier:identify];
    }
}

-(void)bdf_nibRegisterWithClass:(Class)nibClass identifier:(NSString *)identify {
    if (nibClass && identify) {
        UINib *nib = [UINib nibWithNibName:[nibClass description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:identify];
    }
}

-(void)updataWithUpdataBlock:(void (^)(BDFBaseTableView *))updataBlock {
    [self beginUpdates];
    updataBlock(self);
    [self endUpdates];
}

-(UITableViewCell *)bdf_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return  nil;
    }
    
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
        return nil;
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];
}


/** 注册一个普通的UITableViewHeaderFooterView*/
- (void)bdf_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier {
    if (headerFooterClass && identifier.length) {
        [self registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}
/** 注册一个从xib中加载的UITableViewHeaderFooterView*/
- (void)bdf_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier {
    if (headerFooterNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[headerFooterNib description] bundle:nil];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:nibIdentifier];
    };
}

- (void)bdf_updateWithUpdateBlock:(void (^)(BDFBaseTableView *tableView))updateBlock {
    if (updateBlock) {
        [self beginUpdates];
        updateBlock(self);
        [self endUpdates];
    }
}

/** 刷新单行、动画默认*/
- (void)bdf_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self bdf_reloadSingleRowAtIndexPath:indexPath animation:None];
}
- (void)bdf_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BDFBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 刷新多行、动画默认*/
- (void)bdf_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self bdf_reloadRowsAtIndexPaths:indexPaths animation:None];
}

- (void)bdf_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BDFBaseTableViewRowAnimation)animation {
    if (!indexPaths.count) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf bdf_reloadSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 刷新某个section、动画默认*/
- (void)bdf_reloadSingleSection:(NSInteger)section {
    [self bdf_reloadSingleSection:section animation:None];
}

- (void)bdf_reloadSingleSection:(NSInteger)section animation:(BDFBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 刷新多个section、动画默认*/
- (void)bdf_reloadSections:(NSArray <NSNumber *>*)sections {
    [self bdf_reloadSections:sections animation:None];
}
- (void)bdf_reloadSections:(NSArray<NSNumber *> *)sections animation:(BDFBaseTableViewRowAnimation)animation {
    if (!sections.count) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf bdf_reloadSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 删除单行、动画默认*/
- (void)bdf_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self bdf_deleteSingleRowAtIndexPath:indexPath animation:Fade];
}

- (void)bdf_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BDFBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    
    NSLog(@"sectionNumber %ld  section%ld rowNumber%ld",sectionNumber, section , rowNumber);
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"删除row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 删除多行、动画默认*/
- (void)bdf_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self bdf_deleteRowsAtIndexPaths:indexPaths animation:Fade];
}

- (void)bdf_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BDFBaseTableViewRowAnimation)animation {
    if (!indexPaths.count) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf bdf_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 删除某个section、动画默认*/
- (void)bdf_deleteSingleSection:(NSInteger)section {
    
    [self bdf_deleteSingleSection:section animation:Fade];
}

- (void)bdf_deleteSingleSection:(NSInteger)section animation:(BDFBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 删除多个section*/
- (void)bdf_deleteSections:(NSArray *)sections {
    [self bdf_deleteSections:sections animation:Fade];
}

- (void)bdf_deleteSections:(NSArray<NSNumber *> *)sections animation:(BDFBaseTableViewRowAnimation)animation {
    if (!sections.count) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf bdf_deleteSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 增加单行 动画无*/
- (void)bdf_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self bdf_insertSingleRowAtIndexPath:indexPath animation:None];
}

/** 增加单行，动画自定义*/
- (void)bdf_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BDFBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section > sectionNumber || section < 0) {
        // section 越界
        NSLog(@"section 越界 : %ld", section);
    } else if (row > rowNumber || row < 0) {
        NSLog(@"row 越界 : %ld", row);
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
    
}

/** 增加单section，动画无*/
- (void)bdf_insertSingleSection:(NSInteger)section {
    [self bdf_insertSingleSection:section animation:None];
}
/** 增加单section，动画自定义*/
- (void)bdf_insertSingleSection:(NSInteger)section animation:(BDFBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        // section越界
        NSLog(@" section 越界 : %ld", section);
    } else {
        [self beginUpdates];
        [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 增加多行，动画无*/
- (void)bdf_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self bdf_insertRowsAtIndexPaths:indexPaths animation:None];
}
/** 增加多行，动画自定义*/
- (void)bdf_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BDFBaseTableViewRowAnimation)animation {
    if (indexPaths.count == 0) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf bdf_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 增加多section，动画无*/
- (void)bdf_insertSections:(NSArray <NSNumber *>*)sections {
    [self bdf_insertSections:sections animation:None];
}
/** 增加多section，动画默认*/
- (void)bdf_insertSections:(NSArray <NSNumber *>*)sections animation:(BDFBaseTableViewRowAnimation)animation {
    if (sections.count == 0) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf bdf_insertSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 当有输入框的时候 点击tableview空白处，隐藏键盘*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}


@end
