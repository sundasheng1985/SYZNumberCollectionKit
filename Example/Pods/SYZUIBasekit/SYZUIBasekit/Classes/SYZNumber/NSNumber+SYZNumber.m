//
//  NSNumber+SYZNumber.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/10/30.
//

#import "NSNumber+SYZNumber.h"

NSNumber * const SYZNoNilNumber(NSNumber *number) {
    if (SYZIsEmpty(number)) {
        return @(0);
    }
    
    return number;
}

@implementation NSNumber (SYZNumber)

- (NSString *)syz_toString {
    
    return self.stringValue;
}

- (NSNumber *)syz_toNumber {
    return self;
}

- (BOOL)syz_isEqualToNumber:(NSNumber *)aNumber {
    if ([self isEqual:aNumber]) {
        return YES;
    }
    
    return [[self syz_toString] isEqualToString:[aNumber syz_toString]];
}

- (NSString *)syz_numberByAppendingString:(NSString *)aString {
    return [self.stringValue stringByAppendingString:aString];
}

- (NSString *)syz_toSimpleNumber {
    NSString * countStr = self.stringValue;
    
    if (NO == [countStr syz_isIntegerValue] && [countStr syz_isFloatValue] == NO) {
        return countStr;
    }

    if (countStr.length >= 9) {
        return [NSString stringWithFormat:@"%.2f亿",self.longLongValue / 1000000000.0];
    } else if (countStr.length >= 5) {
        return [NSString stringWithFormat:@"%.2f万",self.longLongValue / 10000.0];
    }
    
    return countStr;
}

@end
