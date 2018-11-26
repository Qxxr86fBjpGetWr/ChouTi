//
//  BDFMessageSystemCell.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/26.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseTableViewCell.h"
#import "BDFSystemMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFMessageSystemCell : BDFBaseTableViewCell

@property (nonatomic, strong) BDFSystemMessageNoticeModel *systemMessage;

@end

NS_ASSUME_NONNULL_END
