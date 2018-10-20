//
//  BDFHomeTitleView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/20.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BDFHomeTitleDelegate <NSObject>

- (void)homeTitleCliclAction;

@end

@class BDFHomeTitleDelegate;
@interface BDFHomeTitleView : UIButton

@property (nonatomic, weak) id <BDFHomeTitleDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
