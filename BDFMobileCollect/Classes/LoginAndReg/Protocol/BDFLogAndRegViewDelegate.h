//
//  BDFLogAndRegViewDelegate.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/17.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BDFLogAndRegViewDelegate <NSObject>

- (void)clickLoginButtonComplete;
- (void)clickRegisterButtonComplete;
- (void)clickCloseButtonComplte;

@end

NS_ASSUME_NONNULL_END
