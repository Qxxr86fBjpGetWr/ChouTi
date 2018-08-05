//
//  BDFCommentAPIConstant.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFCommentAPIConstant.h"

@implementation BDFCommentAPIConstant

/**
 示例bing每日壁纸基本API
 */
NSString *const BDFBINGIMAGEAPI = @"https://bing.ioliu.cn/v1";
/** 登录 */
NSString *const BDFLOGINBASEAPI = @"https://api.new.chouti.com/users/profile.json";
/** 首页新热榜 */
NSString *const BDFHOMEPAGEHOTNNEWS = @"https://api.new.chouti.com/api/hot/recommend.json";
/** 首页新热榜点推荐 */
NSString *const BDFHOMEPAGEHOTNNEWSUPS = @"https://api.new.chouti.com/links/up.json";
/** 首页新热榜取消推荐 */
NSString *const BDFHOMEPAGEHOTNNEWSREMOVEUPS = @"https://api.new.chouti.com/links/removeup.json";
/** 首页新热榜私藏 */
NSString *const BDFHOMEPAGEHOTNNEWSADD = @"https://api.new.chouti.com/save/add.json";
/** 首页新热榜取消私藏 */
NSString *const BDFHOMEPAGEHOTNNEWSDELADD = @"https://api.new.chouti.com/save/del.json";
/** 首页新热榜评论 */
NSString *const BDFHOMEPAGEHOTNNEWSCOMMENT = @"https://api.new.chouti.com/comments/batch.json";
/** 首页新热榜评论索引 */
NSString *const BDFHOMEPAGEHOTNNEWSCOMMENTINDEX = @"https://api.new.chouti.com/comments_tree.json";
/** 首页搜索建议 */
NSString *const BDFHOMESEARCHSUGGEST = @"https://api.chouti.com/search/suggest.json";

@end
