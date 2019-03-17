//
//  NSObject+SYZObject.h
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSException+SYZException.h>

NS_ASSUME_NONNULL_BEGIN

/**  是否是空对象 */
extern BOOL SYZIsEmpty(id obj);

/**  不是空对象*/
extern BOOL SYZIsNotEmpty(id obj);

/** 闪退通知 */
extern NSString * _Nonnull SYZAvoidCrashExceptionNotification;
@interface NSObject (SYZObject)

/** 替换方法 */
+ (void)exchangeClassMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod;
+ (void)exchangeClassMethod:(SEL)oriMethod toMethod:(SEL)newMethod;

+ (void)exchangeInstanceMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod;
+ (void)exchangeInstanceMethod:(SEL)oriMethod toMethod:(SEL)newMethod;

+ (void)notiException:(NSException *)exception appendingInfo:(NSString * _Nullable)info;
- (void)notiException:(NSException *)exception appendingInfo:(NSString * _Nullable)info;

#pragma mark - 类型判断
- (BOOL)syz_isNSDictionary;
- (BOOL)syz_isNSArray;
- (BOOL)syz_isNSString;
- (BOOL)syz_isNSNumber;
- (BOOL)syz_isNSNumberBool;
- (BOOL)syz_isNSDate;
- (BOOL)syz_isNSNull;
- (BOOL)syz_isUIViewController;
- (BOOL)syz_isUINavigationController;
- (BOOL)syz_isNSError;

#pragma mark - 转换
- (NSString *)syz_toString;
- (NSNumber *)syz_toNumber;
/** 转义字符 */
- (id)syz_replacingPercentEscapes;

#pragma mark - 系统判断

/** iOS11*/
- (BOOL)syz_iOS11Available;

/** iOS10*/
- (BOOL)syz_iOS10Available;

@end

NS_ASSUME_NONNULL_END
