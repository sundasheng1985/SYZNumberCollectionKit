//
//  UIApplication+SYZFoundation.m
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import "UIApplication+SYZFoundation.h"

@implementation UIApplication (SYZFoundation)

/** 应用id*/
+ (NSString *)syz_bundleId {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
}

/** 应用版本号*/
+ (NSString *)syz_version {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

/** 应用build号,剔除所有小数点*/
+ (NSString *)syz_buildNumber {
    NSString *build = [[self class] syz_fullBuildNumber];
    NSScanner* scanner = [NSScanner scannerWithString:build];
    NSInteger realBuild;
    [scanner scanInteger:&realBuild];
    return @(realBuild).stringValue;

}

/** 应用build号*/
+ (NSString *)syz_fullBuildNumber {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

@end
