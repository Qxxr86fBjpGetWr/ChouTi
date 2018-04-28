//
//  BDFDefentHeader.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/1/9.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#ifndef BDFDefentHeader_h
#define BDFDefentHeader_h

/**
 *  弱指针
 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// 日志输出
#ifdef DEBUG
#define BDFLog(...) NSLog(__VA_ARGS__)
#else
#define BDFLog(...)
#endif

//屏幕尺寸
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

#pragma mark - 颜色
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]

#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]

#endif /* BDFDefentHeader_h */
