//
//  SYZNumberCollectionTransaction.m
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZNumberCollectionTransaction.h"
#import "SYZNumberCollector.h"
#import "SYZNumberColLeaf.h"

@interface SYZNumberCollectionTransaction ()
@property (nonatomic,strong) SYZNumberColLeaf* parentLeaf;
//缓存type对应的num
@property (nonatomic,strong) NSMutableDictionary<NSString*,NSNumber*>* typeNumCache;
//是否取消了
@property (nonatomic,assign) BOOL isCancelled;

@property (nonatomic,strong) SYZNumberCollector* collector;
@end

@implementation SYZNumberCollectionTransaction

- (instancetype)initWithParentLeaf:(SYZNumberColLeaf*)parentLeaf {
    if (self = [super init]) {
        self->_parentLeaf = parentLeaf;
        _collector = [SYZNumberCollector sharedInstance];
    }
    return self;
}

/** 更新type对应的数据*/
- (void)updateNumber:(long)num forType:(NSString*)type {
    if (_isCancelled) return;
    self.typeNumCache[[self _findLeafNameForType:type]] = @(num);
}

/** 添加type对应的数据*/
- (void)addNumber:(long)num forType:(NSString*)type {
    if (_isCancelled) return;
    NSString* leafName = [self _findLeafNameForType:type];
    long oriNum = 0;
    if ([self.typeNumCache syz_containsKey:leafName]) {
        oriNum = [self.typeNumCache[leafName] integerValue];
    } else {
        oriNum = [self.parentLeaf findNotNullLeafForName:leafName].currentNum;
    }
    self.typeNumCache[leafName] = @(oriNum + num);
}

/** 提交更新的数据
 1、更新的子节点的observer会收到回调通知
 2、对parentLeaf及其父节点进行数据更新回调
 3、该次事务结束
 */
- (void)commit {
    if (_isCancelled) return;
    NSArray* types = self.typeNumCache.allKeys;
    for (NSString* aLeafName in types) {
        long num = [self.typeNumCache[aLeafName] integerValue];
        SYZNumberColLeaf* leaf = [self.parentLeaf findNotNullLeafForName:aLeafName];
        [leaf updateNumberNotNotifyParent:num];
    }
    [self.parentLeaf childLeafNumDidChange];
    [self cancel];
}

/** 取消，那么更新的数据将会不存在*/
- (void)cancel {
    _isCancelled = YES;
    _parentLeaf = nil;
    _typeNumCache = nil;
}

#pragma mark - Private
- (NSString*)_findLeafNameForType:(NSString*)type {
    NSArray* leafNames = [self.collector leafNamesForType:type];
    NSParameterAssert(leafNames.count >= 2);

    NSString* parentLeafName = leafNames[leafNames.count - 2];
    NSCAssert([parentLeafName isEqualToString:self.parentLeaf.oriName], @"");

    NSString* leafName = leafNames.lastObject;
    return leafName;
}

#pragma mark - Lazy
- (NSMutableDictionary *)typeNumCache {
    if (_typeNumCache == nil) {
        _typeNumCache = [NSMutableDictionary new];
    }
    return _typeNumCache;
}

@end
