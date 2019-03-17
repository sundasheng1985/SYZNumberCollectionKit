//
//  SYZNumberCollector.m
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZNumberCollector.h"
#import "SYZNumberColLeaf.h"

/** 默认根节点的名称*/
NSString* NUMBER_COL_ROOT_LEAF_NAME = @"/root";
/** 用于保存的key*/
static NSString* SYZ_NUMBER_COLLECTOR_SAVE_KEY = @"syz_number_collector_save_key";

@interface SYZNumberCollector ()
//根节点
@property (nonatomic,strong) SYZNumberColLeaf* rootLeaf;

@property (nonatomic,strong) id<SYZNumberCollectorSaverDelegate> saver;
@end

@implementation SYZNumberCollector
SYZSingletonImplementation(SYZNumberCollector)

#pragma mark - Public
/** 更新数据管理中心*/
- (void)updateDataSaver:(id<SYZNumberCollectorSaverDelegate>)saver {
    //对saver进行验证
    _saver = saver;
}

/** 添加对type的监听*/
- (void)addObserver:(id<SYZNumberCollectionerDelegate>)observer forType:(NSString*)type {
    if ([self _checkIsValidObserver:observer type:type]) {
        [[self _findNonnullLeafForType:type] addObserver:observer];
    }
}

/** 移除对type的监听*/
- (void)removeObserver:(id<SYZNumberCollectionerDelegate>)observer forType:(NSString*)type {
    if ([self _checkIsValidObserver:observer type:type]) {
        [[self _findNonnullLeafForType:type] removeObserver:observer];
    }
}

/** 更新对应type的数量*/
- (void)updateNumber:(long)num forType:(NSString*)type {
    if ([self _checkTypeValid:type]) {
        [[self _findNonnullLeafForType:type] updateNumber:num];
    }
}

/** 移除类型
 如有/root 、/root/messagebox、/root/messagebox/message等节点
 ，现移除/root/messagbox/message节点，那么/root、/root/messagebox等数量都会发生变化
 */
- (void)removeType:(NSString*)type {
    if ([self _checkTypeValid:type]) {
         [[self _findLeafForType:type] removeFromParentLeaf];
    }
}

/**
 对应type进行消费的数量
 如 /root/messagebox/message 原有数量为 10，consumeNum为6，那么剩余数量为 4
 /root 、/root/messagebox、/root/messagebox/message 监听者都会收到数量改变的通知
 */
- (void)consumeNumber:(long)num forType:(NSString*)type {
    if ([self _checkTypeValid:type]) {
        [[self _findLeafForType:type] consumeNumber:num];
    }
}

/**
 对应type进行数据进行添加
 如 /root/messagebox/message 原有数量为 10，addNum为6，那么剩余数量为 16
 /root 、/root/messagebox、/root/messagebox/message 监听者都会收到数量改变的通知
 */
- (void)addNumber:(long)num forType:(NSString*)type {
    if ([self _checkTypeValid:type]) {
        [[self _findLeafForType:type] addNumber:num];
    }
}

/** 获取对应type的数量*/
- (long)fetchNumberForType:(NSString*)type {
    return [[self _findLeafForType:type] currentNum];
}

- (void)drop {
    [self dropType:NUMBER_COL_ROOT_LEAF_NAME];
    _rootLeaf = nil;
    //清空缓存
    [self.saver numberCollectorCleanDataWithType:SYZ_NUMBER_COLLECTOR_SAVE_KEY];
}

/** 放弃type对应的数据*/
- (void)dropType:(NSString*)type {
    SYZNumberColLeaf* parentLeaf = [self _findLeafForType:type];
    //获取最底层leaf
    NSArray<SYZNumberColLeaf*>* bottomLeafs = [parentLeaf findAllBottomLeafs];
    for (SYZNumberColLeaf* aLeaf in bottomLeafs) {
            //因为是最底层节点，所有获取到数量为0，那么以上都变成了0
            //待优化
        [aLeaf childLeafNumDidChange];
    }
    [parentLeaf removeFromParentLeaf];
}

/** 清楚某个type下面的子节点数据，但是节点依然存在*/
- (void)clearNumberForTypeChilds:(NSString*)type {
    SYZNumberColLeaf* parentLeaf = [self _findLeafForType:type];
    [parentLeaf clearChildsData];
    //通知更新
    [parentLeaf childLeafNumDidChange];
}

