//
//  NSDate+SYZTimeStamp.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSDate+SYZTimeStamp.h"

NSUInteger SYZ_kDefaultReturnTimeInterval = NSUIntegerMax;

static NSInteger secondsOfOneDay = 24 * 60 * 60; //一天的"秒"总数
//static NSInteger milliSecondsOfOneDay = 24 * 60 * 60 * 1000; //一天的"毫秒"总数

/*!
 *  秒级的长度
 */
unsigned int SYZ_kTimeStampSecondLength = 10;

/*!
 *  毫秒级的长度
 */
unsigned int SYZ_kTimeStampMilliSecondLength = 13;

/*!
 *  转成字符串型的时间戳
 */
NSString * SYZ_ConvertToStringTimeStamp(id aTimeStamp) {
    
    NSString * timeStamp = aTimeStamp;
    if ([aTimeStamp isKindOfClass:[NSNumber class]]) {
        
        timeStamp = [aTimeStamp stringValue];
    }
    
    if ([timeStamp isKindOfClass:[NSString class]]) {
        if ([timeStamp containsString:@"."]) {
            timeStamp = [timeStamp componentsSeparatedByString:@"."].firstObject;
        }
        
        return timeStamp;
    }
    
    //打印错误提示日志
    
    return @"";
}

/*!
 *  是否是正常的时间戳（字符串)
 */
BOOL SYZ_IsNormalTimeStampString(NSString * aTimeStamp) {
    NSString * timeStamp = SYZ_ConvertToStringTimeStamp(aTimeStamp);
    
    return (timeStamp.length == SYZ_kTimeStampSecondLength ||
            timeStamp.length == SYZ_kTimeStampMilliSecondLength);
}

/*!
 *  是否是正常的时间戳(NSNumber型)
 */
BOOL SYZ_IsNormalTimeStampNumber(NSNumber * aTimeStamp) {
    NSString * timeStamp = SYZ_ConvertToStringTimeStamp(aTimeStamp);
    
    if (timeStamp.length <= 0) {
        return NO;
    }
    
    return SYZ_IsNormalTimeStampString(timeStamp);
}


@implementation NSDate (SYZTimeStamp)

- (NSInteger)syz_year {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:self];
}

- (NSInteger)syz_month {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)syz_day {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self];
}

- (NSInteger)syz_hour {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:self];
}

- (NSInteger)syz_minute {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:self];
}

- (NSInteger)syz_second {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:self];
}

- (NSInteger)syz_dayOfWeek {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:self];
}

- (NSInteger)syz_dayOfWeekChinese {
    //    return (self.syz_dayOfWeek - 1 + 7) % 7;
    NSUInteger index = self.syz_dayOfWeek;
    if (index == 1) {
        return 7;
    }
    
    return index - 1;
}

- (NSInteger)syz_weekOfMonth {
    //    return [self syz_weekOfMonthChinese];
    //    return [self syz_weekOfMonthChinese];
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:self];
}

- (NSInteger)syz_weekOfMonthChinese {
    //    NSDate * date = [self dateByAddingTimeInterval:syz_oneDayToSeconds()];
    //    NSInteger weekOfMonth = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:date];
    //    return weekOfMonth;
    //    [[NSCalendar currentCalendar] setFirstWeekday:5];
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:self];
}

//- (NSInteger)syz_dayOfMonth {
//
//}

static NSArray * dayOfWeekZhouArray;
__attribute__((constructor)) static void initDayOfWeekZhouArray() {
    dayOfWeekZhouArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
}
- (NSString *)syz_dayOfWeekZhou {
    NSUInteger dayOfWeek = self.syz_dayOfWeek;
    if ([dayOfWeekZhouArray syz_isValidIndex:dayOfWeek - 1]) {
        return dayOfWeekZhouArray[dayOfWeek - 1];
    }
    
    return @"未知";
}

static NSArray * dayOfWeekXingQiArray;
__attribute__((constructor)) static void initDayOfWeekXingQiArray() {
    dayOfWeekXingQiArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
}
- (NSString *)syz_dayOfWeekXingQi {
    NSUInteger dayOfWeek = self.syz_dayOfWeek;
    if ([dayOfWeekXingQiArray syz_isValidIndex:dayOfWeek - 1]) {
        return dayOfWeekXingQiArray[dayOfWeek - 1];
    }
    
    return @"未知";
}

- (NSInteger)syz_weekOfYear {
    NSUInteger weekOfYear = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:self];
    //    NSUInteger weekOfYear = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfYear fromDate:self];
    return weekOfYear;
}

+ (NSDate *)syz_dateWithTimeStamp:(NSString *)timeStamp {
    
    if (SYZIsEmptyString(timeStamp)) {
        return nil;
    }
    
    NSString * aTimeStamp = timeStamp;
    if (aTimeStamp.length != 13 && aTimeStamp.length != 10) {
        //可能包含小数
        if ([aTimeStamp containsString:SYZDotString()]) {
            NSArray * timeStampArrayI = [aTimeStamp componentsSeparatedByString:SYZDotString()];
            
            if (timeStampArrayI.count >= 1) {
                aTimeStamp = timeStampArrayI.firstObject;
            } else {
                aTimeStamp = [NSString emptyString];
            }
        }
    }
    
    if (aTimeStamp.length == 13) {
        aTimeStamp = [aTimeStamp syz_removeLastCharacterWithCount:3];
    }
    
    //如果不加长度和是否全是数字的判断，返回的NSDate会非常奇怪
    //长度不为10，则时间为任意一个时间
    //如果不全是数字，则时间为1970年
    if (aTimeStamp.length != 10 || [aTimeStamp syz_isIntegerValue] == NO) {
        return nil;
    }
    
    return [NSDate dateWithTimeIntervalSince1970:aTimeStamp.longLongValue];
}

