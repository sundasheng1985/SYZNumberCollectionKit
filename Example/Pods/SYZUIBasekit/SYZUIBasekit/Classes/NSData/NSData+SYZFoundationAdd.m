//
//  NSData+SYZFoundationAdd.m
//  Pods
//
//  Created by sundasheng1985 on 10/28/2018.
//  Copyright (c) 2018 sundasheng1985. All rights reserved.
//

#import "NSData+SYZFoundationAdd.h"
#import <SYZUIBasekit/NSString+SYZString.h>
@implementation NSData (SYZFoundationAdd)

+ (NSData *)syz_dataWithBytesString:(NSString *)bytesString {
    if (!bytesString || !bytesString.length) return NULL;
    const char *scanner=[bytesString cStringUsingEncoding:NSUTF8StringEncoding];
    char twoChars[3]={0,0,0};
    long bytesBlockSize = bytesString.length/2;
    long counter = bytesBlockSize;
    Byte *bytesBlock = malloc(bytesBlockSize);
    Byte *writer = bytesBlock;
    while (counter--) {
        twoChars[0]=*scanner++;
        twoChars[1]=*scanner++;
        *writer++ = strtol(twoChars, NULL, 16);
    }
    
    return[NSData dataWithBytesNoCopy:bytesBlock length:bytesBlockSize freeWhenDone:YES];
}

/**
 获取到字符串
 */
- (NSString *)syz_bytesString {
    return [[[[self description] syz_trimNewLinesAndWhiteSpaces] syz_removeFirstCharacter] syz_removeLastCharacter];
}

@end
