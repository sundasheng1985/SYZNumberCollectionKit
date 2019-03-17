//
//  SYZTimerProxy.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/10/28.
//

#import <Foundation/Foundation.h>

@interface SYZTimerProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)aTarget;
- (instancetype)initWithTarget:(id)aTarget;
@end
