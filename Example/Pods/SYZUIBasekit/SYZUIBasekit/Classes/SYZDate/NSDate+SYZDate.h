//
//  NSDate+SYZDate.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSDate+SYZTimeStamp.h>


/** 分钟 转换为 秒 */
extern NSUInteger syz_oneMinuteToSeconds(void);
extern NSUInteger syz_muchMinitesToSeconds(NSUInteger numberOfMinites);

/** 小时 转换为 秒 */
extern NSUInteger syz_oneHourToSeconds(void);
extern NSUInteger syz_muchHoursToSeconds(NSUInteger numberOfHours);

/** 天 转换为 秒 */
extern NSUInteger syz_oneDayToSeconds(void);
extern NSUInteger syz_muchDaysToSeconds(NSUInteger numberOfDays);

/** 周 */
extern NSUInteger syz_oneWeekToSeconds(void);

/** 年 转换为 秒 */
extern NSUInteger syz_oneYearToSeconds(void);
extern NSUInteger syz_muchYearsToSeconds(NSUInteger numberOfYears);

/** 将秒数转变成时间格式 80 => 01:20    4020 => 01:05:20 */
extern NSString* syz_convertToTimeFormat(NSTimeInterval timeSecond);

@interface NSDate (SYZDate)

+ (NSDate *)syz_date;

/**
 将 时间戳 转成 13位
 10 --> 13
 13 --> 13
 其他 --> 0
 */
+ (long long)syz_convertToTimeStamp13:(long long)aTimeStamp;
- (long long)syz_convertToTimeStamp13:(long long)aTimeStamp;
/*! *  当前时间戳,13位 */
+ (long long)syz_currentTimeStamp13;

/*! *  当前时间戳,10位 */
+ (long long)syz_currentTimeStamp10;

/** @timestamp 时间戳
 @result    当天: 今天8:00      昨天: 11:11  前天以前: 12.4 11:11
 */
+ (NSString *)syz_toRegularTime:(NSString *)timestamp;

+ (NSString *)syz_tofutureTime:(NSString *)timestamp;

/** *当天的00时00分00秒 时间戳 10位 */
+ (long long)syz_todayStartTimeStamp10;
/** 当前的23时59分59秒  时间戳 10位 */
+ (long long)syz_todayEndTimeStamp10;
/** *当天的00时00分00秒 时间戳 13位 */
+ (long long)syz_todayStartTimeStamp13;
/** 当前的23时59分59秒  时间戳 13位 */
+ (long long)syz_todayEndTimeStamp13;

/** 给定时间 当天的起始时间 时间戳 10位 */
- (long long)syz_todayStartTimeStamp10;
- (NSDate *)syz_todayStartTimeDate;
/** 当前的23时59分59秒 时间戳 10位 */
- (long long)syz_todayEndTimeStamp10;
- (NSDate *)syz_todayEndTimeDate;
/** 给定时间 当天的起始时间 时间戳 13位 */
- (long long)syz_startTimeStamp13;

/** *当周的00时00分00秒 时间戳 10位 从周日开始 */
+ (long long)syz_currentWeekStartTimeStamp10FromSunday;
/** *当周最后一天的23:59:59 时间戳 10位 从周日开始 */
+ (long long)syz_currentWeekEndTimeStamp10FromSunday;
/** *当周的00时00分00秒 时间戳 13位 从周日开始 */
+ (long long)syz_currentWeekStartTimeStamp13FromSunday;
/** *当周的00时00分00秒 时间戳 10位 从周一开始 */
+ (long long)syz_currentWeekStartTimeStamp10FromMonday;
+ (NSDate *)syz_currentWeekStartDateFromMonday;
/** *当周最后一天的23时59分59秒 时间戳 10位 从周一开始 */
+ (long long)syz_currentWeekEndTimeStamp10FromMonday;
+ (NSDate *)syz_currentWeekEndDateFromMonday;
/** *当周的00时00分00秒 时间戳 13位 从周一开始 */
+ (long long)syz_currentWeekStartTimeStamp13FromMonday;
//给定时间的00时00分00秒 时间戳
- (long long)syz_weekStartTimeStamp10FromSunday;
- (long long)syz_weekEndTimeStamp10FromSunday;
- (long long)syz_weekStartTimeStamp13FromSunday;
- (long long)syz_weekStartTimeStamp10FromMonday;
- (NSDate *)syz_weekStartDateFromMonday;
- (long long)syz_weekEndTimeStamp10FromMonday;
- (NSDate *)syz_weekEndDateFromMonday;
- (long long)syz_weekStartTimeStamp13FromMonday;

+ (NSDate *)syz_monthStartDateForYear:(NSUInteger)year month:(NSUInteger)month;
+ (NSDate *)syz_monthEndDateForYear:(NSUInteger)year month:(NSUInteger)month;

+ (NSDate *)syz_yearStartDateForYear:(NSUInteger)year;
+ (NSDate *)syz_yearEndDateForYear:(NSUInteger)year;

// 月
- (NSDate *)syz_monthStartDate;
- (NSDate *)syz_monthEndTimeDate;

//年
- (NSDate *)syz_yearStartDate;
- (NSDate *)syz_yearEndDate;

/** 获取当月的天数 */
- (NSUInteger)syz_daysOfCurrentMonth;


@end

@interface NSString (SYZDateTime)

/**  将字符串转成 00:00:00 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString * _Nonnull convertToTime;

- (NSString *)syz_toRegularTime;

@end

