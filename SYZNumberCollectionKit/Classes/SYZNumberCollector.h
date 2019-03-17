//
//  SYZNumberCollector.h
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/SYZUIBasekit.h>
#import "SYZNumberCollectionerDelegate.h"
#import "SYZNumberCollectorSaverDelegate.h"
#import "SYZNumberCollectionTransaction.h"

/** 默认根节点的名称*/
extern NSString* NUMBER_COL_ROOT_LEAF_NAME;

NS_ASSUME_NONNULL_BEGIN
/**
 对数量进行收集和分发
 注： type 必须以/root开头
 格式为:SYZUIBasekit
 /root
 /root/video
 /root/messagebox
 /root/messagebox/message
 /root/messagebox/comment
 */
@interface SYZNumberCollector : NSObject
SYZSingletonInterface()

/** 更新数据管理中心，强引用*/
- (void)updateDataSaver:(id<SYZNumberCollectorSaverDelegate>)saver;

/** 添加对type的监听*/
- (void)addObserver:(id<SYZNumberCollectionerDelegate>)observer forType:(NSString*)type;

/** 移除对type的监听*/
- (void)removeObserver:(id<SYZNumberCollectionerDelegate>)observer forType:(NSString*)type;

/** 更新对应type的数量*/
- (void)updateNumber:(long)num forType:(NSString*)type;

/** 移除类型
 如有/root 、/root/messagebox、/root/messagebox/message等节点
 ，现移除/root/messagbox/message节点，那么/root、/root/messagebox等数量都会发生变化
 */
- (void)removeType:(NSString*)type;

/**
 对应type进行消费的数量
 如 /root/messagebox/message 原有数量为 10，consumeNum为6，那么剩余数量为 4
 /root 、/root/messagebox、/root/messagebox/message 监听者都会收到数量改变的通知
 */
- (void)consumeNumber:(long)num forType:(NSString*)type;

/**
 对应type进行数据进行添加
 如 /root/messagebox/message 原有数量为 10，addNum为6，那么剩余数量为 16
 /root 、/root/messagebox、/root/messagebox/message 监听者都会收到数量改变的通知
 */
- (void)addNumber:(long)num forType:(NSString*)type;

/** 获取对应type的数量*/
- (long)fetchNumberForType:(NSString*)type;

/** 释放所有数据*/
- (void)drop;

/** 放弃type对应的数据*/
- (void)dropType:(NSString*)type;

/** 清楚某个type下面的子节点数据，但是节点依然存在*/
- (void)clearNumberForTypeChilds:(NSString*)type;

/** 保存当前存放的所有数据*/
- (void)saveForKey:(NSString*)key;

/** 恢复上次保存的数据，key一般可以用userId等*/
- (void)resumeForKey:(NSString*)key;

/** 清除缓存*/
- (void)clearCacheForKey:(NSString*)key;

/**
 开启一个事务，即将对type的子节点进行批量更新
 */
- (SYZNumberCollectionTransaction*)beginTransactionForType:(NSString*)type;

/** 获取到最后一个节点的名称
 如: /root/messagebox/message
 返回值为 message
 */
- (NSString*)lastLeafNameForType:(NSString*)type;

/** 顺序返回type对应每个节点的名称
 如： /root/messagebox/message
 返回值为： root、messagebox、message
 */
- (NSArray*)leafNamesForType:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
