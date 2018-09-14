//
//  BDFCommentFrameModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/5/4.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFCommentFrameModel.h"
#import "NSString+Size.h"
/*
{
    comments =     {
        actionMap =         {
            38754936 = 1;
            38754956 = 1;
            38755616 = 1;
            38755681 = 2;
            38755756 = 2;
            38755801 = 0;
            38755866 = 0;
            38755946 = 0;
            38755976 = 0;
            38756001 = 0;
            38756031 = 0;
            38756076 = 0;
            38756191 = 0;
        };
        childrenMap =         {
            38754936 = 1;
            38754956 = 1;
            38755616 = 1;
            38755681 = 2;
            38755756 = 2;
            38755801 = 0;
            38755866 = 0;
            38755946 = 0;
            38755976 = 0;
            38756001 = 0;
            38756031 = 0;
            38756076 = 0;
            38756191 = 0;
        };
        depthMap =         {
            38754936 = 0;
            38754956 = 1;
            38755616 = 2;
            38755681 = 0;
            38755756 = 0;
            38755801 = 0;
            38755866 = 1;
            38755946 = 1;
            38755976 = 0;
            38756001 = 0;
            38756031 = 3;
            38756076 = 1;
            38756191 = 1;
        };
        ids =         (
                       38755681,
                       38755866,
                       38755946,
                       38756001,
                       38755801,
                       38755756,
                       38756191,
                       38756076,
                       38756031,
                       38755976,
                       38755616,
                       38754956,
                       38754936
                       );
        scores =         {
            38754936 = "0.3790176";
            38754956 = "0.3790176";
            38755181 = "0.3790176";
            38755616 = "0.3790176";
            38755681 = "0.94279015";
            38755756 = "0.54969215";
            38755801 = "0.6467747700000001";
            38755866 = "0.7855049";
            38755891 = "0.3790176";
            38755946 = "0.7094211";
            38755976 = "0.3790176";
            38756001 = "0.6467747700000001";
            38756031 = "0.3790176";
            38756076 = "0.3790176";
            38756191 = "0.3790176";
        };
        timeMap =         {
            38754936 = 1536641012050000;
            38754956 = 1536641036173000;
            38755181 = 1536641398745000;
            38755616 = 1536642188545000;
            38755681 = 1536642336358000;
            38755756 = 1536642490101000;
            38755801 = 1536642581299000;
            38755866 = 1536642632017000;
            38755891 = 1536642653441000;
            38755946 = 1536642740708000;
            38755976 = 1536642793473000;
            38756001 = 1536642820480000;
            38756031 = 1536642893165000;
            38756076 = 1536642955335000;
            38756191 = 1536643155602000;
        };
        treeMap =         {
            38754936 =             (
                                    38754956
                                    );
            38754956 =             (
                                    38755616
                                    );
            38755616 =             (
                                    38756031
                                    );
            38755681 =             (
                                    38755866,
                                    38756191
                                    );
            38755756 =             (
                                    38755946,
                                    38756076
                                    );
        };
    };
    link =     {
        action = 1;
        "action_time" = 1536643377135000;
        commentHavePicture = 0;
        "comments_count" = 13;
        "created_time" = 1536640907422000;
        fetchType = 0;
        "has_saved" = 0;
        "has_uped" = 0;
        id = 22024501;
        "img_url" = "http://img3.chouti.com/CHOUTI_20180911/D1FF8F8F71D140429D25E0FB85CBB3D8_W200H200.png";
        "is_break" = 0;
        "is_top" = 0;
        noComments = 0;
        originalUrl = "https://money.163.com/18/0911/11/DRE0KF01002581PP.html";
        "original_img_url" = "http://img3.chouti.com/CHOUTI_20180911/82247E64CE0A439B9954BAD19CF57B0B_W180H180.jpg";
        pool = 1;
        score = "8951.868804992691";
        "subject_id" = 100;
        "submitted_user" =         {
            "comments_count" = 0;
            "img_url" = "http://img3.chouti.com/CHOUTI_20180410/ABD2B1E338C541B6893E2C6ACC4BDDEC_W290H290.jpg";
            isBindPhone = 1;
            jid = wangxiannatou;
            "liked_count" = 0;
            nick = "\U7f51\U7ebf\U90a3\U5934\U7684\U5927\U4ef6\U4e8b";
            "save_count" = 0;
            sex = 1;
            "submitted_count" = 0;
        };
        "time_into_pool" = 1536641999980000;
        title = "\U7f51\U6613\U8d22\U7ecf\U9891\U9053\U51b3\U5b9a\U81ea9\U670811\U65e512\U65f6\U8d77\U505c\U6b62\U66f4\U65b0\Uff1a\U8fdb\U884c\U6df1\U5165\U5168\U9762\U7684\U6574\U6539\Uff0c\U5927\U529b\U6574\U987f\U8fdd\U89c4\U884c\U4e3a\U3002";
        ups = 13;
        url = "https://money.163.com/18/0911/11/DRE0KF01002581PP.html";
    };
}
*/

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
    CGFloat upsW = 50;
    CGFloat upsH = 30;
    CGFloat upsX = SCREEN_WIDTH - 100;
    self.upsButtonF = CGRectMake(upsX, upsY, upsW, upsH);
    
    self.downButtonF = CGRectMake(CGRectGetMaxX(self.upsButtonF), upsY, 50, 30);
    
    CGFloat contentX = CGRectGetMinX(self.userNameF);
    CGFloat contentY = CGRectGetMaxY(self.userNameF) + 10;
    CGFloat contentW = SCREEN_WIDTH - contentX - 50;
    CGSize contentSize = [commentModel.content sizeWithFont:[UIFont systemFontOfSize:BDFHomeNewsCommentFont] constrainedToWidth:contentW];
    CGFloat contentH = contentSize.height;
    self.contentF = CGRectMake(contentX, contentY, contentW, contentH);
}

- (void)setIndexModel:(BDFHomeCommentIndexModel *)indexModel {
    if (!indexModel) {
        return;
    }
    if (self.deep <= 0) {
        self.hasParent = NO;
    }else {
        self.hasParent = YES;
    }
    
    NSString *commentId = [NSString stringWithFormat:@"%ld", self.commentModel.id];
    NSInteger childCount = (NSInteger)indexModel.comments.childrenMap[commentId];
    if (childCount > 0) {
        self.hasChild = YES;
    }else {
        self.hasChild = NO;
    }
    
}

@end
