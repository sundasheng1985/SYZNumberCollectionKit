//
//  SYZNumberCollectionerDelegate.h
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SYZNumberCollectionerDelegate <NSObject>

/** 数量更新，进行通知
 type格式为: /root/video
 name 格式为: video
 */
- (void)numberCollectorType:(NSString*)type name:(NSString*)name didUpdateToNum:(long)num;

@end

NS_ASSUME_NONNULL_END
