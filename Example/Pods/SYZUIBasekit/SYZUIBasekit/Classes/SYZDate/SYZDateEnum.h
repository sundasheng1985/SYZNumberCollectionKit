//
//  SYZDateEnum.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#ifndef SYZDateEnum_h
#define SYZDateEnum_h

/*!
 *  时间戳格式
 */
typedef NS_ENUM(NSUInteger,SYZDateStyle) {
    /**  年 */
    SYZDateStyleYear = 0,
    /**  月 */
    SYZDateStyleMonth,
    /**  日 */
    SYZDateStyleDay,
    /**  小时 */
    SYZDateStyleHour,
    /**  分钟 */
    SYZDateStyleMinute,
    /**  秒 */
    SYZDateStyleSecond,
    /**  毫秒 */
    SYZDateStyleMSec
};

/**  时间日期格式 */
typedef NS_ENUM(NSUInteger,SYZDateFormatStyle) {
    /**  2015-10-08 12:30:40 */
     SYZDateFormatStyleNormal = 0,
    /**  20151008123040 */
     SYZDateFormatStyleNoSegment,
    /**  2015/10/08 12:30:40 */
     SYZDateFormatStyleDiagonal
};

/**  日期通俗表示类型 */
typedef NS_ENUM(NSUInteger,SYZDateDayStyle) {
    /**  不是前天、昨天、今天、明天、后天的情况 */
    SYZDateDayStyleNoKnown,
    /**  前天 */
    SYZDateDayStyleBeforeYesterday,
    /**  昨天 */
    SYZDateDayStyleYesterday,
    /**  今天 */
    SYZDateDayStyleToday = 0,
    /**  明天 */
    SYZDateDayStyleTomorrow,
    /**  后天 */
    SYZDateDayStyleAfterTomorrow
};

/**  秒级的长度 */
extern unsigned int SYZ_kTimeStampSecondLength;

/**  毫秒级的长度 */
extern unsigned int SYZ_kTimeStampMilliSecondLength;

/**  是否是正常的时间戳（字符串) */
extern BOOL SYZ_IsNormalTimeStampString(NSString * aTimeStamp);

/**  是否是正常的时间戳(NSNumber型) */
extern BOOL SYZ_IsNormalTimeStampNumber(NSNumber * aTimeStamp);
#endif /* SYZDateEnum_h */







