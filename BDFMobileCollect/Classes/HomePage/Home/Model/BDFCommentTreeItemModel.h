//
//  BDFCommentTreeItemModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/13.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFCommentFrameModel.h"

@interface BDFCommentTreeItemModel : BDFBaseModel

@property (nonatomic, readonly, copy) NSString *ID;         // 唯一标识
@property (nonatomic, readonly, copy) NSString *parentID;   // 父级节点唯一标识
@property (nonatomic, readonly, copy) NSString *orderNo;    // 序号
@property (nonatomic, readonly, assign) CGFloat itemHeight; // cell的行高
@property (nonatomic, readonly, strong) BDFCommentFrameModel *data;            // 完整数据，可以是数据模型
@property (nonatomic, assign) NSInteger level;              // 层级
@property (nonatomic, assign) BOOL isExpand;                // 是否为展开状态
@property (nonatomic, weak)   BDFCommentTreeItemModel *parentItem;
@property (nonatomic, strong) NSMutableArray <BDFCommentTreeItemModel *> *childItems;

/**
 初始化方法
 
 @param ID 唯一标识
 @param pID 父级节点唯一标识
 @param orderNo 序号
 @param level 层级
 @param height cell的行高
 @param data 完整数据，可以是数据模型
 @return item实例
 */
- (instancetype)initWithID:(NSString *)ID
                  parentID:(NSString *)pID
                   orderNo:(NSString *)orderNo
                     level:(NSInteger)level
                itemHeight:(CGFloat)height
                      data:(id)data;

/** 后台数据未返回 level 时，可使用此初始化方法 */
- (instancetype)initWithID:(NSString *)ID
                  parentID:(NSString *)pID
                   orderNo:(NSString *)orderNo
                      data:(id)data;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
