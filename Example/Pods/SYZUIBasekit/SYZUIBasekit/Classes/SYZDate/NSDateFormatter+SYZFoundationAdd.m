//
//  NSDateFormatter+SYZFoundationAdd.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSDateFormatter+SYZFoundationAdd.h"

@implementation NSDateFormatter (SYZFoundationAdd)

+ (instancetype)sharedInstance1 {
    static NSDateFormatter * _dateFormatter1 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter1 = [[NSDateFormatter alloc] init];
        _dateFormatter1.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        _dateFormatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return _dateFormatter1;
}

+ (instancetype)sharedInstance2 {
    static NSDateFormatter * _dateFormatter1 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter1 = [[NSDateFormatter alloc] init];
        _dateFormatter1.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        _dateFormatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    });
    return _dateFormatter1;
}

/**
 获取到 dateformat 为 yyyyMMddHHmmss 的dateFormatter
 */
+ (instancetype)sharedInstance3 {
    static NSDateFormatter * _dateFromatter3 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFromatter3 = [[NSDateFormatter alloc] init];
        _dateFromatter3.timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];
        _dateFromatter3.dateFormat = @"yyyyMMddHHmmss";
    });
    return _dateFromatter3;
}

@end

@implementation NSString (SYZDateFormatterAdd)

- (NSDate *)syz_toDate1 {
    return [[NSDateFormatter sharedInstance1] dateFromString:self];
}

/**
 将格式为 yyyy-MM-dd HH:mm:ss.SSS 的字符串转成 NSDate
 */
- (NSDate *)syz_toDate2 {
    return [[NSDateFormatter sharedInstance2] dateFromString:self];
}

- (NSString *)syz_toTimestamp1 {
    NSDate * date = [self syz_toDate1];
    return @([date timeIntervalSince1970]).stringValue;
}

- (NSString *)syz_toTimestamp2 {
    NSDate * date = [self syz_toDate2];
    return @([date timeIntervalSince1970]).stringValue;
}

@end
