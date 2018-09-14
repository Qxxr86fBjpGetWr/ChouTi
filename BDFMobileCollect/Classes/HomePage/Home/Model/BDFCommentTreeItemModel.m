//
//  BDFCommentTreeItemModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/9/13.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFCommentTreeItemModel.h"

@implementation BDFCommentTreeItemModel

- (instancetype)initWithID:(NSString *)ID
                  parentID:(NSString *)pID
                   orderNo:(NSString *)orderNo
                      data:(id)data
{
    return [self initWithID:ID
                   parentID:pID
                    orderNo:orderNo
                      level:-1
                 itemHeight:0.f
                       data:data];
}

- (instancetype)initWithID:(NSString *)ID
                  parentID:(NSString *)pID
                   orderNo:(NSString *)orderNo
                     level:(NSInteger)level
                itemHeight:(CGFloat)height
                      data:(id)data
{
    if (self = [super init]) {
        // 赋值
        _ID = ID;
        _parentID = pID;
        _orderNo = orderNo;
        _level = level;
        _itemHeight = (height <= 0.f) ? 44.f : height;
        _data = data;
        // 默认值
        _isExpand = NO;
        _childItems = @[].mutableCopy;
    }
    return self;
}

@end
