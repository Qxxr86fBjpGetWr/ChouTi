//
//  BDFAllTypeNewsView.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2018/10/20.
//  Copyright © 2018 zhangshengyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDFHomeSubjectsModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BDFAllTypeNewsViewDidSelectDelegate <NSObject>
/** 新热榜 */
- (void)bdfHomeSubjectsDidSelect_hotnews;
/** 42区 */
- (void)bdfHomeSubjectsDidSelect_news;
/** 段子 */
- (void)bdfHomeSubjectsDidSelect_scoff;
/** 图片 */
- (void)bdfHomeSubjectsDidSelect_pic;
/** 挨踢1024 */
- (void)bdfHomeSubjectsDidSelect_tec;
/** 你问我答 */
- (void)bdfHomeSubjectsDidSelect_ask;
/** 视频 */
- (void)bdfHomeSubjectsDidSelect_video;

/** 最热榜 */
- (void)bdfHomeSubjectsDidSelectMostHot;
/** 话题 */
- (void)bdfHomeSubjectsDidSelectTopic;
/** 关注人动态 */
- (void)bdfHomeSubjectsDidSelectAttention;
/** 人类发布 */
- (void)bdfHomeSubjectsDidSelectPeople;
/** 私藏 */
- (void)bdfHomeSubjectsDidSelectCollection;

@end

@interface BDFAllTypeNewsView : UICollectionView

@property (nonatomic, strong) BDFHomeSubjectsModel *subjectsModel;
@property (nonatomic, weak) id <BDFAllTypeNewsViewDidSelectDelegate> selectDelegate;
@end

NS_ASSUME_NONNULL_END
