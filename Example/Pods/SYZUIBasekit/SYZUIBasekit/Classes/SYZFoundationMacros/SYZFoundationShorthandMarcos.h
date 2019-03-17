//
//  SYZFoundationShorthandMarcos.h
//  SYZFoundation
//
//  Created by sundasheng1985 on 10/28/2018.
//  Copyright (c) 2018 sundasheng1985. All rights reserved.
//

#ifndef SYZFoundationShorthandMarcos_h
#define SYZFoundationShorthandMarcos_h
#import <Foundation/Foundation.h>

/** 判断代理能不能执行 */
static inline BOOL SYZIsRespondsToSelector(id<NSObject> delegate, SEL sel) {
    return (delegate && [delegate respondsToSelector:sel]);
}

/** 判断某个类里面时候包含此协议 */
static inline BOOL SYZIsConformsToProtocol(id object, Protocol *protocol) {
    return [[object class] conformsToProtocol:protocol];
}


#endif /* SYZFoundationShorthandMarcos_h */
