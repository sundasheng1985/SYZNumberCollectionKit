//
//  NSFileManager+SYZFoundationAdd.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSFileManager+SYZFoundationAdd.h"

NSString * SYZToCompleteFilePath(NSString *headerPath, ...) {
    if (SYZIsEmpty(headerPath)) {
        return nil;
    }
    
    va_list list;
    NSString * fullPath = nil;
    //   用VA_START宏初始化刚定义的VA_LIST变量
    va_start(list, headerPath);
    fullPath = SYZToCompleteFilePathUseVAList(list, headerPath, nil);
    va_end(list);
    
    return fullPath;
}

NSString * SYZToCompleteFilePathUseVAList(va_list list,NSString *headerPath,...) {
    NSMutableArray * dirNameArrayM = [NSMutableArray new];
    if (SYZIsNotEmptyString(headerPath)) {
        va_list list2;
        va_start(list2, headerPath);
        NSString * path = nil;
        while ((path = va_arg(list2, NSString *))) {
            [dirNameArrayM addObject:path];
        }
        va_end(list2);
    }
    
    NSString * dirName = nil;
    //  VA_ARG返回可变的参数，VA_ARG的第二个参数是你要返回的参数的类型,如果函数有多个可变参数的，依次调用VA_ARG获取各个参数
    while ((dirName = va_arg(list, NSString *))) {
        [dirNameArrayM addObject:dirName];
    }
    NSString * suffixPath = [dirNameArrayM componentsJoinedByString:@"/"];
    return [headerPath stringByAppendingPathComponent:suffixPath];
}


@implementation NSFileManager (SYZFoundationAdd)

/*
 磁盘总空间
 */
+ (unsigned long long)syz_diskTotalSpace {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSDictionary *info = [[NSFileManager defaultManager] attributesOfFileSystemForPath:cachesDirectory error:NULL];
    NSNumber *freeSpaceNumber = [info objectForKey:NSFileSystemSize];
    
    unsigned long long freeSpace = [freeSpaceNumber unsignedLongLongValue];
    return freeSpace;
}

/*
 磁盘可用剩余空间
 */
+ (unsigned long long)syz_diskFreeSpace {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSDictionary *info = [[NSFileManager defaultManager] attributesOfFileSystemForPath:cachesDirectory error:NULL];
    NSNumber *freeSpaceNumber = [info objectForKey:NSFileSystemFreeSize];
    
    unsigned long long freeSpace = [freeSpaceNumber unsignedLongLongValue];
    return freeSpace;
}

#pragma makr - 文件操作相关
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    if ([self fileExistsAtPath:path isDirectory:nil]) {
        return YES;
    }
    
    return [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
}


@end
