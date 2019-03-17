//
//  NSNumber+SYZNumber.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/10/30.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSScanner+SYZFoundationAdd.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>

extern NSNumber * const SYZNoNilNumber(NSNumber *number);
@interface NSNumber (SYZNumber)

/**
 *  判断两个number是否相等
 *  为了解决原生方法isEqualToNumber:传入参数为nil时崩溃的问题
 *  错误信息：-[__NSCFNumber compare:]: nil argument
 */
- (BOOL)syz_isEqualToNumber:(NSNumber *)aNumber;

/** 拼接 */
- (NSString *)syz_numberByAppendingString:(NSString *)aString;

/** 转 */
- (NSNumber *)syz_toNumber;

/** 转字符串 */
- (NSString *)syz_toString;

/** 转成万 亿字符串 */
- (NSString *)syz_toSimpleNumber;
@end
