//
//  NSDictionary+SYZDictionary.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSDictionary+SYZDictionary.h"
#import <SYZUIBasekit/NSJSONSerialization+SYZUIBaseKitAdd.h>

@implementation NSDictionary (SYZDictionary)

BOOL SYZIsEmptyDictionary(NSDictionary *dict) {
    if (SYZIsEmpty(dict) || [dict syz_isNSDictionary] == NO) {
        return YES;
    }
    
    return dict.count <= 0;
}

/*!
 *  不是空字典
 */
BOOL SYZIsNotEmptyDictionary(NSDictionary *dict) {
    return !SYZIsEmptyDictionary(dict);
}

NSDictionary * const SYZNoNilDictionary(NSDictionary * dict) {
    if (SYZIsEmpty(dict)) {
        return @{};
    }
    
    return dict;
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

- (BOOL)syz_containsKey:(id<NSCopying>)key {
    return [self.allKeys containsObject:key];
}

- (NSString *)syz_tocURLFormat {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{"];
    // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"%@:%@,", [key syz_tocURLFormat], [obj syz_tocURLFormat]];
    }];
    
    [str appendString:@"}"];
    
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

+ (NSDictionary *)syz_dictionaryWithFileName:(NSString *)fileName {
    NSURL * filePath = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"plist"];
    return [NSDictionary dictionaryWithContentsOfURL:filePath];
}

/**
 将两个字典合并，aDict将覆盖self中已有的值
 */
- (NSDictionary *)syz_appendingDictionary:(NSDictionary *)aDict {
    if (SYZIsEmptyDictionary(aDict)) {
        return self;
    }
    
    if (SYZIsEmptyDictionary(self)) {
        return aDict;
    }
    
    NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] initWithDictionary:self];
    [aDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        tempDict[key] = obj;
    }];
    return [tempDict copy];
}

/**
 添加一个键值对
 */
- (NSDictionary *)syz_appendingKey:(NSObject<NSCopying> *)aKey value:(id)aValue {
    if ([aKey conformsToProtocol:@protocol(NSCopying)]) {
        NSMutableDictionary * selfDictM = [self mutableCopy];
        selfDictM[aKey] = aValue;
        return [selfDictM copy];
    }
    
    return self;
}

/**
 转义字符
 */
- (id)syz_replacingPercentEscapes {
    NSMutableDictionary * selfM = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        selfM[key] = [obj syz_replacingPercentEscapes];
    }];
    return [selfM copy];
}

- (NSString *)syz_toJsonString {
    return [self syz_tocURLFormat];
}

/** 转成json对象 */
- (id)syz_toJsonObject {
    NSMutableDictionary* selfRet = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        selfRet[key] = [obj syz_toJsonObject];
    }];
    return selfRet;
}

/** 转成可变字典，如果本身是NSDictionary，则执行mutableCopy方法，
 如果是NSMutableDictionary，则直接返回*/
- (NSMutableDictionary*)syz_toMutable {
    return self.mutableCopy;
}


@end

@implementation NSArray (CURLAddition)

- (NSString *)syz_tocURLFormat {
    NSMutableString * stringM = [NSMutableString new];
    [stringM appendString:@"["];
    for (id obj in self) {
        [stringM appendFormat:@"%@,",[obj syz_tocURLFormat]];
    }
    // range of the last ','
    NSRange range = [stringM rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [stringM deleteCharactersInRange:range];
    }
    [stringM appendString:@"]"];
    return stringM;
}

/** 转成json对象 */
- (id)syz_toJsonObject {
    NSMutableArray* selfRet = [NSMutableArray new];
    for (id obj in self) {
        id jsonObj = [obj syz_toJsonObject];
        if (jsonObj) {
            [selfRet addObject:jsonObj];
        }
    }
    return selfRet;
}

@end

@implementation NSString (CURLAddition)

- (NSString *)syz_tocURLFormat {
    return [NSString stringWithFormat:@"\"%@\"",self];
}

- (id)syz_toJsonObject {
    id jsonRet = [NSJSONSerialization syz_JSONObjectWithString:self error:nil];
    return jsonRet == nil ? self : jsonRet;
}

@end

@implementation NSNumber (CURLAddition)

- (NSString *)syz_tocURLFormat {
    return self.stringValue;
}

- (id)syz_toJsonObject {
    return self.stringValue;
}

@end
@implementation NSObject (CURLAddition)

- (NSString *)syz_tocURLFormat {
    return @"\"\"";
}

- (id)syz_toJsonObject {
    return @"";
}

@end


