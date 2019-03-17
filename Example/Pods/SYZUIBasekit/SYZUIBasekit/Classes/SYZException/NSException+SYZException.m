//
//  NSException+SYZException.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/10/28.
//

#import "NSException+SYZException.h"

#define kNSExceptionUserInfo [NSThread callStackSymbols] == nil ? @{} : @{@"callStack":[NSThread callStackSymbols]}
@implementation NSException (SYZException)

+ (NSException *)unrecognizedSelectorExceptionWithInstance:(NSObject *)aInstance forMethod:(SEL)aSelector {
    NSString * reason = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %@",NSStringFromClass([aInstance class]),NSStringFromSelector(aSelector),aInstance ? : [aInstance class]];
    return [NSException exceptionWithName:@"NSInvalidArgumentException" reason:reason userInfo:kNSExceptionUserInfo];
}

+ (NSException *)didNotConforms:(Protocol *)protocol object:(id)object {
    NSString * reason = [NSString stringWithFormat:@"原因：%@没有实现%@或必要协议方法",[object class],NSStringFromProtocol(protocol)];
    return [NSException exceptionWithName:@"NSNotConformProtocolException" reason:reason userInfo:kNSExceptionUserInfo];
}
@end
