//
//  BDFMeCommentFrameModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/15.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMeCommentFrameModel.h"
#import "NSString+Size.h"

@implementation BDFMeCommentFrameModel

- (void)setModel:(BDFMeCommentsCommentModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    CGFloat timeLabelX = 10;
    CGFloat timeLabelY = 10;
    CGFloat timeLabelW = 50;
    CGFloat timeLabelH = 20;
    self.timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat space = 20;
    CGFloat downLabelX = SCREEN_WIDTH - 20;
    CGFloat downLabelW = 30;
    CGFloat downLabelH = 20;
    CGFloat downLabelY = CGRectGetMinY(_timeLabelF);
    self.downLabelF = CGRectMake(downLabelX, downLabelY, downLabelW, downLabelH);
    
    self.likeLabelF = CGRectMake(downLabelX - downLabelW - space, downLabelY, downLabelW, downLabelH);
    
    CGFloat commentLabelY = CGRectGetMaxY(_timeLabelF);
    CGFloat commentLabelW = SCREEN_WIDTH - 2 * space;
    CGFloat commentLabelH = [model.content sizeWithFont:[UIFont systemFontOfSize:BDFHomeNewsCommentFont] constrainedToWidth:commentLabelW].height;
    self.commentLabelF = CGRectMake(timeLabelX, commentLabelY + space, commentLabelW, commentLabelH);
    
    CGFloat textLabelY = CGRectGetMaxY(self.commentLabelF);
    CGFloat textLabelH = 50;
    self.textLabelF = CGRectMake(timeLabelX, textLabelY + 20, commentLabelW, textLabelH);
}

@end