/** 保存当前存放的所有数据*/
- (void)saveForKey:(NSString *)key {
    //从root节点遍历，获取没有type对应的num
    NSMutableDictionary* params = [NSMutableDictionary new];
    //获取最底层的节点，然后保存数据即可
    NSArray<SYZNumberColLeaf*>* bottomLeafs = [self.rootLeaf findAllBottomLeafs];
    for (SYZNumberColLeaf* aLeaf in bottomLeafs) {
        NSString* type = [aLeaf fullLeafName];
        long num = aLeaf.currentNum;
        if (type.length > 0 && num > 0) {
            params[type] = @(num);
        }
    }
    [self.saver numberCollectorSaveData:params forKey:key withType:SYZ_NUMBER_COLLECTOR_SAVE_KEY];
}

/** 恢复上次保存的数据，key一般可以用userId等*/
- (void)resumeForKey:(NSString*)key {
    NSDictionary<NSString*,NSNumber*>* params = [self.saver numberCollectoFetchDataForKey:key withType:SYZ_NUMBER_COLLECTOR_SAVE_KEY];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        long num = [obj integerValue];
        [[self _findNonnullLeafForType:key] updateNumber:num];
    }];
}

/** 清除缓存*/
- (void)clearCacheForKey:(NSString*)key {
    [self.saver numberCollectorCleanDataForKey:key withType:SYZ_NUMBER_COLLECTOR_SAVE_KEY];
}

/** 开启一个事务，即将对type的子节点进行批量更新*/
- (SYZNumberCollectionTransaction*)beginTransactionForType:(NSString*)type {
    return [[SYZNumberCollectionTransaction alloc] initWithParentLeaf:[self _findNonnullLeafForType:type]];
}

/** 获取到最后一个节点的名称
 如: /root/messagebox/message
 返回值为 message
 */
- (NSString*)lastLeafNameForType:(NSString*)type {
    return [[self leafNamesForType:type] lastObject];
}

/** 顺序返回type对应每个节点的名称
 如： /root/messagebox/message
 返回值为： root、messagebox、message
 */
- (NSArray*)leafNamesForType:(NSString*)type {
    if ([self _checkTypeValid:type]) {
        NSArray* leafNames = [type componentsSeparatedByString:@"/"];
        //去掉root
        leafNames = [leafNames syz_removeObjectAtIndex:0];
        return leafNames;
    }
    return @[];
}

#pragma mark - Private
- (BOOL)_checkTypeValid:(NSString*)type {
    NSAssert(SYZIsNotEmptyString(type) && [type syz_startsWith:self.rootLeaf.leafName],@"type 命名不符合规范，应该以/root开头");
    return YES;
}

/** 获取type除root外的第一个节点*/
- (NSEnumerator<NSString *> *)_enumeratorForType:(NSString *)type {
    NSArray* leafNames = [type componentsSeparatedByString:@"/"];
        //去掉root
    leafNames = [leafNames syz_removeObjectAtIndex:0];
    leafNames = [leafNames syz_removeObjectAtIndex:0];
    NSEnumerator<NSString*>* enumerator = [leafNames objectEnumerator];
    return enumerator;
}

/**
 查找type对应的leaf，如果不存在，返回nil
 */
- (SYZNumberColLeaf*)_findLeafForType:(NSString*)type {
        //对type进行验证
    if ([type isEqualToString:NUMBER_COL_ROOT_LEAF_NAME]) return self.rootLeaf;
        //拆分type，获取/生成节点
    NSEnumerator<NSString *> * enumerator = [self _enumeratorForType:type];
    NSString* nodeName = enumerator.nextObject;
    SYZNumberColLeaf* nextLeaf = self.rootLeaf;
    do {
        nextLeaf = [nextLeaf findLeafForName:nodeName];
        if (nextLeaf == nil) {
            return nil;
        }
        nodeName = enumerator.nextObject;
    } while (nodeName != nil);
        //返回
    return nextLeaf;
}

/**
 获取type对应的leaf，如果有不存在的leaf，会进行创建
 */
- (SYZNumberColLeaf*)_findNonnullLeafForType:(NSString*)type {
        //对type进行验证
    if ([type isEqualToString:NUMBER_COL_ROOT_LEAF_NAME]) return self.rootLeaf;
    NSEnumerator<NSString*>* enumerator = [self _enumeratorForType:type];
    NSString* nodeName = enumerator.nextObject;
    SYZNumberColLeaf* nextLeaf = self.rootLeaf;
    do {
        nextLeaf = [nextLeaf findNotNullLeafForName:nodeName];
        nodeName = enumerator.nextObject;
    } while (nodeName != nil);
        //返回
    return nextLeaf;
}

- (BOOL)_checkIsValidObserver:(id<SYZNumberCollectionerDelegate>)observer type:(NSString*)type {
    return observer != nil && [self _checkTypeValid:type];
}

#pragma mark - Lazy
- (SYZNumberColLeaf *)rootLeaf {
    if (_rootLeaf == nil) {
        _rootLeaf = [SYZNumberColLeaf numberColLeafWithName:@"root"];
    }
    return _rootLeaf;
}

@end
