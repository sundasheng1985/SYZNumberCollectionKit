//
//  UIDevice+SYZDevice.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/12/1.
//

#import "UIDevice+SYZDevice.h"
#import <objc/runtime.h>
#include <errno.h>
#include <sys/sysctl.h>
#import <mach/machine.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface UIDevice ()
@property (nonatomic,assign) UIInterfaceOrientationMask syz_orientation;
@end

/*是否是模拟器*/
BOOL SYZIsSimulater(void) {
    return [UIDevice syz_isSimulator];
}

/*是否是真机*/
BOOL SYZIsPhysical(void) {
    return [UIDevice syz_isPhysical];
}

/*是否是跑测试*/
BOOL SYZisRunningTests(void)
{
    return [([NSProcessInfo processInfo].environment[@"XCInjectBundle"]).pathExtension isEqualToString:@"octest"];
}
@implementation UIDevice (SYZDevice)
/** 系统版本*/
+ (CGFloat)syz_systemVersion {
    static CGFloat _systemVersion = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    });
    
    return _systemVersion;
}

+ (BOOL)syz_greaterThan:(NSString *)sysVer {
    return [self syz_systemVersion] >= sysVer.floatValue;
}
+ (BOOL)syz_lessThan:(NSString *)sysVer {
    return [self syz_systemVersion] <= sysVer.floatValue;
}

/** 系统大于6.0*/
+ (BOOL)syz_greaterThan6 {
    return [self syz_greaterThan:@"6.0"];
}
/** 系统版本小于6.0*/
+ (BOOL)syz_lessThan6 {
    return [self syz_lessThan:@"6.0"];
}

/** 系统大于7.0*/
+ (BOOL)syz_greaterThan7 {
    return [self syz_greaterThan:@"7.0"];
}
/** 系统版本小于7.0*/
+ (BOOL)syz_lessThan7 {
    return [self syz_lessThan:@"7.0"];
}

/** 系统大于8.0*/
+ (BOOL)syz_greaterThan8 {
    return [self syz_greaterThan:@"8.0"];
}
/** 系统版本小于8.0*/
+ (BOOL)syz_lessThan8 {
    return [self syz_lessThan:@"8.0"];
}

/** 系统大于9.0*/
+ (BOOL)syz_greaterThan9 {
    return [self syz_greaterThan:@"9.0"];
}
/** 系统版本小于9.0*/
+ (BOOL)syz_lessThan9 {
    return [self syz_lessThan:@"9.0"];
}

/** 系统大于10.0 */
+ (BOOL)syz_greaterThan10 {
    return [self syz_greaterThan:@"10.0"];
}
/** 系统版本小于10.0 */
+ (BOOL)syz_lessThan10 {
    return [self syz_lessThan:@"10.0"];
}

/* 是否是模拟器 */
+ (BOOL)syz_isSimulator {
#if TARGET_IPHONE_SIMULATOR
    return YES;
#else
    return NO;
#endif // #if TARGET_IPHONE_SIMULATOR
}

/* 是否是真机 */
+ (BOOL)syz_isPhysical {
    return ![self syz_isSimulator];
}

/** 设置当前设备横竖屏方向 */
+ (void)syz_setDeviceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        invocation.selector = selector;
        invocation.target = [UIDevice currentDevice];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/** 获取旋转角度*/
+ (CGAffineTransform)syz_getTransformRotationAngle:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

/** 强制横屏 */
+ (void)syz_setDeviceOrientationLandscapeRight {
    [self syz_setDeviceOrientation:UIInterfaceOrientationLandscapeRight];
}

/** 强制横屏 */
+ (void)syz_setDeviceOrientationLandscapeLeft {
    [self syz_setDeviceOrientation:UIInterfaceOrientationLandscapeLeft];
}

/** 强制竖屏 */
+ (void)syz_setDeviceOrientationPortrait {
    [self syz_setDeviceOrientation:UIInterfaceOrientationPortrait];
}

