//
//  NSTimer+SYZTimer.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/10/28.
//

#import "NSTimer+SYZTimer.h"

@implementation NSTimer (SYZTimer)
- (void)syz_invalidate {
    if (self.isValid) {
        self.fireDate = [NSDate distantFuture];
        [self invalidate];
    }
}
@end
