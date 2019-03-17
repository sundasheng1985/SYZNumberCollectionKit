//
//  NSDate+SYZTimeStamp.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/SYZDateEnum.h>
#import <SYZUIBasekit/NSDate+SYZDate.h>
#import <SYZUIBasekit/NSString+SYZString.h>
#import <SYZUIBasekit/NSArray+SYZArrayAdd.h>


@interface NSDate (SYZTimeStamp)
//根据时间戳取 年 月 日 小时 分钟
//计算时间戳之间差值 ok
//计算当前时间和传入的时间戳的差值
//将时间戳转换成NSDate
//根据传入的时间戳判断是否是今天 昨天 明天

@property (nonatomic,assign,readonly) NSInteger syz_year;
@property (nonatomic,assign,readonly) NSInteger syz_month;
@property (nonatomic,assign,readonly) NSInteger syz_day;
@property (nonatomic,assign,readonly) NSInteger syz_hour;
@property (nonatomic,assign,readonly) NSInteger syz_minute;
@property (nonatomic,assign,readonly) NSInteger syz_second;
@property (nonatomic,assign,readonly) NSInteger syz_dayOfWeek; /* 一周中的第几天，周日为第一天*/
@property (nonatomic,assign,readonly) NSInteger syz_dayOfWeekChinese; //周一为第一天
@property (nonatomic,copy,readonly) NSString * syz_dayOfWeekZhou; /* 星期一、星期二... */
@property (nonatomic,copy,readonly) NSString * syz_dayOfWeekXingQi;/* 周一、周二... */
@property (nonatomic,assign,readonly) NSInteger syz_weekOfYear; /* 一年中的第几周*/
@property (nonatomic,assign,readonly) NSInteger syz_weekOfMonth; /** 一月中第几周*/
@property (nonatomic,assign,readonly) NSInteger syz_weekOfMonthChinese;

/**  将时间戳转为NSDate */
+ (NSDate *)syz_dateWithTimeStamp:(NSString *)timeStamp;

/**  是否是今天 */
+ (BOOL)syz_isTodayWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)syz_isTodayWithDate:(NSDate *)date;
- (BOOL)syz_isToday;

/**  是否是昨天 */
+ (BOOL)syz_isYesterdayWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)syz_isYesterdayWithDate:(NSDate *)date;
- (BOOL)syz_isYesterday;

/**  是否是明天 */
+ (BOOL)syz_isTomorrowWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)syz_isTomorrowWithDate:(NSDate *)date;
- (BOOL)syz_isTomorrow;

/**  是否在同一个星期 */
+ (BOOL)syz_isDateInWeekendWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)syz_isDateInWeekendWithTimeStamp:(NSString *)aTimeStamp toTimeStamp:(NSString *)bTimeStamp;

/**  是否是同一天 */
+ (BOOL)syz_isSameDayWithTimeStamp:(NSString *)aTimeStamp toDay:(NSString *)bTimeStamp;
+ (BOOL)syz_isSameDayWithDate:(NSDate *)aDate toDay:(NSDate *)bDate;
- (BOOL)syz_isSameDayWithDate:(NSDate *)aDate;

/*!
 *  根据传入的时间戳计算时间间隔,用现在的时间减去传入的时间
 *  discussion : 如果传入的是10位，则返回间隔"秒",如果传入的是13位，则返回间隔是“微秒”
 */
+ (long long)syz_timeIntervalSinceTimeStamp:(NSString *)aTimeStamp;
/**  计算两个时间戳的差值: aTimeStamp - bTimeStamp */
+ (long long)syz_timeIntervalBetweenTimeStamp:(NSString *)aTimeStamp andTimeStamp:(NSString *)bTimeStamp;

@end
