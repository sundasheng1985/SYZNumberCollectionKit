//
//  NSSet+SYZFoundationAdd.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/12/1.
//

#import "NSSet+SYZFoundationAdd.h"

BOOL SYZIsEmptySet(NSSet *set) {
    if (SYZIsEmptyArray([set syz_toArray])) {
        return YES;
    }
    
    return NO;
}

BOOL SYZIsNotEmptySet(NSSet *set) {
    return !SYZIsEmptySet(set);
}

@implementation NSSet (SYZFoundationAdd)

- (NSArray *)syz_toArray {
    return self.allObjects;
}

- (NSMutableArray *)syz_toMutableArray {
    return self.allObjects.mutableCopy;
}

- (NSSet *)syz_removeObject:(id)obj {
    if (SYZIsEmpty(obj) || SYZIsEmptySet(self)) {
        return self;
    }
    
    NSMutableSet * setM = [self mutableCopy];
    [setM minusSet:[NSSet setWithObject:obj]];
    return setM;
}
@end