#pragma mark - 今天
+ (BOOL)syz_isTodayWithTimeStamp:(NSString *)timeStamp {
    return [self syz_isTodayWithDate:[NSDate syz_dateWithTimeStamp:timeStamp]];
}

+ (BOOL)syz_isTodayWithDate:(NSDate *)aDate {
    return [[NSDate syz_date] syz_isSameDayWithDate:aDate];
}

- (BOOL)syz_isToday {
    return [[self class] syz_isTodayWithDate:self];
}

#pragma mark - 昨天
+ (BOOL)syz_isYesterdayWithTimeStamp:(NSString *)timeStamp {
    return [self syz_isYesterdayWithDate:[NSDate syz_dateWithTimeStamp:timeStamp]];
}

+ (BOOL)syz_isYesterdayWithDate:(NSDate *)date {
    return [self syz_isTodayWithDate:[date dateByAddingTimeInterval:secondsOfOneDay]];
}

- (BOOL)syz_isYesterday {
    return [[self class] syz_isYesterdayWithDate:self];
}

#pragma mark - 明天
+ (BOOL)syz_isTomorrowWithTimeStamp:(NSString *)timeStamp {
    return [self syz_isTomorrowWithDate:[NSDate syz_dateWithTimeStamp:timeStamp]];
}

+ (BOOL)syz_isTomorrowWithDate:(NSDate *)date {
    return [self syz_isTodayWithDate:[date dateByAddingTimeInterval:-secondsOfOneDay]];
}

- (BOOL)syz_isTomorrow {
    return [[self class] syz_isTomorrowWithDate:self];
}

#pragma mark - 同一个星期
+ (BOOL)syz_isDateInWeekendWithTimeStamp:(NSString *)timeStamp {
    return [self syz_isDateInWeekendWithTimeStamp:timeStamp toTimeStamp:(@([NSDate syz_date].timeIntervalSince1970)).stringValue];
}

+ (BOOL)syz_isDateInWeekendWithTimeStamp:(NSString *)aTimeStamp toTimeStamp:(NSString *)bTimeStamp {
    NSDate * aDate = [NSDate syz_dateWithTimeStamp:aTimeStamp];
    NSDate * bDate = [NSDate syz_dateWithTimeStamp:bTimeStamp];
    return (aDate.syz_year == bDate.syz_year &&
            aDate.syz_weekOfYear == bDate.syz_weekOfYear);
}

#pragma mark - 同一天
+ (BOOL)syz_isSameDayWithTimeStamp:(NSString *)aTimeStamp toDay:(NSString *)bTimeStamp {
    return [[NSDate syz_dateWithTimeStamp:aTimeStamp] syz_isSameDayWithDate:[NSDate syz_dateWithTimeStamp:bTimeStamp]];
}

- (BOOL)syz_isSameDayWithDate:(NSDate *)aDate {
    return [NSDate syz_isSameDayWithDate:aDate toDay:self];
}

+ (BOOL)syz_isSameDayWithDate:(NSDate *)aDate toDay:(NSDate *)bDate {
    return (aDate.syz_year == bDate.syz_year &&
            aDate.syz_month == bDate.syz_month &&
            aDate.syz_day == bDate.syz_day);
}

#pragma mark - 时间间隔
/*!
 *  根据传入的时间戳计算时间间隔,用现在的时间减去传入的时间
 *  discussion : 如果传入的是10位，则返回间隔"秒",如果传入的是13位，则返回间隔是“微秒”
 */
+ (long long)syz_timeIntervalSinceTimeStamp:(NSString *)aTimeStamp {
    
    NSTimeInterval nowTimeStamp = [NSDate syz_date].timeIntervalSince1970;
    return [self syz_timeIntervalBetweenTimeStamp:@(nowTimeStamp).stringValue andTimeStamp:aTimeStamp];
}

/*!
 *  计算两个时间戳的差值: aTimeStamp - bTimeStamp
 */
+ (long long)syz_timeIntervalBetweenTimeStamp:(NSString *)aTimeStamp
                                 andTimeStamp:(NSString *)bTimeStamp {
    
    NSString * timeStampA = SYZ_ConvertToStringTimeStamp(aTimeStamp);
    NSString * timeStampB = SYZ_ConvertToStringTimeStamp(bTimeStamp);
    
    if (timeStampA.length == SYZ_kTimeStampMilliSecondLength) {
        timeStampA = [timeStampA syz_removeLastCharacterWithCount:3];
    }
    
    if (timeStampB.length == SYZ_kTimeStampMilliSecondLength) {
        timeStampB = [timeStampB syz_removeLastCharacterWithCount:3];
    }
    
    if (timeStampA.length != SYZ_kTimeStampSecondLength ||
        timeStampB.length != SYZ_kTimeStampSecondLength) {
        
        return SYZ_kDefaultReturnTimeInterval;
    }
    
    return timeStampA.longLongValue - timeStampB.longLongValue;
}

@end
