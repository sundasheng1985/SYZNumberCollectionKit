//
//  NSHTTPCookieStorage+SYZFoundationAdd.m
//  Pods-SYZUIBasekit_Example
//
//  Created by sundasheng1985 on 10/28/2018.
//  Copyright (c) 2018 sundasheng1985. All rights reserved.
//

#import "NSHTTPCookieStorage+SYZFoundationAdd.h"

@implementation NSHTTPCookieStorage (SYZFoundationAdd)
- (void)syz_removeCookiesForDomain:(NSString *)domain {
    if (SYZIsEmptyString(domain)) {
        return;
    }
    [self syz_removeCookiesForDomains:@[domain]];
}

- (void)syz_removeCookiesForDomains:(NSArray*)domains{
    if (SYZIsEmptyArray(domains)) {
        return;
    }
    for (NSHTTPCookie* cookie in self.cookies) {
        NSString* _domain = [cookie domain];
        for (NSString* domain in domains) {
            if ([_domain rangeOfString:domain options:NSCaseInsensitiveSearch].location != NSNotFound) {
                [self deleteCookie:cookie];
                break;
            }
        }
    }
}
@end
