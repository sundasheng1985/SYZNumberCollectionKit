//
//  NSScanner+SYZFoundationAdd.h
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/** 扫描 */
@interface NSScanner (SYZFoundationAdd)

@end

@interface NSString (SYZScannerAdd)

/** 是否是整数 */
- (BOOL)syz_isIntegerValue;

/** 是否是小数 */
- (BOOL)syz_isFloatValue;

/**  是否是 纯字符串 */
- (BOOL)syz_isAllString;

/** 是否 全是大写字母 */
- (BOOL)syz_isAllUpperString;

/** 是否 全是小写字母 */
- (BOOL)syz_isAllLowerString;

/** 根据对应的 charSet 匹配字符串 */
- (NSString *)syz_scanStringWithSet:(NSCharacterSet *)charSet;


@end

NS_ASSUME_NONNULL_END
