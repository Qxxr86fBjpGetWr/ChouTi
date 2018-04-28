//
//  BDFBaseModel.h
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDFBaseModel : NSObject

//#pragma mark - 缓存
/**
 *  归档 - 存入模型
 */
- (void)archive;

/**
 *  解档 - 取出模型
 */
- (id)unarchiver;

/**
 *  移除缓存中的模型
 */
- (void)remove;

/**
 *  字典数组转模型数组
 */
+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)response;

/**
 *  字典转模型
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

/**
 *  模型包含模型数组
 */
+ (void)setUpModelClassInArrayWithContainDict:(NSDictionary *)dict;

/**
 *  字典数组转模型数组
 *  @param dict     模型包含模型数组 格式为 key-字段名字 value-[被包含的类名]
 */
+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)response containDict:(NSDictionary *)dict;

@end