#pragma mark - 控制app界面的横竖屏
/** 可以横竖屏切换 */
+ (void)allowOrientationAll {
    [[UIDevice currentDevice] setsyz_orientation:UIInterfaceOrientationMaskAll];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (orientation == UIDeviceOrientationLandscapeLeft ||
        orientation == UIDeviceOrientationLandscapeRight) {
        [self syz_setDeviceOrientationLandscapeRight];
    } else {
        [self syz_setDeviceOrientationPortrait];
    }
}

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscape {
    [[UIDevice currentDevice] setsyz_orientation:UIInterfaceOrientationMaskLandscape];
    [self syz_setDeviceOrientationLandscapeRight];
}

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscapeLeft {
    [[UIDevice currentDevice] setsyz_orientation:UIInterfaceOrientationMaskLandscapeLeft];
    [self syz_setDeviceOrientationLandscapeLeft];
}

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscapeRight {
    [[UIDevice currentDevice] setsyz_orientation:UIInterfaceOrientationMaskLandscapeRight];
    [self syz_setDeviceOrientationLandscapeRight];
}

/**只能竖屏*/
+ (void)allowOrientationOnlyPortrait {
    [[UIDevice currentDevice] setsyz_orientation:UIInterfaceOrientationMaskPortrait];
    [self syz_setDeviceOrientationPortrait];
}

- (UIInterfaceOrientationMask)syz_orientation {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setsyz_orientation:(UIInterfaceOrientationMask)syz_orientation {
    objc_setAssociatedObject(self,
                             @selector(syz_orientation),
                             @(syz_orientation),
                             OBJC_ASSOCIATION_COPY);
}

/** 是否是iphoneX*/
- (BOOL)syz_isiPhoneX {
    static BOOL _syz_isiPhoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _syz_isiPhoneX = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
    });
    return _syz_isiPhoneX;
}

