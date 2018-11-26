//
//  BDFMessaageWarnFrameModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFMessaageWarnFrameModel.h"
#import "NSString+Size.h"

@implementation BDFMessaageWarnFrameModel

- (void)setDataModel:(BDFMessageWarnDataModel *)dataModel {
    _dataModel = dataModel;
    
    CGFloat headImageY = 10;
    CGFloat headImageX = 10;
    self.headImageR = CGRectMake(headImageX, headImageY, 20, 20);
    
    CGFloat nickNameX = CGRectGetMaxX(self.headImageR);
    CGFloat nickNameH = 20;
    CGFloat nickNameW = [dataModel.fromUser.nick widthWithFont:kFont(13) constrainedToHeight:nickNameH];
    self.nickNameR = CGRectMake(nickNameX + 10, headImageY, nickNameW, nickNameH);
    
    CGFloat timeX = CGRectGetMaxX(self.nickNameR);
    CGFloat timeY = headImageY;
    CGFloat timeW = 100;
    CGFloat timeH = nickNameH;
    self.timeR = CGRectMake(timeX + 10, timeY, timeW, timeH);
    
    CGFloat commentX = headImageX;
    CGFloat commentY = CGRectGetMaxY(self.headImageR);
    CGFloat commentW = SCREEN_WIDTH - commentX * 2;
    CGFloat commentH = [dataModel.content heightWithFont:kFont(13) constrainedToWidth:commentW];
    self.commentR = CGRectMake(commentX, commentY + 20, commentW, commentH);
    
    CGFloat linkX = commentX;
    CGFloat linkY = CGRectGetMaxY(self.commentR);
    CGFloat linkW = commentW;
    CGFloat linkH = [dataModel.parentComments.content heightWithFont:kFont(13) constrainedToWidth:linkW];
    self.linkR = CGRectMake(linkX, linkY + 20, linkW, linkH + 20);

}

@end
