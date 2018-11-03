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
/** 首页搜索发布结果 */
NSString *const BDFHOMESEARCHPUBLISH = @"https://api.chouti.com/search/show.json";
/** 我的 */
NSString *const BDFMEDATA = @"https://api.chouti.com/users/profile.json";
/** 首页顶部的分类 */
NSString *const BDFHOMENEWSCATEGORY = @"https://api.chouti.com/subjects.json";
/** 最热榜 */
NSString *const BDFHOMEMOSTHOTLIST = @"https://api.chouti.com/r/top.json";
/** 42区 */
NSString *const BDFHOMECATEGORY42 = @"https://api.chouti.com/v2/r/news.json";
/** 段子 */
NSString *const BDFHOMECATEGORYSCOFF = @"https://api.chouti.com/v2/r/scoff.json";
/** 话题列表 */
NSString *const BDFHOMECATEGORYTOPICLIST = @"https://api.chouti.com/api/topic/list.json";
/** 话题列表详情 */
NSString *const BDFHOMECATEGORYTOPICLISTDETAIL = @"https://api.chouti.com/api/topic/linkList.json";

@end
