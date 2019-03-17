//
//  SYZNumberColLeaf.m
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZNumberColLeaf.h"
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface SYZNumberColLeaf ()
/** 数量变化时，需要通知的对象*/
@property (nonatomic,strong) NSHashTable* observers;
/** 子节点*/
@property (nonatomic,strong) NSMutableArray* childLeafs;

@end

@implementation SYZNumberColLeaf

+ (instancetype)numberColLeafWithName:(NSString*)type {
    SYZNumberColLeaf* leaf = [SYZNumberColLeaf new];
    if (![type syz_startsWith:@"/"]) {
        type = [@"/" stringByAppendingString:type];
    }
    leaf.leafName = type;
    return leaf;
}

- (void)setLeafName:(NSString *)leafName {
    _leafName = leafName.copy;
    _oriName = [leafName syz_removeFirstCharacter];
}

#pragma mark - Public
- (void)addObserver:(id<SYZNumberCollectionerDelegate>)observer {
    if (![self.observers containsObject:observer]) {
        [self.observers addObject:observer];
        [self _notifyObserver:observer];
    }
}

- (void)removeObserver:(id<SYZNumberCollectionerDelegate>)observer {
    if ([self.observers containsObject:observer]) {
        [self.observers removeObject:observer];
    }
}

/** 添加子节点*/
- (void)addChildLeaf:(SYZNumberColLeaf*)child {
    if ([self _checkIsValidChild:child] && ![self _checkExistChild:child]) {
        child.parentLeaf = self;
        [self.childLeafs addObject:child];
        [self childLeafNumDidChange];
    }
}

/** 移除子节点*/
- (void)removeChildLeaf:(SYZNumberColLeaf*)child {
    if ([self _checkIsValidChild:child] && [self _checkExistChild:child]) {
        [self.childLeafs removeObject:child];
        [self childLeafNumDidChange];
    }
}

/** 从父节点移除*/
- (void)removeFromParentLeaf {
    if (self.parentLeaf) {
        [self.parentLeaf removeChildLeaf:self];
    }
}

/** 将数量设置为0*/
- (void)clean {
    self.currentNum = 0;
}

/** 获取最底层的leafs*/
- (NSArray<SYZNumberColLeaf*>*)findAllBottomLeafs {
    NSMutableArray* bottomLeafs = [NSMutableArray new];
    NSArray* childLeafs = self.childLeafs.copy;
    for (SYZNumberColLeaf* childLeaf in childLeafs) {
        NSArray* childBottomLeafs = [childLeaf findAllBottomLeafs];
        //如果有子节点，添加，没有，那么自己就是最后节点了
        if (childBottomLeafs.count > 0) {
            [bottomLeafs addObjectsFromArray:childBottomLeafs];
        } else {
            [bottomLeafs addObject:childLeaf];
        }
    }
    return bottomLeafs;
}

/** 查找子节点*/
- (SYZNumberColLeaf*)findLeafForName:(NSString*)name {
    NSArray* leafs = self.childLeafs.copy;
    for (SYZNumberColLeaf* leaf in leafs) {
        if ([leaf.oriName isEqualToString:name]) {
            return leaf;
        }
    }
    return nil;
}

/** 查找子节点，如果没有，会创建*/
- (SYZNumberColLeaf*)findNotNullLeafForName:(NSString *)name {
    SYZNumberColLeaf* leaf = [self findLeafForName:name];
    if (leaf == nil) {
        leaf = [SYZNumberColLeaf numberColLeafWithName:name];
        [self addChildLeaf:leaf];
    }
    return leaf;
}

/** 清楚子节点的数据*/
- (void)clearChildsData {
    NSArray<SYZNumberColLeaf*>* childs = [self.childLeafs copy];
    for (SYZNumberColLeaf* child in childs) {
        [child updateNumberNotNotifyParent:0];
        [child clearChildsData];
    }
}

/** 消费数量*/
- (void)consumeNumber:(long)num {
    [self updateNumber:self.currentNum - num];
}

/** 添加数量*/
- (void)addNumber:(long)num {
    [self updateNumber:self.currentNum + num];
}

/** 更新数量*/
- (void)updateNumber:(long)num {
    [self updateNumberNotNotifyParent:num];
    //通知父节点
    [self.parentLeaf childLeafNumDidChange];
}

/** 更新数量，但不通知父节点*/
- (void)updateNumberNotNotifyParent:(long)num {
    num = MAX(num, 0);
    self.currentNum = num;
        //通知所有observers
    [self _notifyAllObservers];
}

/** 子节点添加、移除或者数量变化时调用*/
- (void)childLeafNumDidChange {
    //获取所有节点
    NSArray* allLeafs = self.childLeafs.copy;
    long count = 0;
    for (SYZNumberColLeaf* leaf in allLeafs) {
        count += leaf.currentNum;
    }
    [self updateNumber:count];
}

- (NSString *)fullLeafName {
    if (self.parentLeaf) {
        return [[self.parentLeaf fullLeafName] stringByAppendingString:self.leafName];
    }
    return self.leafName;
}

#pragma mark - Private
- (BOOL)_checkIsValidChild:(SYZNumberColLeaf*)child {
    return SYZIsNotEmpty(child) &&
    [child isKindOfClass:SYZNumberColLeaf.class] &&
    SYZIsNotEmptyString(child.leafName);
}

- (BOOL)_checkExistChild:(SYZNumberColLeaf*)child {
    NSArray* childs = [self.childLeafs copy];
    for (SYZNumberColLeaf* aChild in childs) {
        if ([aChild.leafName isEqualToString:child.leafName]) {
            return YES;
        }
    }
    return NO;
}

- (void)_notifyAllObservers {
    if (self.observers.count == 0) return;
    NSArray* allObservers = self.observers.copy;
    NSString* type = self.fullLeafName;
    long num = self.currentNum;
    for (id<SYZNumberCollectionerDelegate> aObserver in allObservers) {
        [aObserver numberCollectorType:type name:self.oriName didUpdateToNum:num];
    }
}

//通知单个observer
- (void)_notifyObserver:(id<SYZNumberCollectionerDelegate>)observer {
    [observer numberCollectorType:self.fullLeafName name:self.oriName didUpdateToNum:self.currentNum];
}

#pragma mark - Lazy
- (NSHashTable *)observers {
    if (_observers == nil) {
        _observers = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return _observers;
}

SYZLazyCreateMutableArray(childLeafs)
@end
