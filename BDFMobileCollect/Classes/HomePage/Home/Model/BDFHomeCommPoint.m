//
//  BDFHomeCommPoint.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/10.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeCommPoint.h"

@implementation BDFHomeCommPoint

- (instancetype)initWithParentId : (NSInteger)parentId nodeId : (NSInteger)nodeId depth : (int)depth hasNextNode : (BOOL)hasNext isParent:(BOOL)isParent {
    self = [self init];
    if (self) {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.depth = depth;
        self.hasNextNode = hasNext;
        self.isParent = isParent;
    }
    return self;
}

@end
