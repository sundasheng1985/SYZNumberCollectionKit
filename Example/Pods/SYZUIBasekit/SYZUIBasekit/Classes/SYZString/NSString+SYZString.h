//
//  NSString+SYZString.h
//  Pods
//
//  Created by LeeRay on 2018/10/29.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <SYZUIBasekit/NSScanner+SYZFoundationAdd.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>

NS_ASSUME_NONNULL_BEGIN
/** 随机生成唯一id */
extern NSString * const SYZGeneralUUID(void);

/** 是否是空字符串 */
extern BOOL const SYZIsEmptyString(NSString *str);

/** 不是空字符串 */
extern BOOL const SYZIsNotEmptyString(NSString *str);

/**
 *  生成UUID
 *  @discussion 格式如下:
 *          2B064C33-149B-43A6-A506-33066B49AED2
 F017D24F-5CF2-4C17-B71C-CCA5FA1CA87D
 *  @return UUID
 */
extern NSString * const _Nonnull SYZGeneralUUIDString(void);

/** 剔除空字符串 */
extern NSString * _Nonnull SYZNoNilString(id str);

/** 点 . */
extern NSString * _Nonnull SYZDotString(void);

/** 逗号 , */
extern NSString * _Nonnull SYZCommaString(void);

/** 换行符 \n */
extern NSString * _Nonnull lineBreakString(void);

/** 将数字转成字符串 */
extern NSString * _Nonnull NSStringFromInt(int value);
extern NSString * _Nonnull NSStringFromNSInteger(NSInteger value);
extern NSString * _Nonnull NSStringFromNSUInteger(NSUInteger value);
extern NSString * _Nonnull NSStringFromunsignedLongLong(unsigned long long value);
extern NSString * _Nonnull NSStringFromCGFloat(CGFloat value);

/** 将对象的内存地址转成字符串 */
extern NSString * _Nonnull NSStringFromPointer(id x);

/** 判断两个字符串是否相等 */
extern BOOL SYZIsEqualToString(NSString * aStr , NSString * bStr);

@interface NSString (SYZString)

/** 空字符串 @"" */
+ (NSString *)emptyString;

/** 点 . */
+ (NSString *)dotString;

/** 逗号 , */
+ (NSString *)commaString;

/** 换行符 \n */
+ (NSString *)lineBreakString;

#pragma mark - 截取字符串
/** 去除aRange对应的string */
- (NSString *)syz_subStringWithoutRange:(NSRange)aRange;

/** 删除第一个字符 */
- (NSString *)syz_removeFirstCharacter;

/** 删除字符串的最前面几个字符 */
- (NSString *)syz_removeFirstCharacterWithCount:(NSUInteger)aCount;

/** 从前往后 删除 最先匹配的aString */
- (NSString *)syz_removeStringFromHeader:(NSString *)aString;

/**  删除最后一个字符 */
- (NSString *)syz_removeLastCharacter;

/** 删除字符串的最后aCount个字符 */
- (NSString *)syz_removeLastCharacterWithCount:(NSUInteger)aCount;

/** 从后往前 删除 最先匹配的aString */
- (NSString *)syz_removeStringFromEnd:(NSString *)aString;

/** 删除已出现的所有aString */
- (NSString *)syz_removeAllStrings:(NSString *)aString;

/** 删除头部和尾部多余的空白字符 */
- (NSString *)syz_removeFreeWhiteSpace;

/** 不区分大小写，比较两个字符串*/
- (BOOL)syz_isEqualToIgnoreCaseString:(NSString*)anotherString;

/** 隐藏手机号，只显示开头3位和最后3位*/
- (NSString*)syz_beSecret;

/*!
 *  删掉行首和行尾换行符"\n"
 *  如： "\na\nb\n" ==> "a\nb"
 */
- (NSString *)syz_trimNewLine;

/*!
 *  删除所有的换行符"\n"
 *  如： "\na\nb\n" ==> "ab"
 */
- (NSString *)syz_trimNewLines;

/**
 *  删除行首和行尾的换行符和空格
 *  如："\n a \n b \n" ==> "a \n b"
 */
- (NSString *)syz_trimNewLineAndWhiteSpace;

/**
 *  删除所有的换行符和空格符
 *  如："\n a \n b \n" ==> "ab"
 */
- (NSString *)syz_trimNewLinesAndWhiteSpaces;

/**
 是否是换行符和空格符组成
 */
- (BOOL)syz_isNewLinesAndWhiteSpaces;

/**
 反转字符串 "abc" ==> "cba"
 */
- (NSString *)syz_reverseString;

/**
 全长度  {0,self.length}
 */
- (NSRange)syz_allRange;

/**  range是否越界 */
- (BOOL)syz_isValidRange:(NSRange)range;

/** index 是否越界 */
- (BOOL)syz_isValidIndex:(NSUInteger)index;

/** 取对应索引的字符 */
- (NSString *)syz_stringAtIndex:(NSUInteger)index;
- (unichar)syz_characterAtIndex:(NSUInteger)index;

