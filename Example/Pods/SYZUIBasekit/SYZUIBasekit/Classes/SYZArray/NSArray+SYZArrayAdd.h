//
//  NSArray+SYZArrayAdd.h
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>

NS_ASSUME_NONNULL_BEGIN
/** 是否是空数组 */
extern BOOL SYZIsEmptyArray(NSArray *array);

/** 不是空数组 */
extern BOOL SYZIsNotEmptyArray(NSArray *array);

/** 防止出现空数组 */
extern NSArray * _Nonnull SYZNoNilArray(id array);

@interface NSArray (SYZArrayAdd)

/** 删除存在的指定元素 */
- (NSArray *)syz_removeObjectIfExists:(_Nonnull id)obj;

/** 删除指定索引的元素 */
- (NSArray *)syz_removeObjectAtIndex:(NSInteger)index;

/** 转成可变字典，如果本身是NSArray，则执行mutableCopy方法，
 如果是NSMutableArray，则直接返回*/
- (NSMutableArray*)syz_toMutable;

/** 获取第一个元素 */
- (id)syz_firstObject;

/** 最后一个元素 */
- (id)syz_lastObject;

/** 移除第一个元素 */
- (NSArray *)syz_removeFirstObject;

/** 移除最后一个元素 */
- (NSArray *)syz_removeLastObject;

/** index = 0 插入一个元素 */
- (NSArray *)syz_insertObjectAtFirst:(id)obj;

/** 在数组的最后添加元素 */
- (NSArray *)syz_insertObjectAtLast:(id)obj;

/** 删除元素组 */
- (NSArray *)syz_removeObjects:(NSArray *)objs;

/** 从 0 到 toIndex，不包含toIndex所指向的元素 */
- (NSArray *)syz_subArrayToIndex:(NSUInteger)toIndex;

/** 从 fromIndex 到 最后一个元素，包含fromIndex所指向的元素 */
- (NSArray *)syz_subArrayFromIndex:(NSUInteger)fromIndex;

/** 不包含obj */
- (NSArray *)syz_subArrayToObject:(id)obj;

/** 包含obj */
- (NSArray *)syz_subArrayFromObject:(id)obj;

/** 倒序数组：如：[a,b,c] ====> [c,b,a] */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray * _Nonnull syz_reversedObjects;

/** 取到对应索引的对象，如果index越界会返回cls的实例 */
- (id)syz_objectAtIndex:(NSInteger)index class:(Class)cls;

/** 是否是有效的索引 */
- (BOOL)syz_isValidIndex:(NSInteger)index;

/** NSArray ==> NSSet */
- (NSSet *)syz_toSet;

/** NSArray ==> NSMutableSett */
- (NSMutableSet *)syz_toMutableSet;

/** 组合Array，允许相同obj存在 */
- (NSArray *)syz_appendingArray:(NSArray * _Nullable)aArray;
- (NSArray *)syz_appendingObject:(NSObject * _Nullable)aObj;

/** 组合Array，obj唯一 */
- (NSArray *)syz_appendingArrayUnique:(NSArray * _Nullable)aArray;
- (NSArray *)syz_appendingObjectUnique:(NSObject *_Nullable)aObj;

/** 是否包含aArray中的所有元素，不关心顺序 */
- (BOOL)syz_containArray:(NSArray *_Nullable)aArray;

#pragma mark - "循环"获取前一个/后一个索引/对象
/**
 获取前一个对象索引，找不到为NSNotFound
 */
- (NSUInteger)syz_preIndexForObject:(nullable id)obj;
/**
 获取前一个对象,找不到为nil
 */
- (id)syz_preObjectForObject:(nullable id)obj;
/**
 获取后一个对象索引,找不到为NSNotFound
 */
- (NSUInteger)syz_nextIndexForObject:(nullable id)obj;
/**
 获取后一个对象,找不到为nil
 */
- (id)syz_nextObjectForObject:(nullable id)obj;

#pragma mark - 转义
/**
 转义字符
 */
- (id)syz_replacingPercentEscapes;
@end

NS_ASSUME_NONNULL_END
