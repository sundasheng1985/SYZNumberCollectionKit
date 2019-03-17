//
//  SYZNumberCollectorTypeBuilder.m
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/16/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZNumberCollectorTypeBuilder.h"
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface SYZNumberCollectorTypeBuilder ()
@property (nonatomic,strong) NSMutableArray* paths;
@end

@implementation SYZNumberCollectorTypeBuilder

- (SYZNumberCollectorTypeBuilder*)addChildPath:(NSString*)path {
    if (SYZIsNotEmptyString(path)) {
        [self.paths addObject:path];
    }
    return self;
}

- (NSString *)build {
    return [@"/" syz_appendString:[self.paths componentsJoinedByString:@"/"]];
}

- (NSMutableArray *)paths {
    if (_paths == nil) {
        _paths = [NSMutableArray new];
        [_paths addObject:@"root"];
    }
    return _paths;
}

@end
