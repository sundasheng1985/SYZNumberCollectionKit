//
//  NSSet+SYZFoundationAdd.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/12/1.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>
#import <SYZUIBasekit/NSArray+SYZArrayAdd.h>

extern BOOL SYZIsEmptySet(NSSet *set);
extern BOOL SYZIsNotEmptySet(NSSet *set);

@interface NSSet (SYZFoundationAdd)
/** 转组 */
- (NSArray *)syz_toArray;
/** 转可变数组 */
- (NSMutableArray *)syz_toMutableArray;
/** 删除对象 */
- (NSSet *)syz_removeObject:(id)obj;
@end