/**  第一个字符 */
- (NSString *)syz_firstString;
- (unichar)syz_firstCharactor;

/** 最后一个字符 */
- (NSString *)syz_lastString;
- (unichar )syz_lastCharactor;

/** 让第一个字符 大写 */
- (NSString *)syz_upperFirstChar;

/**  让第一个字符 小写 */
- (NSString *)syz_lowerFirstChar;

#pragma mark - 判断类型

/** 128位md5加密 */
- (NSString *)syz_128md5;

/** 32位md5加密 */
- (NSString *)syz_32md5;

/** 以下方法均为将字符串转为对应类型的Number类型 */
- (NSNumber *)syz_toDoubleNumber;
- (NSNumber *)syz_toFloatNumber;
- (NSNumber *)syz_toIntegerNumber;
- (NSNumber *)syz_toLongNumber;
- (NSNumber *)syz_toLongLongNumber;

/** 转成URL */
- (NSURL *)syz_toURL;

/**  转成本地URL */
- (NSURL *)syz_toFileURL;

/**  转成拼音 */
@property (nonatomic,readonly,copy) NSString * syz_toPinyin;

- (NSString *)syz_toString;
- (NSNumber *)syz_toNumber;

- (BOOL)syz_startsWith:(NSString*)prefix;
- (BOOL)syz_endsWith:(NSString*)suffix;

/**
 从头搜索字符串
 @example "4&12345&234"
 如果searchedString为 "&"  则 range = {1,1}
 如果searchedString为 "34" 则 range = {4,2}
 */
- (NSRange)syz_rangeOfStringFromHeader:(NSString *)searchedString;

/**
 从尾部搜索字符串
 @example "4&12345&234"
 如果searchedString为 "&" 则range = {6,1}
 如果searchedString为 "34" 则 range = {9,2}
 */
- (NSRange)syz_rangeOfStringFromEnder:(NSString *)searchedString;

#pragma mark - 容错方法
/**
 *  附加字符串
 *  如：
 *     正常情况
 *          [@"aa" syz_appendString:@"bb"] ==> "aabb"
 *
 *     异常情况
 *          [@"aa" syz_appendString:nil] ==> "aa" ps:此处的nil,<null>,或者""都是返回原字符串
 */
- (NSString *)syz_appendString:(NSString *)string;

/** 拼接成 完整的URL路径 */
- (NSString *)syz_stringByAppendingURLPathComponent:(NSString *)aString;

/** 是否包含string */
- (BOOL)syz_containsSubstring:(NSString *)string;

#pragma mark - 正则判断方法
/** 是否是合法的URL */
- (BOOL)syz_isValidURL;

/** 是否是合法的邮件 */
- (BOOL)syz_isValidEmail;

#pragma mark - 编码
- (NSString *)syz_urlEncodedString;
- (NSString *)syz_urlDecodedString;

#pragma mark - Data与String互转
- (nullable NSData *)syz_dataUsingUTF8Encoding;
+ (instancetype)syz_stringWithUTF8Data:(NSData *)data;

#pragma mark - 路径相关
/** 不带类型的文件名字   aaa */
- (NSString *)syz_fileNameWithoutType;

/** 文件的完整名字    aaa.zip */
- (NSString *)syz_fileFullName;

/**  文件的类型 zip */
- (NSString *)syz_fileType;

/**  文件类型   .zip */
- (NSString *)syz_fileFullType;

#pragma mark - 文件大小相关

/** 返回格式: 12.00GB 等 */
+ (NSString *)syz_stringWithFileSize:(unsigned long long)fileSize;

/** 返回格式: 12.00G 等 */
+ (NSString *)syz_stringWithSimpleFileSize:(unsigned long long)fileSize;
/**
 返回格式: 12.00GB 等
 */
- (NSString *)syz_toFileSize;
/**
 返回格式: 12.00G 等
 */
- (NSString *)syz_toSimpleFileSize;
/**
 isSimple == YES  返回格式: 12.00G 等
 isSimple == NO  返回格式: 12.00GB 等
 */
- (NSString *)syz_toFileSize:(BOOL)isSimple;

/**
 移除文件类型后缀
 aaa.zip ==> aaa
 */
- (NSString *)syz_removePathExtension;

/**
 拼接成完整的文件名
 aaa  jpg ==> aaa.jpg
 aaa  .jpg ==> aaa.jpg
 aaa. jpg ==> aaa.jpg
 */
- (NSString *)syz_appendingPathExtension:(NSString *)pathExtension;

#pragma mark - 时间相关
//00:00:00
+ (NSString *)syz_stringHHmmssWithTime:(int)time;
//00:00
+ (NSString *)syz_stringmmssWithTime:(int)time;

/** 将 01:01:20或者 01:20等格式的时间转成以秒为单位的时间 */
- (NSUInteger)syz_timeStringToSeconds;

#pragma mark - HTTP相关
/** 是否以 http/https开头 */
- (BOOL)syz_hasPrefixHTTP;

/** 是否以 https开头 */
- (BOOL)syz_hasPrefixHTTPS;

@end
NS_ASSUME_NONNULL_END

