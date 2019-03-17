//
//  NSDate+SYZDate.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSDate+SYZDate.h"

/**
 分钟 转换为 秒
 */
NSUInteger syz_oneMinuteToSeconds(void) {
    return 60;
}
NSUInteger syz_muchMinitesToSeconds(NSUInteger numberOfMinites) {
    return numberOfMinites * 60;
}

/**
 小时 转换为 秒
 */
NSUInteger syz_oneHourToSeconds(void) {
    return syz_muchMinitesToSeconds(60);
}
NSUInteger syz_muchHoursToSeconds(NSUInteger numberOfHours) {
    return syz_oneHourToSeconds() * numberOfHours;
}

/**
 天 转换为 秒
 */
NSUInteger syz_oneDayToSeconds(void) {
    return syz_muchHoursToSeconds(24);
}
NSUInteger syz_muchDaysToSeconds(NSUInteger numberOfDays) {
    return syz_oneDayToSeconds() * numberOfDays;
}
/**
 周
 */
NSUInteger syz_oneWeekToSeconds(void) {
    return syz_muchDaysToSeconds(7);
}
/**
 年 转换为 秒
 */
extern NSUInteger syz_oneYearToSeconds(void) {
    return syz_muchDaysToSeconds(365);
}
extern NSUInteger syz_muchYearsToSeconds(NSUInteger numberOfYears) {
    return syz_oneYearToSeconds() * numberOfYears;
}

/** 将秒数转变成时间格式 80 => 01:20    4020 => 01:05:20 */
extern NSString* syz_convertToTimeFormat(NSTimeInterval timeSecond) {
    NSString *theLastTime = nil;
    long second = timeSecond;
    if (timeSecond < 0) {
        theLastTime = @"00:00";
    } else if (timeSecond < 60) {
        theLastTime = [NSString stringWithFormat:@"00:%02zd", second];
    } else if(timeSecond >= 60 && timeSecond < 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd", second / 60, second % 60];
    } else if(timeSecond >= 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", second / 3600, second % 3600 / 60, second % 60];
    }
    return theLastTime;
}




@implementation NSDate (SYZDate)

+ (NSDate *)syz_date {
    return [NSDate date];
}

+ (long long)syz_convertToTimeStamp13:(long long)aTimeStamp {
    NSString * timeStampStr = NSStringFromunsignedLongLong(aTimeStamp);
    if (timeStampStr.length == 13) {
        return aTimeStamp;
    }
    
    if (timeStampStr.length == 10) {
        return [[timeStampStr syz_appendString:@"000"] longLongValue];
    }
    
    return 0;
}
- (long long)syz_convertToTimeStamp13:(long long)aTimeStamp {
    return [NSDate syz_convertToTimeStamp13:aTimeStamp];
}
/*!
 *  当前时间戳,13位
 */
+ (long long)syz_currentTimeStamp13 {
    return [self syz_convertToTimeStamp13:[self syz_currentTimeStamp10]];
}

/*!
 *  当前时间戳,10位
 */
+ (long long)syz_currentTimeStamp10 {
    
    return [NSDate syz_date].timeIntervalSince1970;
}

+ (NSString *)syz_toRegularTime:(NSString *)timestamp {
    NSDate * date = [NSDate syz_dateWithTimeStamp:timestamp];
    
    if ([date syz_isToday]) { //今天
        return [NSString stringWithFormat:@"今天 %02ld:%02ld",(long)date.syz_hour,(long)date.syz_minute];
    } else if ([date syz_isYesterday]) { //昨天
        return [NSString stringWithFormat:@"昨天 %02ld:%02ld",(long)date.syz_hour,(long)date.syz_minute];
    } else { //以前
        return [NSString stringWithFormat:@"%ld.%02ld.%02ld %02ld:%02ld",(long)date.syz_year,(long)date.syz_month,(long)date.syz_day,(long)date.syz_hour,(long)date.syz_minute];
    }
}

+ (NSString *)syz_tofutureTime:(NSString *)timestamp{
    NSDate * date = [NSDate syz_dateWithTimeStamp:timestamp];
    return [NSString stringWithFormat:@"%02ld.%02ld %02ld:%02ld",(long)date.syz_month,(long)date.syz_day,(long)date.syz_hour,(long)date.syz_minute];
}

/**
 *当天的00时00分00秒 时间戳 10位
 */
