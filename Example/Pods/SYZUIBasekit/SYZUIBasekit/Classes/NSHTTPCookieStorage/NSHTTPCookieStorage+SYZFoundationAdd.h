//
//  NSHTTPCookieStorage+SYZFoundationAdd.h
//  Pods-SYZUIBasekit_Example
//
//  Created by sundasheng1985 on 10/28/2018.
//  Copyright (c) 2018 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSString+SYZString.h>
#import <SYZUIBasekit/NSArray+SYZArrayAdd.h>

@interface NSHTTPCookieStorage (SYZFoundationAdd)
- (void)syz_removeCookiesForDomain:(NSString *)domain;

- (void)syz_removeCookiesForDomains:(NSArray*)domains;
@end
