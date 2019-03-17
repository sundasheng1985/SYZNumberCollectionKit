//
//  NSJSONSerialization+SYZUIBaseKitAdd.h
//  Pods
//
//  Created by LeeRay on 2018/10/29.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSString+SYZString.h>

@interface NSJSONSerialization (SYZUIBaseKitAdd)

/** 转任意类型 */
+ (id)syz_JSONObjectWithString:(NSString *)string
                         error:(NSError **)error;

/** 转字符串 */
+ (NSString *)syz_stringWithJSONObject:(id)obj
                                 error:(NSError **)error;

/** 转字典 */
+ (NSDictionary *)syz_dictionaryWithString:(NSString *)string error:(NSError **)error;

/** 转数组 */
+ (NSArray *)syz_arrayWithString:(NSString *)string error:(NSError **)error;
@end
