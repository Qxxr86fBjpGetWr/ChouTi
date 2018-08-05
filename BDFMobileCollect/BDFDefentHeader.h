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

//判断数组是否为空
#define NULLArray(array) ((array == nil)||[array isKindOfClass:[NSNull class]]||array.count ==0)
//判断数组是否为空
#define NULLDic(dic) ((dic == nil)||[dic isKindOfClass:[NSNull class]]||dic == 0)
//判断字符串是否为空
#define NULLString(string) ((string == nil)||[string isKindOfClass:[NSNull class]]||string.length ==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || string == NULL || [string isEqual:[NSNull null]] || [string isEqual:NULL])

/** 屏幕尺寸 */
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
/** 导航栏的高度 */
#define SCREEN_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define SCREEN_StatusBarAndNavBarHeight  (SCREEN_iPhoneX ? 88.f : 64.f)

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
#define kColorFromRGB(rgbValue) kColorFromRGBA(rgbValue, 1.0)
#define kColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]

#endif /* BDFDefentHeader_h */
