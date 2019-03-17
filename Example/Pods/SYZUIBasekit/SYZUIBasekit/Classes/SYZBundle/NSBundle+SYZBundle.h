//
//  NSBundle+SYZBundle.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSString+SYZString.h>
#import <SYZUIBasekit/NSFileManager+SYZFoundationAdd.h>

/* main bundle的文件夹地址 */
extern NSString * SYZMainBundleResourcePath(void);

/* 获取 main bundle 中文件地址 */
extern NSString * SYZMainBundleResourcePathForFile(NSString * fileName);
extern NSString * SYZMainBundleResourcePathForFileWithType(NSString *fileName,NSString * fileType);

@interface NSBundle (SYZBundle)
/*!
 *  获取包内私有bundle
 *  @param bundleName bundle名称，不需要路径
 *  @return 对应的bundle
 */
+ (NSBundle *)syz_privateBundleWithName:(NSString *)bundleName;

- (NSString *)syz_name;

/** 缓存路径 */
+ (NSString *)syz_cachesPath;
+ (NSString *)syz_cachesPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

/** document下路径 */
+ (NSString *)syz_documentsPath;
+ (NSString *)syz_documentsPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)syz_temporaryPath;
+ (NSString *)syz_temporaryPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)syz_libraryPath;
+ (NSString *)syz_libraryPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;
@end
