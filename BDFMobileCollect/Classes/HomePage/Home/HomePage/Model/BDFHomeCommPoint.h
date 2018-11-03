//
//  BDFHomeCommPoint.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/10.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDFHomeCommPoint : NSObject

@property (nonatomic , assign) NSInteger parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) NSInteger nodeId;//本节点的id

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL hasNextNode;//该节点是否有下级节点

@property (nonatomic, assign) BOOL isParent;//

- (instancetype)initWithParentId : (NSInteger)parentId nodeId : (NSInteger)nodeId depth : (int)depth hasNextNode : (BOOL)hasNext isParent:(BOOL)isParent;

@end
