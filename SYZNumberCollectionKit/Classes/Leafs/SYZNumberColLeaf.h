//
//  SYZNumberColLeaf.h
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYZNumberCollectionerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYZNumberColLeaf : NSObject

+ (instancetype)numberColLeafWithName:(NSString*)type;

/** 节点名字
 如: /root
 */
@property (nonatomic,copy) NSString* leafName;
@property (nonatomic,copy) NSString* oriName;

/** 父节点*/
@property (nonatomic,weak) SYZNumberColLeaf* parentLeaf;

- (void)addObserver:(id<SYZNumberCollectionerDelegate>)observer;

- (void)removeObserver:(id<SYZNumberCollectionerDelegate>)observer;

/** 添加子节点*/
- (void)addChildLeaf:(SYZNumberColLeaf*)child;

/** 移除子节点*/
- (void)removeChildLeaf:(SYZNumberColLeaf*)child;

/** 查找子节点*/
- (SYZNumberColLeaf*)findLeafForName:(NSString*)name;
/** 查找子节点，如果没有，会创建*/
- (SYZNumberColLeaf*)findNotNullLeafForName:(NSString *)name;

/** 当前的数量*/
@property (nonatomic,assign) long currentNum;

/** 更新数量*/
- (void)updateNumber:(long)num;

/** 更新数量，但不通知父节点*/
- (void)updateNumberNotNotifyParent:(long)num;

/** 清楚子节点的数据*/
- (void)clearChildsData;

/** 消费数量*/
- (void)consumeNumber:(long)num;

/** 添加数量*/
- (void)addNumber:(long)num;

/** 从父节点移除*/
- (void)removeFromParentLeaf;

/** 将数量设置为0*/
- (void)clean;

/** 获取最底层的leafs*/
- (NSArray<SYZNumberColLeaf*>*)findAllBottomLeafs;

/** 完整的节点名称
/root
 /root/video
 /root/video/detail
 */
- (NSString*)fullLeafName;

/** 子节点数量变化时调用*/
- (void)childLeafNumDidChange;

@end

NS_ASSUME_NONNULL_END
