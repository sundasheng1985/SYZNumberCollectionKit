//
//  NSData+SYZFoundationAdd.h
//  Pods
//
//  Created by sundasheng1985 on 10/28/2018.
//  Copyright (c) 2018 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SYZFoundationAdd)
/** 字符串 转 data */
+ (NSData *)syz_dataWithBytesString:(NSString *)bytesString;

/** data 转 字符串 */
- (NSString *)syz_bytesString;
@end
