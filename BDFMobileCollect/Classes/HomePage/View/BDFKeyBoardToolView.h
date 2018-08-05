//
//  BDFKeyBoardToolView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/7/10.
//  Copyright © 2018年 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>

@protocol BDFCommentTextDelegate <NSObject>

- (void)sendCommentWithText:(NSString *)text;

@end

@interface BDFKeyBoardToolView : UIView

@property (nonatomic, weak) YYTextView *textView;
@property (nonatomic, weak) id <BDFCommentTextDelegate> commentDelegate;
@end
