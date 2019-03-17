//
//  UIDevice+SYZDevice.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/12/1.
//

#import <UIKit/UIKit.h>

/**  是否是模拟器 */
extern BOOL SYZIsSimulater(void);

/**  是否是真机 */
extern BOOL SYZIsPhysical(void);

/**  是否是单元测试 */
extern BOOL SYZIsRunningTests(void);
@interface UIDevice (SYZDevice)

/**  iOS系统版本 */
+ (CGFloat)syz_systemVersion;

+ (BOOL)syz_greaterThan:(NSString *)sysVer;
+ (BOOL)syz_lessThan:(NSString *)sysVer;

/** 系统大于6.0 */
+ (BOOL)syz_greaterThan6;
/** 系统版本小于6.0 */
+ (BOOL)syz_lessThan6;

/** 系统大于7.0 */
+ (BOOL)syz_greaterThan7;
/** 系统版本小于7.0 */
+ (BOOL)syz_lessThan7;

/** 系统大于8.0 */
+ (BOOL)syz_greaterThan8;
/** 系统版本小于8.0 */
+ (BOOL)syz_lessThan8;

/** 系统大于9.0 */
+ (BOOL)syz_greaterThan9;
/** 系统版本小于9.0 */
+ (BOOL)syz_lessThan9;

/** 系统大于10.0 */
+ (BOOL)syz_greaterThan10;
/** 系统版本小于10.0 */
+ (BOOL)syz_lessThan10;

/**  是否是模拟器 */
+ (BOOL)syz_isSimulator;

/**  是否是真机 */
+ (BOOL)syz_isPhysical;

/**  设置当前设备横竖屏方向 */
+ (void)syz_setDeviceOrientation:(UIInterfaceOrientation)orientation;

/**  强制横屏 */
+ (void)syz_setDeviceOrientationLandscapeRight;

/**  强制横屏 */
+ (void)syz_setDeviceOrientationLandscapeLeft;

/**  强制竖屏 */
+ (void)syz_setDeviceOrientationPortrait;

#pragma mark - 控制app界面的横竖屏
/** 可以横竖屏切换 */
+ (void)allowOrientationAll;

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscape;

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscapeRight;

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscapeLeft;

/** 只能竖屏 */
+ (void)allowOrientationOnlyPortrait;
@property (nonatomic,assign,readonly) UIInterfaceOrientationMask syz_orientation;

/** 获取旋转角度*/
+ (CGAffineTransform)syz_getTransformRotationAngle:(UIInterfaceOrientation)orientation;

/** 是否是iphoneX*/
- (BOOL)syz_isiPhoneX;

#pragma mark - 设备信息
+ (NSString*)syz_machine;

+ (NSString*)syz_model;

+ (NSString*)syz_cpu;

+ (NSInteger)syz_byteorder;

+ (NSString*)syz_architecture;

+ (NSString*)kernelVersion;

+ (NSString*)kernelRelease;

+ (NSString*)kernelRevision;

+ (NSString*)syz_systemVersionPatch;

/** 手机机型 */
+ (NSString *)syz_phoneModel;

/** ip */
+ (NSString *)syz_ip;

/** 手机操作系统 */
+ (NSString *)syz_phoneSystemName;

/** 手机运营商 */
+ (NSString *)syz_mobileOperators;
@end
