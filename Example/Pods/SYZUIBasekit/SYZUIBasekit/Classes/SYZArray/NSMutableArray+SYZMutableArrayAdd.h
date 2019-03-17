//
//  NSMutableArray+syzMutableArrayAdd.h
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (SYZMutableArrayAdd)


/** 添加一个元素，如果传入的obj为空，则忽略 */
- (NSMutableArray *)syz_addObject:(_Nullable id)obj;

/**  移除第一个元素 */
- (NSMutableArray *)syz_removeFirstObject;

/** 移除最后一个元素 */
- (NSMutableArray *)syz_removeLastObject;

/** 在数组的最后添加元素 */
- (NSMutableArray *)syz_insertObjectAtLast:(id)obj;
@end

NS_ASSUME_NONNULL_END
