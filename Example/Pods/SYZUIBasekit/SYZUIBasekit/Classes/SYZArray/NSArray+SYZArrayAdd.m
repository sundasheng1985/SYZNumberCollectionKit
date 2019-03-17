//
//  NSArray+SYZArrayAdd.m
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import "NSArray+SYZArrayAdd.h"

@implementation NSArray (SYZArrayAdd)
BOOL SYZIsEmptyArray(NSArray *array) {
    if (SYZIsEmpty(array) || NO == [array syz_isNSArray]) {
        return YES;
    }
    
    return array.count == 0;
}

/**
 *  不是空数组
 */
BOOL SYZIsNotEmptyArray(NSArray *array) {
    return !SYZIsEmptyArray(array);
}

NSArray * SYZNoNilArray(id array)
{
    if (SYZIsEmpty(array)) {
        return @[];
    }
    
    return array;
}

/*!
 *  删除第一个元素
 */
- (NSArray *)syz_removeFirstObject {
    
    if (self.count <= 1) {
        return @[];
    }
    
    return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
}

- (NSArray *)syz_insertObjectAtFirst:(id)obj {
    if (SYZIsEmpty(obj)) {
        return self;
    }
    
    return [@[obj] arrayByAddingObjectsFromArray:self];
}

- (NSArray *)syz_insertObjectAtLast:(id)obj {
    if (SYZIsEmpty(obj)) {
        return self;
    }
    
    return [self arrayByAddingObject:obj];
}

/** 转成可变字典，如果本身是NSArray，则执行mutableCopy方法，
 如果是NSMutableArray，则直接返回*/
- (NSMutableArray*)syz_toMutable {
    return self.mutableCopy;
}

/*!
 *  删除最后一个元素
 */
- (NSArray *)syz_removeLastObject {
    
    if (self.count <= 1) {
        return @[];
    }
    
    return [self subarrayWithRange:NSMakeRange(0, self.count - 1)];
}

/*!
 *  删除存在的指定元素
 */
- (NSArray *)syz_removeObjectIfExists:(_Nonnull id)obj {
    
    if (NO == [self containsObject:obj]) {
        
        return self;
    }
    
    NSMutableArray * aArrayM = [[NSMutableArray alloc] initWithArray:self];
    if ([aArrayM containsObject:obj]) {
        
        [aArrayM removeObject:obj];
    }
    
    return aArrayM;
}

/*!
 *  删除指定索引的元素
 */
- (NSArray *)syz_removeObjectAtIndex:(NSInteger)index {
    
    if (self.count <= 0) {
        return self;
    }
    
    if (NO == [self syz_isValidIndex:index]) {
        return self;
    }
    
    id obj = self[index];
    return [self syz_removeObjectIfExists:obj];
}

/**
 第一个元素
 */
- (id)syz_firstObject {
    if (SYZIsNotEmptyArray(self)) {
        return self.firstObject;
    }
    
    return nil;
}

/**
 最后一个元素
 */
- (id)syz_lastObject {
    if (SYZIsNotEmptyArray(self)) {
        return self.lastObject;
    }
    
    return nil;
}


/*!
 *  删除元素组
 */
- (NSArray *)syz_removeObjects:(NSArray *)objs {
    
    NSMutableArray * aArrayM = [[NSMutableArray alloc] initWithArray:self];
    for (id obj in objs) {
        
        if ([aArrayM containsObject:obj]) {
            
            [aArrayM removeObject:obj];
        }
    }
    
    return aArrayM;
}

/**
 从 0 到 toIndex，不包含toIndex所指向的元素
 */
- (NSArray *)syz_subArrayToIndex:(NSUInteger)toIndex {
    if ([self syz_isValidIndex:(toIndex - 1)]) {
        NSUInteger count = toIndex;
        return [self subarrayWithRange:NSMakeRange(0, count)];
    }
    
    return @[];
}
/**
 从 fromIndex 到 最后一个元素，包含fromIndex所指向的元素
 */
- (NSArray *)syz_subArrayFromIndex:(NSUInteger)fromIndex {
    if ([self syz_isValidIndex:fromIndex]) {
        return [self subarrayWithRange:NSMakeRange(fromIndex, self.count - fromIndex)];
    }
    
    return @[];
}

/**
 不包含obj
 */
- (NSArray *)syz_subArrayToObject:(id)obj {
    if (SYZIsNotEmpty(obj)) {
        return [self syz_subArrayToIndex:[self indexOfObject:obj]];
    }
    
    return @[];
}
/**
 包含obj
 */
