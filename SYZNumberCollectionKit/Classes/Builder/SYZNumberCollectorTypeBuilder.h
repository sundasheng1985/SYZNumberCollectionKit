//
//  SYZNumberCollectorTypeBuilder.h
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYZNumberCollectorTypeBuilder : NSObject

- (SYZNumberCollectorTypeBuilder*)addChildPath:(NSString*)path;

/** 生成type*/
- (NSString*)build;

@end

NS_ASSUME_NONNULL_END
