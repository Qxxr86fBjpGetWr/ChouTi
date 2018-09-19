//
//  BDFLogAndRegView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BDFLogAndRegViewDelegate <NSObject>

- (void)clickLoginButtonComplete;
- (void)clickCloseButtonComplte;

@end

typedef NSString * (^loginViewCllickHandle)(NSString *test);

@interface BDFLogAndRegView : UIView

@property (nonatomic, weak) id<BDFLogAndRegViewDelegate> delegate;

@property (nonatomic, weak) loginViewCllickHandle loginHndle;

@end