+ (long long)syz_todayStartTimeStamp10 {
    NSDate * date = [NSDate syz_date];
    long long currentTime = [self syz_currentTimeStamp10];
    long long leftTime = date.syz_hour * syz_oneHourToSeconds() + date.syz_minute * syz_oneMinuteToSeconds() + date.syz_second;
    return currentTime - leftTime;
}

/**
 当前的23时59分59秒  时间戳 10位
 */
+ (long long)syz_todayEndTimeStamp10 {
    return [self syz_todayStartTimeStamp10] + syz_oneDayToSeconds() - 1;
}

/**
 *当天的00时00分00秒 时间戳 13位
 */
+ (long long)syz_todayStartTimeStamp13 {
    return [self syz_convertToTimeStamp13:[self syz_todayStartTimeStamp10]];
}

/**
 当前的23时59分59秒  时间戳 13位
 */
+ (long long)syz_todayEndTimeStamp13 {
    return [self syz_convertToTimeStamp13:[self syz_todayEndTimeStamp10]];
}

- (long long)syz_todayStartTimeStamp10 {
    long long dateStamp = [self timeIntervalSince1970];
    long long leftTime = self.syz_hour * syz_oneHourToSeconds() + self.syz_minute * syz_oneMinuteToSeconds() + self.syz_second;
    return dateStamp - leftTime;
}

- (NSDate *)syz_todayStartTimeDate {
    return [NSDate syz_dateWithTimeStamp:@([self syz_todayStartTimeStamp10]).stringValue];
}

/**
 当前的23时59分59秒 时间戳 10位
 */
- (long long)syz_todayEndTimeStamp10 {
    return [self syz_todayStartTimeStamp10] + syz_oneDayToSeconds() - 1;
}

- (NSDate *)syz_todayEndTimeDate {
    return [NSDate syz_dateWithTimeStamp:@([self syz_todayEndTimeStamp10]).stringValue];
}

- (long long)syz_startTimeStamp13 {
    return [NSDate syz_convertToTimeStamp13:[self syz_todayStartTimeStamp10]];
}
/**
 *当周的00时00分00秒 时间戳 10位 从周日开始
 */
+ (long long)syz_currentWeekStartTimeStamp10FromSunday {
    return [[NSDate syz_date] syz_weekStartTimeStamp10FromSunday];
}
/**
 *当周最后一天的23:59:59 时间戳 10位 从周日开始
 */
+ (long long)syz_currentWeekEndTimeStamp10FromSunday {
    return [self syz_currentWeekStartTimeStamp10FromSunday] + syz_oneWeekToSeconds() - 1;
}
/**
 *当周的00时00分00秒 时间戳 13位 从周日开始
 */
+ (long long)syz_currentWeekStartTimeStamp13FromSunday {
    return [self syz_convertToTimeStamp13:[self syz_currentWeekStartTimeStamp10FromSunday]];
}
/**
 *当周的00时00分00秒 时间戳 10位 从周一开始
 */
+ (long long)syz_currentWeekStartTimeStamp10FromMonday {
    return [[NSDate syz_date] syz_weekStartTimeStamp10FromMonday];
}
+ (NSDate *)syz_currentWeekStartDateFromMonday {
    return [self syz_dateWithTimeStamp:@([self syz_currentWeekStartTimeStamp10FromMonday]).stringValue];
}
/**
 *当周最后一天的23时59分59秒 时间戳 10位 从周一开始
 */
+ (long long)syz_currentWeekEndTimeStamp10FromMonday {
    return [self syz_currentWeekStartTimeStamp10FromMonday] + syz_oneWeekToSeconds() - 1;
}
+ (NSDate *)syz_currentWeekEndDateFromMonday {
    return [self syz_dateWithTimeStamp:@([self syz_currentWeekEndTimeStamp10FromMonday]).stringValue];
}
/**
 *当周的00时00分00秒 时间戳 13位 从周一开始
 */
+ (long long)syz_currentWeekStartTimeStamp13FromMonday {
    return [self syz_convertToTimeStamp13:[self syz_currentWeekStartTimeStamp10FromMonday]];
}

//给定时间的00时00分00秒 时间戳
- (long long)syz_weekStartTimeStamp10FromSunday {
    NSUInteger dayOfWeek = self.syz_dayOfWeek; //周一为 第2天
    //当前时间 - 多余的时间
    return self.syz_todayStartTimeStamp10 - (dayOfWeek - 1) * syz_oneDayToSeconds();
}

