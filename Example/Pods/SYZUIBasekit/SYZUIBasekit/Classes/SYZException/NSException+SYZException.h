//
//  NSException+SYZException.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 抛异常 */
@interface NSException (SYZException)

+ (NSException *)unrecognizedSelectorExceptionWithInstance:(NSObject *)aInstance forMethod:(SEL)aSelector;

/** 没有实现协议 */
+ (NSException *)didNotConforms:(Protocol *)protocl object:(id)object;
@end

NS_ASSUME_NONNULL_END
