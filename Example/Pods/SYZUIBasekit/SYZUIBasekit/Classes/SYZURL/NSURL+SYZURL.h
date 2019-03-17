//
//  NSURL+SYZURL.h
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSURL (SYZURL)

/** path转url */
+ (NSURL *)syz_urlWithPath:(NSString *)path;

/** 转字符串 */
- (NSString *)syz_toString;

/** 判断url是否相同 */
- (BOOL)syz_isEqualToURL:(NSURL *)url;

- (NSString *)syz_trimSchema;

/** 是否是文件夹 */
- (BOOL)syz_isDirectoryError:(NSError **)error;

/**  是否是文件 */
- (BOOL)syz_isFileError:(NSError **)error;

/** 是否是可执行文件 */
- (BOOL)syz_isExecuteError:(NSError **)error;

/** 是否是隐藏文件 */
- (BOOL)syz_isHiddenError:(NSError **)error;

/** 地址中包含的参数 */
- (NSDictionary *)syz_queryDictionary;

/** url */
- (NSURL *)syz_toURL;

/** 文件类型转url */
- (NSURL *)syz_toFileURL;

/** 是否是http协议*/
- (BOOL)syz_isHTTP;

/** 是否是https协议*/
- (BOOL)syz_isHTTPS;

@end
NS_ASSUME_NONNULL_END