- (long long)syz_weekEndTimeStamp10FromSunday {
    return [self syz_weekStartTimeStamp10FromSunday] + syz_oneWeekToSeconds() - 1;
}

- (long long)syz_weekStartTimeStamp13FromSunday {
    return [self syz_convertToTimeStamp13:[self syz_weekStartTimeStamp10FromSunday]];
}

- (long long)syz_weekStartTimeStamp10FromMonday {
    NSUInteger dayOfWeek =self.syz_dayOfWeek; //周一为 第2天
    if (dayOfWeek == 1) {
        //这里的周日 也就是第一天实际为上周的最后一天
        //当前时间 - 多余时间
        return self.syz_todayStartTimeStamp10 - 6 * syz_oneDayToSeconds();
    }
    
    //当前时间 - 多余的时间
    return self.syz_todayStartTimeStamp10 - (dayOfWeek - 2) * syz_oneDayToSeconds();
}

- (NSDate *)syz_weekStartDateFromMonday {
    return [NSDate syz_dateWithTimeStamp:@([self syz_weekStartTimeStamp10FromMonday]).stringValue];
}

- (long long)syz_weekEndTimeStamp10FromMonday {
    return [self syz_weekStartTimeStamp10FromMonday] + syz_oneWeekToSeconds() - 1;
}

- (NSDate *)syz_weekEndDateFromMonday {
    return [NSDate syz_dateWithTimeStamp:@([self syz_weekEndTimeStamp10FromMonday]).stringValue];
}

- (long long)syz_weekStartTimeStamp13FromMonday {
    return [self syz_convertToTimeStamp13:[self syz_weekStartTimeStamp10FromMonday]];
}

+ (NSDate *)syz_monthStartDateForYear:(NSUInteger)year month:(NSUInteger)month {
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = month;
    dateCom.day = 1;
    dateCom.hour = 0;
    dateCom.minute = 0;
    dateCom.second = 0;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}

- (NSUInteger)syz_daysOfCurrentMonth {
    NSUInteger year = self.syz_year;
    NSUInteger month = self.syz_month;
    NSUInteger days = 31;
    switch (month) {
        case 4:
        case 6:
        case 9:
        case 11:
            days = 30;
            break;
        case 2:
            if ((year % 4 ==0 && year % 100 != 0) || year % 400 == 0) {
                days = 29;
            } else {
                days  = 28;
            }
            break;
        default:
            break;
    }
    
    return days;
}

+ (NSDate *)syz_monthEndDateForYear:(NSUInteger)year month:(NSUInteger)month {
    NSUInteger lastDay = 31;
    switch (month) {
        case 4:
        case 6:
        case 9:
        case 11:
            lastDay = 30;
            break;
        case 2:
            if ((year / 100 == 0 && year / 400 == 0) || year % 4 == 0) {
                lastDay = 29;
            } else {
                lastDay = 28;
            }
            break;
        default:
            break;
    }
    
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = month;
    dateCom.day = lastDay;
    dateCom.hour = 23;
    dateCom.minute = 59;
    dateCom.second = 59;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}

+ (NSDate *)syz_yearStartDateForYear:(NSUInteger)year {
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = 1;
    dateCom.day = 1;
    dateCom.hour = 0;
    dateCom.minute = 0;
    dateCom.second = 0;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}
+ (NSDate *)syz_yearEndDateForYear:(NSUInteger)year {
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = 12;
    dateCom.day = 31;
    dateCom.hour = 23;
    dateCom.minute = 59;
    dateCom.second = 59;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}

// 月
- (NSDate *)syz_monthStartDate {
    return [NSDate syz_monthStartDateForYear:self.syz_year month:self.syz_month];
}
- (NSDate *)syz_monthEndTimeDate {
    return [NSDate syz_monthEndDateForYear:self.syz_year month:self.syz_month];
}

//年
- (NSDate *)syz_yearStartDate {
    return [NSDate syz_yearStartDateForYear:self.syz_year];
}
- (NSDate *)syz_yearEndDate {
    return [NSDate syz_yearEndDateForYear:self.syz_year];
}
@end

@implementation NSString (SYZDateTime)

/**
 *  将字符串转成 00:00:00
 */
- (NSString *)convertToTime {
    
    //判断是否是整数
    //判断是否符合转成时间的规则
    //转换
    
    return self;
}

- (NSString *)syz_toRegularTime {
    return [NSDate syz_toRegularTime:self];
}

@end

