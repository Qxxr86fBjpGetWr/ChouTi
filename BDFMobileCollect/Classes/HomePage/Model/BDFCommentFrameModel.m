//
//  BDFCommentFrameModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/4.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFCommentFrameModel.h"
#import "NSString+Size.h"

@implementation BDFCommentFrameModel

-(void)setDeep:(NSInteger)deep {
    if (!deep) {
        return;
    }
    _deep = deep;
}

-(void)setCommentModel:(BDFHomeCommenntModel *)commentModel {
    
    if (!commentModel) {
        return;
    }
    _commentModel = commentModel;
    
    CGFloat tap = 0;
    if (self.deep != 0) {
        tap = 30 * self.deep;
    }
    self.userImageF = CGRectMake(20 + tap, 10, 30, 30);
    self.userNameF = CGRectMake(CGRectGetMaxX(self.userImageF) + 10, CGRectGetMinY(self.userImageF), 80, 20);
    self.timeAndModuleF = CGRectMake(CGRectGetMaxX(self.userNameF), CGRectGetMinY(self.userNameF), 150, 20);
    
    CGFloat upsY = CGRectGetMinY(self.userNameF);
    CGFloat upsW = 30;
    CGFloat upsH = 30;
    CGFloat upsX = CGRectGetMaxX(self.timeAndModuleF);;
    self.upsButtonF = CGRectMake(upsX, upsY, upsW, upsH);
    
    self.downButtonF = CGRectMake(CGRectGetMaxX(self.upsButtonF), upsY, 30, 30);
    
    CGFloat contentX = CGRectGetMinX(self.userNameF);
    CGFloat contentY = CGRectGetMaxY(self.userNameF) + 10;
    CGFloat contentW = SCREEN_WIDTH - contentX - 50;
    CGSize contentSize = [commentModel.content sizeWithFont:[UIFont systemFontOfSize:BDFHomeNewsCommentFont] constrainedToWidth:contentW];
    CGFloat contentH = contentSize.height;
    self.contentF = CGRectMake(contentX, contentY, contentW, contentH);
}

@end