- (NSArray *)syz_subArrayFromObject:(id)obj {
    if (SYZIsNotEmpty(obj)) {
        return [self syz_subArrayFromIndex:[self indexOfObject:obj]];
    }
    return @[];
}


- (NSArray *)syz_reversedObjects {
    
    if (self.count <= 1) {
        return self;
    }
    
    return [self reverseObjectEnumerator].allObjects;
}

/**
 *  取到对应索引的对象，如果index越界会返回cls的实例
 */
- (id)syz_objectAtIndex:(NSInteger)index class:(Class)cls {
    
    if ([self syz_isValidIndex:index]) {
        
        return self[index];
    }
    
    return [[cls alloc] init];
}

- (BOOL)syz_isValidIndex:(NSInteger)index {
    
    return (index >= 0 && index < self.count);
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // for-in all objects
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

/**
 NSArray ==> NSSet
 */
- (NSSet *)syz_toSet {
    return [NSSet setWithArray:self];
}
/**
 NSArray ==> NSMutableSett
 */
- (NSMutableSet *)syz_toMutableSet {
    return [NSMutableSet setWithArray:self];
}
/**
 组合Array，允许相同obj存在
 */
- (NSArray *)syz_appendingArray:(NSArray * _Nullable)aArray {
    if (SYZIsEmptyArray(aArray)) {
        return self;
    }
    if (SYZIsEmptyArray(self)) {
        return aArray;
    }
    return [self arrayByAddingObjectsFromArray:aArray];
}
- (NSArray *)syz_appendingObject:(NSObject * _Nullable)aObj {
    if (SYZIsEmpty(aObj)) {
        return self;
    }
    return [self syz_appendingArray:@[aObj]];
}
/**
 组合Array，obj唯一
 */
- (NSArray *)syz_appendingArrayUnique:(NSArray * _Nullable)aArray {
    if (SYZIsEmptyArray(aArray)) {
        return self;
    }
    if (SYZIsEmptyArray(self)) {
        return aArray;
    }
    
    NSMutableArray * selfArrayM = [self mutableCopy];
    for (id obj in aArray) {
        if (NO == [self containsObject:obj]) {
            [selfArrayM addObject:obj];
        }
    }
    return [selfArrayM copy];
}
- (NSArray *)syz_appendingObjectUnique:(NSObject *_Nullable)aObj {
    if (SYZIsEmpty(aObj)) {
        return self;
    }
    return [self syz_appendingArrayUnique:@[aObj]];
}

/**
 是否包含aArray中的所有元素，不关心顺序
 */
- (BOOL)syz_containArray:(NSArray *_Nullable)aArray {
    if (SYZIsEmptyArray(aArray)) {
        return NO;
    }
    __block BOOL contain = YES;
    [aArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [self containsObject:obj]) {
            contain = NO;
            *stop = YES;
        }
    }];
    return contain;
}

#pragma mark - "循环"获取前一个/后一个索引/对象
/**
 获取前一个对象索引
 */
- (NSUInteger)syz_preIndexForObject:(nullable id)obj {
    NSUInteger curIndex = [self indexOfObject:obj];
    NSUInteger preIndex = curIndex;
    if (curIndex != NSNotFound) {
        preIndex = (curIndex - 1 + self.count) % self.count;
    }
    
    return preIndex;
}
/**
 获取前一个对象
 */
- (id)syz_preObjectForObject:(nullable id)obj {
    NSUInteger preIndex = [self syz_preIndexForObject:obj];
    if ([self syz_isValidIndex:preIndex]) {
        return [self objectAtIndex:preIndex];
    }
    return nil;
}
/**
 获取后一个对象索引
 */
- (NSUInteger)syz_nextIndexForObject:(nullable id)obj {
    NSUInteger curIndex = [self indexOfObject:obj];
    NSUInteger nextIndex = curIndex;
    if (curIndex != NSNotFound) {
        nextIndex = (curIndex + 1) % self.count;
    }
    
    return nextIndex;
}
/**
 获取后一个对象
 */
- (id)syz_nextObjectForObject:(nullable id)obj {
    NSUInteger nextIndex = [self syz_nextIndexForObject:obj];
    if ([self syz_isValidIndex:nextIndex]) {
        return [self objectAtIndex:nextIndex];
    }
    return nil;
}

/**
 转义字符
 */
- (id)syz_replacingPercentEscapes {
    NSMutableArray * params = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [params addObject:[obj syz_replacingPercentEscapes]];
    }];
    return [params copy];
}

@end
