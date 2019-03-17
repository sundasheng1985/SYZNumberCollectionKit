//
//  NSMutableArray+syzMutableArrayAdd.m
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import "NSMutableArray+SYZMutableArrayAdd.h"
#import <SYZUIBasekit/NSObject+SYZObject.h>
#import <SYZUIBasekit/NSArray+SYZArrayAdd.h>

@implementation NSMutableArray (SYZMutableArrayAdd)


/**
 *  添加一个元素，如果传入的obj为空，则忽略
 */
- (NSMutableArray *)syz_addObject:(_Nullable id)obj {
    
    id object = obj;
    
    if (SYZIsEmpty(object)) {
        
        //        syzLogWarn(@"传入的obj为空");
        return self;
    }
    
    [self addObject:object];
    
    return self;
}

- (NSMutableArray *)syz_removeObjects:(NSArray *)objs {
    
    return nil;
}

/**
 移除第一个元素
 */
- (NSMutableArray *)syz_removeFirstObject {
    if (SYZIsNotEmptyArray(self)) {
        [self removeObjectAtIndex:0];
    }
    
    return self;
}

- (NSMutableArray *)syz_removeLastObject {
    if (SYZIsNotEmptyArray(self)) {
        [self removeLastObject];
    }
    return self;
}

/**
 在数组的最后添加元素
 */
- (NSMutableArray *)syz_insertObjectAtLast:(id)obj {
    if (SYZIsEmpty(obj)) {
        return self;
    }
    
    [self addObject:obj];
    return self;
}

@end
