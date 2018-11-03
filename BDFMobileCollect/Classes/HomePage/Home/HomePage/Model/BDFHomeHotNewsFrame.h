//
//  BDFHomeHotNewsFrame.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/4/19.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import "BDFBaseModel.h"
#import "BDFHomeHotNewsModel.h"

@interface BDFHomeHotNewsFrame : BDFBaseModel

@property (nonatomic, strong) BDFHomeHotNewsModelLink *hotNewsModel;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect mainImageF;

@property (nonatomic, assign) CGRect userImageF;

@property (nonatomic, assign) CGRect userNameF;

@property (nonatomic, assign) CGRect timeAndModuleF;

@property (nonatomic, assign) CGRect upsButtonF;

@property (nonatomic, assign) CGRect commentButtonF;

@property (nonatomic, assign) CGRect likeButtonF;

@property (nonatomic, assign) CGRect shareButtomF;

@end
