//
//  SYZWeakObject.m
//  Pods
//
//  Created by LeeRay on 2018/10/28.
//

#import "SYZWeakObject.h"


@implementation SYZWeakObject
- (instancetype)initWithWeakObject:(id)weakObj {
    if (self = [super init]) {
        self.weakObj = weakObj;
    }    
    return self;
}
@end
