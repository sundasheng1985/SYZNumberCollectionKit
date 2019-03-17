//
//  NSAttributedString+SYZAdditon.h
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (SYZAdditon)
/** 字符串范围 */
- (NSRange)syz_allRange;

/** 当前范围是否在字符串内 */
- (BOOL)syz_isValidRange:(NSRange)range;

/** 当前范围部在字符串内 */
- (BOOL)syz_isInvalidRange:(NSRange)range;

/** 转成可变富文本 */
- (NSMutableAttributedString *)syz_toMutableAttributedString;
@end
