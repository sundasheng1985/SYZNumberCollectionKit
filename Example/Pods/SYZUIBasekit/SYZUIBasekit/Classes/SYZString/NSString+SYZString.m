//
//  NSString+SYZString.m
//  Pods
//
//  Created by LeeRay on 2018/10/29.
//

#import "NSString+SYZString.h"
#import <CommonCrypto/CommonDigest.h>

#define kSYZNumberToString(x) @(x).stringValue;
@implementation NSString (SYZString)
/*!
 *  随机生成唯一id
 */
NSString * const SYZGeneralUUID(void)
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/*!
 *  是否是空字符串
 */
BOOL const SYZIsEmptyString(NSString *str) {
    return !SYZIsNotEmptyString(str);
}

/*!
 *  不是空字符串
 */
BOOL const SYZIsNotEmptyString(NSString *str) {
    return SYZIsNotEmpty(str) && [str isKindOfClass:[NSString class]] && str.length > 0;
}

NSString * SYZNoNilString(id str) {
    if (SYZIsEmpty(str)) {
        return [NSString emptyString];
    }
    
    return str;
}

/**
 *  点 .
 */
NSString * SYZDotString(void) {
    return [NSString dotString];
}
/**
 *  逗号 ,
 */
NSString * SYZCommaString(void) {
    return [NSString commaString];
}
/**
 *  换行符 \n
 */
NSString * lineBreakString(void) {
    return [NSString lineBreakString];
}

NSString * NSStringFromInt(int value) {
    return kSYZNumberToString(value);
}
NSString * NSStringFromNSInteger(NSInteger value) {
    return kSYZNumberToString(value);
}
NSString * NSStringFromNSUInteger(NSUInteger value) {
    return kSYZNumberToString(value);
}
NSString * NSStringFromunsignedLongLong(unsigned long long value) {
    return kSYZNumberToString(value);
}
NSString * NSStringFromCGFloat(CGFloat value) {
    return kSYZNumberToString(value);
}
NSString * NSStringFromPointer(id x) {
    return [NSString stringWithFormat:@"%p",x];
}

BOOL SYZIsEqualToString(NSString * aStr , NSString * bStr) {
    if ([aStr isKindOfClass:[NSString class]] &&
        [bStr isKindOfClass:[NSString class]]) {
        
        return [aStr isEqualToString:bStr];
    } else {
        /*
         因为此方法是判断字符串是否相等的，所以如果都不是字符串就直接返回NO
         */
        return NO;
    }
}

/**
 *  生成UUID
 *  @discussion 格式如下:
 *          2B064C33-149B-43A6-A506-33066B49AED2
 F017D24F-5CF2-4C17-B71C-CCA5FA1CA87D
 *  @return UUID
 */
NSString * const SYZGeneralUUIDString(void) {
    return [NSUUID UUID].UUIDString;
}

+ (NSString *)emptyString {
    return @"";
}

+ (NSString *)dotString {
    return @".";
}

+ (NSString *)commaString {
    return @",";
}

+ (NSString *)lineBreakString {
    return @"\n";
}

#pragma mark - 截取字符串
- (NSString *)syz_subStringWithoutRange:(NSRange)aRange {
    //前面的string
    NSString * preString = [self substringToIndex:aRange.location];
    //后面的string
    NSString * sufString = [self substringFromIndex:aRange.location + aRange.length];
    return [preString stringByAppendingString:sufString];
}

/*!
 *  删除第一个字符
 */
- (NSString *)syz_removeFirstCharacter {
    return [self syz_removeFirstCharacterWithCount:1];
}

- (NSString *)syz_removeFirstCharacterWithCount:(NSUInteger)aCount {
    if (aCount == 0 || self.length <= 0) {
        return self;
    }
    
    if (self.length <= aCount) {
        return [NSString emptyString];
    }
    
    return [self substringWithRange:NSMakeRange(aCount, self.length - aCount)];
}

- (NSString *)syz_removeStringFromHeader:(NSString *)aString {
    if ([self syz_containsSubstring:aString]) {
        NSRange range = [self syz_rangeOfStringFromHeader:aString];
        return [self syz_subStringWithoutRange:range];
    }
    
    return self;
}

