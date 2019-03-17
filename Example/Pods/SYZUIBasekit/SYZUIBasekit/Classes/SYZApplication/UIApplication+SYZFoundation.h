//
//  UIApplication+SYZFoundation.h
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SYZFoundation)

/** 应用id*/
+ (NSString *)syz_bundleId;

/** 应用版本号*/
+ (NSString *)syz_version;

/** 应用build号,剔除所有小数点*/
+ (NSString *)syz_buildNumber;

/** 应用build号*/
+ (NSString *)syz_fullBuildNumber;
@end
