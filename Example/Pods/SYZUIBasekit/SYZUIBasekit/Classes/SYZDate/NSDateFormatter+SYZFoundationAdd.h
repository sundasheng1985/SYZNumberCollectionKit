//
//  NSDateFormatter+SYZFoundationAdd.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SYZFoundationAdd)

/** 获取到 dateformat 为 yyyy-MM-dd HH:mm:ss 的dateFormatter */
+ (instancetype)sharedInstance1;

/** 获取到 dateformat 为 yyyy-MM-dd HH:mm:ss.SSS 的dateFormatter */
+ (instancetype)sharedInstance2;
/** 获取到 dateformat 为 yyyyMMddHHmmss 的dateFormatter */
+ (instancetype)sharedInstance3;

@end

@interface NSString (SYZDateFormatterAdd)

/** 将格式为 yyyy-MM-dd HH:mm:ss 的字符串转成 NSDate */
- (NSDate *)syz_toDate1;

/** 将格式为 yyyy-MM-dd HH:mm:ss.SSS 的字符串转成 NSDate */
- (NSDate *)syz_toDate2;

/** 将格式为 yyyy-MM-dd HH:mm:ss 的字符串转成 时间戳 */
- (NSString *)syz_toTimestamp1;

/** 将格式为 yyyy-MM-dd HH:mm:ss.SSS 的字符串转成 时间戳 */
- (NSString *)syz_toTimestamp2;
@end