/*!
 *  删除最后一个字符
 */
- (NSString *)syz_removeLastCharacter {
    
    return [self syz_removeLastCharacterWithCount:1];
}

- (NSString *)syz_removeLastCharacterWithCount:(NSUInteger)aCount {
    
    if (aCount == 0 || self.length <= 0) {
        return self;
    }
    
    if (self.length <= aCount) {
        return [NSString emptyString];
    }
    
    return [self substringWithRange:NSMakeRange(0, self.length - aCount)];
}

- (NSString *)syz_removeStringFromEnd:(NSString *)aString {
    if ([self syz_containsSubstring:aString]) {
        NSRange range = [self syz_rangeOfStringFromEnder:aString];
        return [self syz_subStringWithoutRange:range];
    }
    return self;
}

- (NSString *)syz_removeAllStrings:(NSString *)aString {
    return [self stringByReplacingOccurrencesOfString:aString withString:@""];
}

- (NSString *)syz_removeFreeWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 不区分大小写，比较两个字符串*/
- (BOOL)syz_isEqualToIgnoreCaseString:(NSString*)anotherString{
    return [self.lowercaseString isEqualToString:anotherString.lowercaseString];
}

/** 隐藏中间<=一半的字符串*/
- (NSString*)syz_beSecret{
    NSUInteger length = self.length;
    if (self.length <= 3) return self;
    int hiddenLength = floor(length / 2);
    int headerShowLength = floor((length - hiddenLength) / 2);
    NSMutableString* star = [[NSMutableString alloc] initWithCapacity:hiddenLength];
    for (int i = 0; i < hiddenLength; i++) {
        [star appendString:@"*"];
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(headerShowLength, hiddenLength) withString:star];
}

/*!
 *  删掉行首和行尾换行符"\n"
 *  如： "\na\nb\n" ==> "a\nb"
 */
