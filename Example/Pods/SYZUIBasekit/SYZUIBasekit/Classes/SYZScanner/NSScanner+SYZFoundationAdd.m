//
//  NSScanner+SYZFoundationAdd.m
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import "NSScanner+SYZFoundationAdd.h"

@implementation NSScanner (SYZFoundationAdd)

@end
@implementation NSString (SYZScannerAdd)

- (BOOL)syz_isIntegerValue {
    
    NSScanner * scanner = [NSScanner scannerWithString:self];
    
    NSInteger scanedValue;
    BOOL scanRes = [scanner scanInteger:&scanedValue];
    
    return scanRes && scanner.atEnd;
}

- (BOOL)syz_isFloatValue {
    
    NSScanner * scanner = [NSScanner scannerWithString:self];
    
    float scanedValue;
    BOOL scanRes = [scanner scanFloat:&scanedValue];
    
    return scanRes && scanner.atEnd;
}

/**
 是否是 纯字符串
 */
- (BOOL)syz_isAllString {
    return [[self syz_scanStringWithSet:[NSCharacterSet letterCharacterSet]] isEqualToString:self];
}

/**
 是否 全是大写字母
 */
- (BOOL)syz_isAllUpperString {
    return [[self syz_scanStringWithSet:[NSCharacterSet uppercaseLetterCharacterSet]] isEqualToString:self];
}

/**
 是否 全是小写字母
 */
- (BOOL)syz_isAllLowerString {
    return [[self syz_scanStringWithSet:[NSCharacterSet lowercaseLetterCharacterSet]] isEqualToString:self];
}

- (NSString *)syz_scanStringWithSet:(NSCharacterSet *)charSet {
    NSScanner * scanner = [NSScanner scannerWithString:self];
    NSString * scannedString = nil;
    [scanner scanCharactersFromSet:charSet intoString:&scannedString];
    return scannedString;
}

@end
