//
//  NSObject+SYZObject.m
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import "NSObject+SYZObject.h"
#import <objc/runtime.h>

NSString * SYZAvoidCrashExceptionNotification = @"SYZAvoidCrashExceptionNotification";
@implementation NSObject (SYZObject)

BOOL SYZIsEmpty(id obj){
    return ((obj) == nil || [(obj) isEqual:[NSNull null]]);
}

BOOL SYZIsNotEmpty(id obj) {
    return !SYZIsEmpty(obj);
}

+ (void)exchangeInstanceMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod {
    Method origin = class_getInstanceMethod(aClass, oriMethod);
    Method new = class_getInstanceMethod(aClass, newMethod);
    method_exchangeImplementations(origin, new);
}

+ (void)exchangeClassMethod:(SEL)oriMethod toMethod:(SEL)newMethod {
    [NSObject exchangeClassMethod:[self class] method:oriMethod toMethod:newMethod];
}

+ (void)exchangeClassMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod {
    Method origin = class_getClassMethod(aClass, oriMethod);
    Method new = class_getClassMethod(aClass, newMethod);
    method_exchangeImplementations(origin, new);
}

+ (void)exchangeInstanceMethod:(SEL)oriMethod toMethod:(SEL)newMethod {
    [NSObject exchangeInstanceMethod:[self class] method:oriMethod toMethod:newMethod];
}

+ (void)notiException:(NSException *)exception appendingInfo:(NSString *)info {
    if (NO == [exception isKindOfClass:[NSException class]]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SYZAvoidCrashExceptionNotification object:exception];
}

- (void)notiException:(NSException *)exception appendingInfo:(NSString *)info {
    [[self class] notiException:exception appendingInfo:info];
}

#pragma mark - 类型判断
- (BOOL)syz_isNSDictionary {
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)syz_isNSArray {
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)syz_isNSString {
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)syz_isNSNumber {
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)syz_isNSNumberBool {
    if(self == (id)kCFBooleanFalse || self == (id)kCFBooleanTrue) {
        return YES;
    }
    return NO;
}

- (BOOL)syz_isNSDate {
    return [self isKindOfClass:[NSDate class]];
}

- (BOOL)syz_isNSNull {
    return [self isKindOfClass:[NSNull class]];
}

- (BOOL)syz_isUIViewController {
    return [self isKindOfClass:[UIViewController class]];
}
- (BOOL)syz_isUINavigationController {
    return [self isKindOfClass:[UINavigationController class]];
}

- (BOOL)syz_isNSError {
    return [self isKindOfClass:[NSError class]];
}

#pragma mark - 转换
- (NSString *)syz_toString {
    return @"";
}
- (NSNumber *)syz_toNumber {
    return @0;
}

/**
 转义字符
 */
- (id)syz_replacingPercentEscapes {
    return self;
}

#pragma mark - 系统判断

/** iOS11*/
- (BOOL)syz_iOS11Available {
    if(@available(iOS 11.0,*)) {
        return YES;
    }
    return NO;
}

- (BOOL)syz_iOS10Available {
    if (@available(iOS 10.0,*)) {
        return YES;
    }
    return NO;
}

@end