- (NSString *)syz_trimNewLine {
    if (self.length <= 0) {
        return self;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

/*!
 *  删除所有的换行符"\n"
 *  如： "\na\nb\n" ==> "ab"
 */
- (NSString *)syz_trimNewLines {
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

/**
 *  删除行首和行尾的换行符和空格
 *  如："\n a \n b \n" ==> "a \n b"
 */
- (NSString *)syz_trimNewLineAndWhiteSpace {
    if (self.length <= 0) {
        return self;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  删除所有的换行符和空格符
 *  如："\n a \n b \n" ==> "ab"
 */
- (NSString *)syz_trimNewLinesAndWhiteSpaces {
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""]
            stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (BOOL)syz_isNewLinesAndWhiteSpaces {
    return SYZIsEmptyString([self syz_trimNewLineAndWhiteSpace]);
}

- (NSString *)syz_reverseString {
    if (self.length <= 1)
        return self;
    
    NSUInteger stringLength = self.length;
    NSInteger stringIndex, reverseStringIndex;
    unichar *stringChars = calloc(sizeof(unichar), stringLength);
    unichar *reverseStringChars = calloc(sizeof(unichar), stringLength);
    
    [self getCharacters:stringChars range:NSMakeRange(0, stringLength)];
    
    for (stringIndex=stringLength-1, reverseStringIndex=0; stringIndex>=0; stringIndex--, reverseStringIndex++)
        reverseStringChars[reverseStringIndex] = stringChars[stringIndex];
    
    free(stringChars);
    
    return [[NSString alloc] initWithCharactersNoCopy:reverseStringChars length:stringLength freeWhenDone:YES];
}

/**
 全长度  {0,self.length}
 */
- (NSRange)syz_allRange {
    return NSMakeRange(0, self.length);
}

/**
 range是否越界
 */
- (BOOL)syz_isValidRange:(NSRange)range {
    NSRange interRange = NSIntersectionRange(self.syz_allRange, range);
    return NSEqualRanges(range, interRange);
}

/**
 index 是否越界
 */
- (BOOL)syz_isValidIndex:(NSUInteger)index {
    return [self syz_isValidRange:NSMakeRange(index, 1)];
}

/**
 取对应索引的字符
 */
- (NSString *)syz_stringAtIndex:(NSUInteger)index {
    if ([self syz_isValidIndex:index]) {
        return [self substringWithRange:NSMakeRange(index, 1)];
    }
    
    return @"";
}
- (unichar)syz_characterAtIndex:(NSUInteger)index {
    if ([self syz_isValidIndex:index]) {
        return [self characterAtIndex:index];
    }
    
    return 0;
}

/**
 第一个字符
 */
- (NSString *)syz_firstString {
    return [self syz_stringAtIndex:0];
}
- (unichar)syz_firstCharactor {
    return [self syz_characterAtIndex:0];
}

/**
 最后一个字符
 */
- (NSString *)syz_lastString {
    return [self syz_stringAtIndex:self.length - 1];
}
- (unichar )syz_lastCharactor {
    return [self syz_characterAtIndex:self.length - 1];
}

/**
 让第一个字符 大写
 */
- (NSString *)syz_upperFirstChar {
    if (SYZIsEmptyString(self)) {
        return self;
    }
    
    NSString * firstString = [self syz_firstString];
    if ([firstString syz_isAllString]) { //检测第一个字符是否是字符串
        if ([firstString syz_isAllLowerString]) {
            return [[firstString uppercaseString] stringByAppendingString:[self syz_removeFirstCharacter]];
        }
    }
    
    return self;
}

/**
 让第一个字符 小写
 */
- (NSString *)syz_lowerFirstChar {
    if (SYZIsEmptyString(self)) {
        return self;
    }
    
    NSString * firstString = [self syz_firstString];
    if ([firstString syz_isAllString]) { //检测第一个字符是否是字符串
        if ([firstString syz_isAllUpperString]) {
            return [[firstString lowercaseString] stringByAppendingString:[self syz_removeFirstCharacter]];
        }
    }
    
    return self;
}

#pragma mark - 判断类型


- (NSString *)syz_32md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [NSString stringWithString: output].uppercaseString;
}

- (NSString *)syz_128md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [NSString stringWithString: output].uppercaseString;
}

- (NSString *)syz_toString {
    
    return self;
}

- (NSNumber *)syz_toNumber {
    if ([self syz_isFloatValue]) {
        return [self syz_toDoubleNumber];
    }
    
    return [self syz_toLongLongNumber];
}

- (BOOL)syz_startsWith:(NSString*)prefix {
    return [self rangeOfString:prefix].location == 0;
}

- (BOOL)syz_endsWith:(NSString*)suffix {
    NSRange range = [self rangeOfString:suffix options:NSBackwardsSearch];
    return range.location + range.length == self.length;
}

- (NSNumber *)syz_toDoubleNumber {
    
    return @(self.doubleValue);
}

- (NSNumber *)syz_toFloatNumber {
    
    return @(self.floatValue);
}

- (NSNumber *)syz_toIntegerNumber {
    
    return @(self.integerValue);
}

- (NSNumber *)syz_toLongNumber {
    
    return @(self.intValue);
}

- (NSNumber *)syz_toLongLongNumber {
    
    return @(self.longLongValue);
}

- (NSURL *)syz_toURL {
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSURL *)syz_toFileURL {
    return [NSURL fileURLWithPath:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)syz_toPinyin
{
    if ([self length] == 0)
    {
        return @"";
    }
    NSMutableString *pinyin = [self mutableCopy];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO))
    {
        return @"";
    }
    return pinyin;
}



/**
 从头搜索字符串
 @example "4&12345&234"
 searchedString为 "&"  则 range = {1,1}
 如果searchedString为 "34" 则 range = {4,2}
 */
- (NSRange)syz_rangeOfStringFromHeader:(NSString *)searchedString {
    return [self rangeOfString:searchedString options:NSLiteralSearch];
}

/**
 从尾部搜索字符串
 @example "4&12345&234"
 searchedString为 "&" 则range = {6,1}
 如果searchedString为 "34" 则 range = {9,2}
 */
- (NSRange)syz_rangeOfStringFromEnder:(NSString *)searchedString {
    return [self rangeOfString:searchedString options:NSBackwardsSearch];
}

#pragma mark - 容错方法
- (NSString *)syz_appendString:(NSString *)string {
    if (SYZIsEmptyString(string)) {
        return self;
    }
    
    return [self stringByAppendingString:string];
}

- (NSString *)syz_stringByAppendingURLPathComponent:(NSString *)aString {
    BOOL needSep1 = ![[self syz_lastString] isEqualToString:@"/"];
    BOOL needSep2 = ![[aString syz_firstString] isEqualToString:@"/"];
    
    if (needSep1 && needSep2) {
        aString = [@"/" syz_appendString:aString];
    } else if (!needSep1 && !needSep2) {
        aString = [aString syz_removeFirstCharacter];
    }
    
    return [self syz_appendString:aString];
}

- (BOOL)syz_containsSubstring:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

#pragma mark - 正则判断方法
/**
 *  是否是合法的URL
 */
- (BOOL)syz_isValidURL {
    
    NSError * error = nil;
    NSDataDetector * dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink
                                                                    error:&error];
    NSArray<NSTextCheckingResult *> * results = [dataDetector matchesInString:self
                                                                      options:0
                                                                        range:NSMakeRange(0, self.length)];
    return results.count == 1;
}

/**
 *  是否是合法的邮件
 */
- (BOOL)syz_isValidEmail {
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)stringValue {
    return self;
}

#pragma mark - 编码
- (NSString *)syz_urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef)self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *)syz_urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

