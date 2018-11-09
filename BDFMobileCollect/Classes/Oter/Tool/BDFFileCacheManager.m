//
//  BDFFileCacheManager.m
//  BDFMobileCollect
//
//  Created by 张声扬 on 2017/5/25.
//  Copyright © 2017年 zhangshengyang. All rights reserved.
//

#import "BDFFileCacheManager.h"
#import "NSFileManager+Paths.h"

@implementation BDFFileCacheManager

+(BOOL)saveObject:(id)object byFileName:(NSString *)fileName {
    NSString *path = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:path];
    return success;
}

+(id)getObjectByFileName:(NSString *)fileName {
    NSString *path = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return obj;
}

+(void)removeObjectByFileName:(NSString *)fileName {
    NSString *path = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+(void)saveUserData:(id)data forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)readUserDataForKey:(NSString *)key {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return obj;
}

+(void)removeUserDataForkey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(NSString *)appendFilePath:(NSString *)fileName {
    
    NSString *cachePath = [NSFileManager cachesPath];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",cachePath,fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return filePath;
}

@end
