//
//  BDFHomeTopicDetailRequest.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/11/3.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import "BDFBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDFHomeTopicDetailRequest : BDFBaseRequest

@property (nonatomic, strong) NSString *pageNumber;
@property (nonatomic, strong) NSString *topicId;

@end

NS_ASSUME_NONNULL_END