#pragma mark - 设备信息
static NSString*    syz_systVersion;
static NSString*    syz_systVersionPatch;
static int          syz_sysctl_err; // Sticky error after last call
+ (NSString*)syz_machine {
    char str[256];
    size_t size = sizeof(str);
    syz_sysctl_err = sysctlbyname("hw.machine", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)syz_model {
    char str[256];
    size_t size = sizeof(str);
    syz_sysctl_err = sysctlbyname("hw.model", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)syz_cpu {
    
    int cputype;
    size_t size = sizeof(cputype);
    syz_sysctl_err = sysctlbyname("hw.cputype", &cputype, &size, NULL, 0);
    
    
    switch (cputype) {
        case CPU_TYPE_MC680x0:
            return @"mc680x0";
        case CPU_TYPE_I386:
            return @"i386";
        case CPU_TYPE_X86_64:
            return @"x86_64";
        case CPU_TYPE_ARM:
            return @"arm";
        case CPU_TYPE_ARM64:
            return @"arm64";
        default:
            return @"unknown";
    }
}

+ (NSInteger)syz_byteorder {
    int byteorder;
    size_t size = sizeof(byteorder);
    syz_sysctl_err = sysctlbyname("hw.byteorder", &byteorder, &size, NULL, 0);
    return byteorder;
}

+ (NSString*)syz_architecture {
    char str[256];
    size_t size = sizeof(str);
    syz_sysctl_err = sysctlbyname("hw.arch", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)kernelVersion {
    char str[256];
    size_t size = sizeof(str);
    syz_sysctl_err = sysctlbyname("kern.version", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

#pragma mark - System

+ (NSString*)kernelRelease {
    char str[256];
    size_t size = sizeof(str);
    syz_sysctl_err = sysctlbyname("kern.osrelease", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)kernelRevision {
    char str[256];
    size_t size = sizeof(str);
    syz_sysctl_err = sysctlbyname("kern.osrev", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)syz_systemVersionPatch {
    NSOperatingSystemVersion opSystVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (!syz_systVersionPatch) {
        syz_systVersionPatch = [NSString stringWithFormat:@"%lu.%lu.%lu",(unsigned long)opSystVersion.majorVersion,(unsigned long)opSystVersion.minorVersion,(unsigned long)opSystVersion.patchVersion];
    }
    return syz_systVersionPatch;
}

+ (NSString *)syz_phoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 2G";
    } else if([platform isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    } else if([platform isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    } else if([platform isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    } else if([platform isEqualToString:@"iPhone3,2"]) {
        return @"iPhone 4";
    } else if([platform isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4";
    } else if([platform isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    } else if([platform isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5";
    } else if([platform isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    } else if([platform isEqualToString:@"iPhone5,3"]) {
        return @"iPhone 5c";
    } else if([platform isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c";
    } else if([platform isEqualToString:@"iPhone6,1"]) {
        return @"iPhone 5s";
    } else if([platform isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s";
    } else if([platform isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    } else if([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    } else if([platform isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    } else if([platform isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    } else if([platform isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    } else if([platform isEqualToString:@"iPhone9,1"]) {
        return @"iPhone 7";
    } else if([platform isEqualToString:@"iPhone9,2"]) {
        return @"iPhone 7 Plus";
    } else if([platform isEqualToString:@"iPhone10,1"]) {
        return @"iPhone 8";
    } else if([platform isEqualToString:@"iPhone10,4"]) {
        return @"iPhone 8";
    } else if([platform isEqualToString:@"iPhone10,2"]) {
        return @"iPhone 8 Plus";
    } else if([platform isEqualToString:@"iPhone10,5"]) {
        return @"iPhone 8 Plus";
    } else if([platform isEqualToString:@"iPhone10,3"]) {
        return @"iPhone X";
    } else if([platform isEqualToString:@"iPhone10,6"]) {
        return @"iPhone X";
    } else if([platform isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch 1G";
    } else if([platform isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2G";
    } else if([platform isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3G";
    } else if([platform isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4G";
    } else if([platform isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5G";
    } else if([platform isEqualToString:@"iPad1,1"]) {
        return @"iPad 1G";
    } else if([platform isEqualToString:@"iPad2,1"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,2"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,3"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,4"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,5"]) {
        return @"iPad Mini 1G";
    } else if([platform isEqualToString:@"iPad2,6"]) {
        return @"iPad Mini 1G";
    } else if([platform isEqualToString:@"iPad2,7"]) {
        return @"iPad Mini 1G";
    } else if([platform isEqualToString:@"iPad3,1"]) {
        return @"iPad 3";
    } else if([platform isEqualToString:@"iPad3,2"]) {
        return @"iPad 3";
    } else if([platform isEqualToString:@"iPad3,3"]) {
        return @"iPad 3";
    } else if([platform isEqualToString:@"iPad3,4"]) {
        return @"iPad 4";
    } else if([platform isEqualToString:@"iPad3,5"]) {
        return @"iPad 4";
    } else if([platform isEqualToString:@"iPad3,6"]) {
        return @"iPad 4";
    } else if([platform isEqualToString:@"iPad4,1"]) {
        return @"iPad Air";
    } else if([platform isEqualToString:@"iPad4,2"]) {
        return @"iPad Air";
    } else if([platform isEqualToString:@"iPad4,3"]) {
        return @"iPad Air";
    } else if([platform isEqualToString:@"iPad4,4"]) {
        return @"iPad Mini 2G";
    } else if([platform isEqualToString:@"iPad4,5"]) {
        return @"iPad Mini 2G";
    } else if([platform isEqualToString:@"iPad4,6"]) {
        return @"iPad Mini 2G";
    } else if([platform isEqualToString:@"iPad4,7"]) {
        return @"iPad Mini 3";
    } else if([platform isEqualToString:@"iPad4,8"]) {
        return @"iPad Mini 3";
    } else if([platform isEqualToString:@"iPad4,9"]) {
        return @"iPad Mini 3";
    } else if([platform isEqualToString:@"iPad5,1"]) {
        return @"iPad Mini 4";
    } else if([platform isEqualToString:@"iPad5,2"]) {
        return @"iPad Mini 4";
    } else if([platform isEqualToString:@"iPad5,3"]) {
        return @"iPad Air 2";
    } else if([platform isEqualToString:@"iPad5,4"]) {
        return @"iPad Air 2";
    } else if([platform isEqualToString:@"iPad6,3"]) {
        return @"iPad Pro 9.7";
    } else if([platform isEqualToString:@"iPad6,4"]) {
        return @"iPad Pro 9.7";
    } else if([platform isEqualToString:@"iPad6,7"]) {
        return @"iPad Pro 12.9";
    } else if([platform isEqualToString:@"iPad6,8"]) {
        return @"iPad Pro 12.9";
    } else if([platform isEqualToString:@"i386"]) {
        return @"iPhone Simulator";
    } else if([platform isEqualToString:@"x86_64"]) {
        return @"iPhone Simulator";
    }
    return @"unknow";
}

+ (NSString *)syz_ip {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // 检索当前接口,在成功时,返回0
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 循环链表的接口
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 检查接口是否en0 wifi连接在iPhone上
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 得到NSString从C字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // 释放内存
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)syz_phoneSystemName {
    static NSString *systemName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemName = [UIDevice currentDevice].systemName;
    });
    return systemName;
}

/** 手机运营商 */
+ (NSString *)syz_mobileOperators {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (!carrier.isoCountryCode) {
        return @"无运营商";
    } else {
        return [carrier carrierName];
    }
}

@end
