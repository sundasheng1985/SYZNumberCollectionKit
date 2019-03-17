//
//  NSFileManager+SYZFoundationAdd.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>
#import <SYZUIBasekit/NSString+SYZString.h>

/**
 支持将多个路径字符串合并成完整路径
 headerPath: 路径前缀
 ... : 文件夹名字,必须以nil结尾
 */
extern NSString * SYZToCompleteFilePath(NSString *headerPath, ...) NS_REQUIRES_NIL_TERMINATION;
extern NSString * SYZToCompleteFilePathUseVAList(va_list list,NSString *headerPath, ...)NS_REQUIRES_NIL_TERMINATION;

@interface NSFileManager (SYZFoundationAdd)

/* 磁盘总空间 */
+ (unsigned long long)syz_diskTotalSpace;

/* 磁盘可用剩余空间 */
+ (unsigned long long)syz_diskFreeSpace;

#pragma makr - 文件操作相关
/**
 创建文件夹的简便方法
 如果不存在，创建
 */
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError **)error;

@end
