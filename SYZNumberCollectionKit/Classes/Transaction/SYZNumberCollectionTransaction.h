//
//  SYZNumberCollectionTransaction.h
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SYZNumberColLeaf;
@interface SYZNumberCollectionTransaction : NSObject

/** 传入parentLeaf，即将开始对该节点的子节点进行更新*/
- (instancetype)initWithParentLeaf:(SYZNumberColLeaf*)parentLeaf;

/** 更新type对应的数据*/
- (void)updateNumber:(long)num forType:(NSString*)type;

/** 添加type对应的数据*/
- (void)addNumber:(long)num forType:(NSString*)type;

/** 提交更新的数据
 1、更新的子节点的observer会收到回调通知
 2、对parentLeaf及其父节点进行数据更新回调
 3、该次事务结束
 */
- (void)commit;

/** 取消，那么更新的数据将会不存在*/
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
