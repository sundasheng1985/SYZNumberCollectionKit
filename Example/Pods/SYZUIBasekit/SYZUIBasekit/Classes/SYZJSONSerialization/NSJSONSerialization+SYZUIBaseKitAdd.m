//
//  NSJSONSerialization+SYZUIBaseKitAdd.m
//  Pods
//
//  Created by LeeRay on 2018/10/29.
//

#import "NSJSONSerialization+SYZUIBaseKitAdd.h"

@implementation NSJSONSerialization (SYZUIBaseKitAdd)
+ (id)syz_JSONObjectWithString:(NSString *)string error:(NSError **)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
}

+ (NSString *)syz_stringWithJSONObject:(id)obj error:(NSError **)error {
    return [NSString syz_stringWithUTF8Data:[self dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:error]];
}

+ (NSDictionary *)syz_dictionaryWithString:(NSString *)string error:(NSError **)error {
    id obj = [self syz_JSONObjectWithString:string error:error];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    return nil;
}
+ (NSArray *)syz_arrayWithString:(NSString *)string error:(NSError **)error {
    id obj = [self syz_JSONObjectWithString:string error:error];
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    return nil;
}

@end
