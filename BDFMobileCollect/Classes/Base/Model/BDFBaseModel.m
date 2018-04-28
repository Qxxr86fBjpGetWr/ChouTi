//
//  BDFBaseModel.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/26.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//



#import "BDFBaseModel.h"
#import "BDFFileCacheManager.h"
#import <MJExtension.h>

@interface BDFBaseModel ()

@end

@implementation BDFBaseModel

MJCodingImplementation;

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             @"desc":@"description",
             @"responseData" : @"data"
             };
}

+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)response {
    if ([response isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [self mj_objectArrayWithKeyValuesArray:response];
        return array;
    }
    return [NSMutableArray new];
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:dictionary];
    }
    return [[self alloc] init];
}

+ (void)setUpModelClassInArrayWithContainDict:(NSDictionary *)dict {
    if (dict.allKeys.count == 0) {
        return ;
    }
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return dict;
    }];
}

+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)response containDict:(NSDictionary *)dict {
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithContainDict:dict];
    return [self modelArrayWithDictArray:response];
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary containDict:(NSDictionary *)dict {
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithContainDict:dict];
    return [self modelWithDictionary:dictionary];
}

- (id)unarchiver {
    id obj = [BDFFileCacheManager getObjectByFileName:[self.class description]];
    return obj;
}

- (void)archive {
    [BDFFileCacheManager saveObject:self byFileName:[self.class description]];
}

- (void)remove {
    [BDFFileCacheManager removeObjectByFileName:[self.class description]];
}

@end
