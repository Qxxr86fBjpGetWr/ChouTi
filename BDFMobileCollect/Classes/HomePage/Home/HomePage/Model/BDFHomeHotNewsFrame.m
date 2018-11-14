//
//  BDFHomeHotNewsFrame.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeHotNewsFrame.h"
#import "NSString+Size.h"
#import "NSAttributedString+Size.h"
#import "BDFUntil.h"

@implementation BDFHomeHotNewsFrame

-(void)setHotNewsModel:(BDFHomeHotNewsModelLink *)hotNewsModel {
    
    if (!hotNewsModel) {
        return;
    }
    _hotNewsModel = hotNewsModel;
    
    CGFloat mainImageY = 5;
    CGFloat mainImageW = 80;
    CGFloat mainImageH = 80;
    CGFloat mainImageX = SCREEN_WIDTH - 10 - mainImageW;
    self.mainImageF = CGRectMake(mainImageX, mainImageY, mainImageW, mainImageH);
    
    CGFloat topicX = 10;
    CGFloat topicY = 5;
    CGFloat topicH = 0;
    CGFloat topicW = 0;
    if (!NULLString(hotNewsModel.topicName)) {
        NSString *topicName = [NSString stringWithFormat:@"  #%@#  ", hotNewsModel.topicName];
        hotNewsModel.topicName = topicName;
        topicW = [topicName sizeWithFont:[UIFont systemFontOfSize:BDFHomeNewsCommentFont] constrainedToHeight:topicH].width;
        topicH = 20;
    }
    self.topicButtonF = CGRectMake(topicX, topicY, topicW, topicH);
    
    NSAttributedString *attributeTitle = [BDFUntil handAttributeWithText:hotNewsModel.title];
    CGFloat contentX = 10;
    CGFloat contentY = CGRectGetMaxY(self.topicButtonF) + 10;
    CGFloat contentW = mainImageX - 20;
    CGFloat contentH = [attributeTitle heightWithConstrainedWidth:contentW];
    self.contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat linkY = 0;
    CGFloat linkW = 0;
    CGFloat linkH = 0;
    if (!NULLString(hotNewsModel.url) && ![hotNewsModel.url containsString:@"dig.chouti.com"]) {
        linkY += CGRectGetMaxY(self.contentF) + 10;
        linkW = contentW / 2.;
        linkH = 20;
    }
    self.linkButtonF = CGRectMake(contentX, linkY, linkW, linkH);
    
    /** 图片滚动视图 */
    CGFloat picturesViewY = linkY > 0 ? CGRectGetMaxY(self.linkButtonF) : CGRectGetMaxY(self.contentF);
    CGFloat picturesViewH = 0;
    CGFloat picturesViewW = 0;
    if (!NULLArray(hotNewsModel.multigraphList)) {
        if (hotNewsModel.multigraphList.count <=2) {
            picturesViewH = 160;
        } else {
            picturesViewH = 100;
        }
        picturesViewW = SCREEN_WIDTH;
        self.mainImageF = CGRectZero;
    }
    self.picturesViewF = CGRectMake(10, picturesViewY + 20, picturesViewW, picturesViewH);
    
    CGFloat userImageY = CGRectGetMaxY(self.picturesViewF);
    self.userImageF = CGRectMake(contentX, userImageY + 20, 30, 30);
    
    self.userNameF = CGRectMake(CGRectGetMaxX(self.userImageF) + 10, CGRectGetMinY(self.userImageF), 150, 20);
    
    self.timeAndModuleF = CGRectMake(CGRectGetMinX(self.userNameF), CGRectGetMaxY(self.userNameF), 150, 10);
    
    CGFloat upsY = 0;
    if (CGRectGetMaxY(self.timeAndModuleF) > mainImageH) {
        upsY = CGRectGetMaxY(self.timeAndModuleF);
    }else {
        upsY = CGRectGetMaxY(self.mainImageF);
    }
    
    CGFloat upsW = SCREEN_WIDTH / 4.;
    CGFloat upsH = 64;
    CGFloat upsX = 0;
    self.upsButtonF = CGRectMake(upsX, upsY, upsW, upsH);
    
    self.commentButtonF = CGRectMake(upsX + upsW, upsY, upsW, upsH);
    self.likeButtonF = CGRectMake(self.commentButtonF.origin.x + self.commentButtonF.size.width, upsY, upsW, upsH);
    self.shareButtomF = CGRectMake(self.likeButtonF.origin.x + self.likeButtonF.size.width, upsY, upsW, upsH);
}

@end
