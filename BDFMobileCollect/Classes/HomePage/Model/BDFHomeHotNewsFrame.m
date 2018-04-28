//
//  BDFHomeHotNewsFrame.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFHomeHotNewsFrame.h"
#import "NSString+Size.h"

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
    
    CGFloat contentX = 10;
    CGFloat contentY = 5;
    CGFloat contentW = mainImageX - 20;
    CGFloat contentH = [hotNewsModel.title sizeWithFont:[UIFont systemFontOfSize:BDFHomeNewsTextFont] constrainedToWidth:contentW].height;
    self.contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    self.userImageF = CGRectMake(contentX, CGRectGetMaxY(self.contentF) + 30, 30, 30);
    
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
