//
//  NSDictionary+SYZDictionary.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>

/**  是否是空字典 */
extern BOOL SYZIsEmptyDictionary(NSDictionary *dict);

/**  不是空字典 */
extern BOOL SYZIsNotEmptyDictionary(NSDictionary *dict);

extern NSDictionary * const _Nonnull SYZNoNilDictionary(NSDictionary * dict);
@interface NSDictionary (SYZDictionary)

/** 从main bundle中读取plist */
+ (NSDictionary *)syz_dictionaryWithFileName:(NSString *)fileName;
/** 是否包含key */
- (BOOL)syz_containsKey:(id<NSCopying>)key;

/** 转成curl需要的格式 */
- (NSString *)syz_tocURLFormat;

/** 将两个字典合并，aDict将覆盖self中已有的值 */
- (NSDictionary *)syz_appendingDictionary:(NSDictionary *)aDict;
/** 添加一个键值对 */
- (NSDictionary *)syz_appendingKey:(NSObject<NSCopying> *)aKey value:(id)aValue;

/** 转义字符 */
- (id)syz_replacingPercentEscapes;

/** 转成jsonstring
 {"key": 123,"key2": 111} ===>
 */
- (NSString*)syz_toJsonString;

/** 转成可变字典，如果本身是NSDictionary，则执行mutableCopy方法，
 如果是NSMutableDictionary，则直接返回*/
- (NSMutableDictionary*)syz_toMutable;

/** 转成json对象 */
- (id)syz_toJsonObject;
@end

@interface NSArray (CURLAddition)
- (NSString *)syz_tocURLFormat;
/** 转成json对象 */
- (id)syz_toJsonObject;
@end
@interface NSString (CURLAddition)
- (NSString *)syz_tocURLFormat;

/** 转成json对象 */
- (id)syz_toJsonObject;
@end
@interface NSNumber (CURLAddition)
- (NSString *)syz_tocURLFormat;
/** 转成json对象 */
- (id)syz_toJsonObject;
@end
@interface NSObject (CURLAddition)
- (NSString *)syz_tocURLFormat;;
/** 转成json对象 */
- (id)syz_toJsonObject;
@end