#pragma mark - Data与String互转
+ (instancetype)syz_stringWithUTF8Data:(NSData *)data {
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (nullable NSData *)syz_dataUsingUTF8Encoding {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 路径相关
/*
 不带类型的文件名字   aaa
 */
- (NSString *)syz_fileNameWithoutType {
    NSString * fullName = [self syz_fileFullName];
    NSString * fullType = [self syz_fileFullType];
    if ([fullName hasSuffix:fullType]) {
        NSRange range = [fullName rangeOfString:fullType options:NSBackwardsSearch]; //从后往前匹配
        if (range.location != NSNotFound) {
            return [fullName substringToIndex:range.location];
        }
    }
    return @"";
}
/*
 文件的完整名字    aaa.zip
 */
- (NSString *)syz_fileFullName {
    return self.lastPathComponent;
}
/*
 文件的类型 zip
 */
- (NSString *)syz_fileType {
    return self.pathExtension;
}

- (NSString *)syz_fileFullType {
    return [@"." stringByAppendingString:[self syz_fileType]];
}

static NSString * syz_file_KBs = @"1024";
static NSString * syz_file_MBs = @"1048576"; //1048576
static NSString * syz_file_GBs = @"1073741824"; //1073741824
static NSString * syz_file_TBs = @"1099511627776"; //1099511627776
static NSArray * syz_file_sizes;
static NSArray * syz_file_sizes_simple;
__attribute__((constructor)) static void initFileNormalSize(void)
{
    syz_file_sizes = @[@{@"size": syz_file_TBs,@"unit":@"TB"},
                       @{@"size": syz_file_GBs,@"unit":@"GB"},
                       @{@"size": syz_file_MBs,@"unit":@"MB"},
                       @{@"size": syz_file_KBs,@"unit":@"KB"},
                       @{@"size": @"0",@"unit":@"B"}];
    
    syz_file_sizes_simple = @[@{@"size": syz_file_TBs,@"unit":@"T"},
                              @{@"size": syz_file_GBs,@"unit":@"G"},
                              @{@"size": syz_file_MBs,@"unit":@"M"},
                              @{@"size": syz_file_KBs,@"unit":@"K"},
                              @{@"size": @"0",@"unit":@"B"}];
}

#pragma mark - 文件大小相关
+ (NSString *)syz_stringWithFileSize:(unsigned long long)fileSize {
    return [NSStringFromunsignedLongLong(fileSize) syz_toFileSize];
}

/**
 返回格式: 12.00G 等
 */
+ (NSString *)syz_stringWithSimpleFileSize:(unsigned long long)fileSize {
    return [NSStringFromunsignedLongLong(fileSize) syz_toSimpleFileSize];
}
/**
 返回格式: 12.00GB 等
 */
- (NSString *)syz_toFileSize {
    return [self syz_toFileSize:NO];
}
/**
 返回格式: 12.00G 等
 */
- (NSString *)syz_toSimpleFileSize {
    return [self syz_toFileSize:YES];
}

- (NSString *)syz_toFileSize:(BOOL)isSimple {
    NSArray * oriFileSizeInfo = syz_file_sizes;
    if (isSimple) {
        oriFileSizeInfo = syz_file_sizes_simple;
    }
    unsigned long long fileSizeOri = self.longLongValue;
    for (NSDictionary * sizeDict in oriFileSizeInfo) {
        if ([sizeDict[@"size"] compare:self options:NSNumericSearch] != NSOrderedDescending) {
            CGFloat fileSize = 0;
            if ([sizeDict[@"size"] floatValue] <= 0) {
                fileSize = fileSizeOri;
            } else {
                fileSize = fileSizeOri / [sizeDict[@"size"] floatValue];
            }
            return [NSString stringWithFormat:@"%.2f%@", fileSize,sizeDict[@"unit"]];
        }
    }
    
    return @"0.00B";
}

- (NSString *)syz_removePathExtension {
    NSString * filePath = self;
    if (SYZIsNotEmptyString(filePath.pathExtension)) {
        return [filePath syz_removeStringFromEnd:[SYZDotString() stringByAppendingString:filePath.pathExtension]];
    }
    
    return filePath;
}

/**
 拼接成完整的文件名
 aaa  jpg ==> aaa.jpg
 aaa  .jpg ==> aaa.jpg
 aaa. jpg ==> aaa.jpg
 */
- (NSString *)syz_appendingPathExtension:(NSString *)pathExtension {
    NSString * pathName = self;
    BOOL pathNameHasDot = [pathName hasSuffix:@"."];
    BOOL pathExtensionHasDot = [pathExtension hasPrefix:@"."];
    if ((pathNameHasDot && !pathExtensionHasDot) || (!pathNameHasDot && pathExtensionHasDot)) {
        return [pathName stringByAppendingString:pathExtension];
    } else if (!pathNameHasDot && !pathExtensionHasDot) {
        return [NSString stringWithFormat:@"%@.%@",pathName,pathExtension];
    } else if (pathExtensionHasDot && pathNameHasDot) {
        return [NSString stringWithFormat:@"%@%@",pathName,[pathExtension syz_removeFirstCharacter]];
    }
    
    return self;
}

#pragma mark - 时间相关
+ (NSString *)syz_stringHHmmssWithTime:(int)time {
    int hour = time / 3600;
    int minute = (time - hour * 3600) / 60;
    int second = time - hour * 3600 - minute * 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
}
+ (NSString *)syz_stringmmssWithTime:(int)time {
    return [[self syz_stringHHmmssWithTime:time] substringWithRange:NSMakeRange(3, 5)];
}

/**
 将 01:01:20或者 01:20等格式的时间转成以秒为单位的时间
 */
- (NSUInteger)syz_timeStringToSeconds {
    NSUInteger secondTime = 0;
    NSString * duration = self;
    NSArray * timeArrayI = [duration componentsSeparatedByString:@":"];
    if (timeArrayI.count >= 1 && timeArrayI.count <= 3 ) {
        NSUInteger hour = 0;
        NSUInteger minute = 0;
        NSUInteger second = 0;
        
        if (timeArrayI.count == 3) {
            hour = [timeArrayI.firstObject integerValue];
            minute = [timeArrayI[1] integerValue];
        } else if (timeArrayI.count == 2) {
            minute = [timeArrayI.firstObject integerValue];
        }
        
        second = [timeArrayI.lastObject integerValue];
        
        secondTime = hour * 60 * 60 + minute * 60 + second;
    }
    
    return secondTime;
}


/**
 转义字符
 */
- (id)syz_replacingPercentEscapes {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - HTTP相关
/**
 是否以 http/https开头
 */
- (BOOL)syz_hasPrefixHTTP {
    return [self.lowercaseString hasPrefix:@"http:"] || [self.lowercaseString hasPrefix:@"https:"];
}
/**
 是否以 https开头
 */
- (BOOL)syz_hasPrefixHTTPS {
    return [self.lowercaseString hasPrefix:@"https:"];
}

@end
