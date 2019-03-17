//
//  NSAttributedString+SYZAdditon.m
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSAttributedString+SYZAdditon.h"

@implementation NSAttributedString (SYZAdditon)
- (NSRange)syz_allRange {
    return NSMakeRange(0, self.length);
}

- (BOOL)syz_isValidRange:(NSRange)range {
    return NSEqualRanges(NSIntersectionRange(self.syz_allRange, range), range);
}
- (BOOL)syz_isInvalidRange:(NSRange)range {
    return ![self syz_isValidRange:range];
}

- (NSMutableAttributedString *)syz_toMutableAttributedString {
    if ([self isKindOfClass:[NSMutableAttributedString class]]) {
        return [self mutableCopy];
    }
    
    return [self mutableCopy];
}

@end
