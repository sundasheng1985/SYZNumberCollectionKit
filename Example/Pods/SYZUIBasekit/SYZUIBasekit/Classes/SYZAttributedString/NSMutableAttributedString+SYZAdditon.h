//
//  NSMutableAttributedString+SYZAdditon.h
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#import <SYZUIBasekit/NSAttributedString+SYZAdditon.h>
#import <SYZUIBasekit/NSString+SYZString.h>
#import <SYZUIBasekit/NSObject+SYZObject.h>

/** 可以创建富文本 */
@interface NSMutableAttributedString (SYZAdditon)

#pragma mark - Property
///** 字体大小 */
//@property (nonatomic,strong) UIFont* syz_font;
///** 字体颜色 */
//@property (nonatomic,strong) UIColor* syz_color;
///** 背景颜色 */
//@property (nonatomic,strong) UIColor* syz_backgroundColor;
///** 段落样式 */
//@property (nonatomic, strong, readwrite, nullable) NSParagraphStyle *syz_paragraphStyle;
///** 分割间隙 */
//@property (nonatomic, assign, readwrite) CGFloat syz_lineSpacing;
///** 段落间隙 */
//@property (nonatomic, assign, readwrite) CGFloat syz_paragraphSpacing;
///** 段落间隙之前 */
//@property (nonatomic, assign, readwrite) CGFloat syz_paragraphSpacingBefore;
///** 文字布局类型 */
//@property (nonatomic, assign, readwrite) NSTextAlignment syz_alignment;
///** 首线缩排 */
//@property (nonatomic, assign, readwrite) CGFloat syz_firstLineHeadIndent;
///** 首文字缩排 */
//@property (nonatomic, assign, readwrite) CGFloat syz_headIndent;
///** 尾部缩排 */
//@property (nonatomic, assign, readwrite) CGFloat syz_tailIndent;
//
///** UILineBreakModeWordWrap = 0, 以单词为单位换行，以单位为单位截断。
// UILineBreakModeCharacterWrap, 以字符为单位换行，以字符为单位截断。
// UILineBreakModeClip, 以单词为单位换行。以字符为单位截断。
// UILineBreakModeHeadTruncation, 以单词为单位换行。如果是单行，则开始部分有省略号。如果是多行，则中间有省略号，省略号后面有4个字符。
// UILineBreakModeTailTruncation, 以单词为单位换行。无论是单行还是多行，都是末尾有省略号。
// UILineBreakModeMiddleTruncation, 以单词为单位换行。无论是单行还是多行，都是中间有省略号，省略号后面只有2个字符。
// */
//@property (nonatomic, assign, readwrite) NSLineBreakMode syz_lineBreakMode;
///** 最小行高 */
//@property (nonatomic, assign, readwrite) CGFloat syz_minimumLineHeight;
///** 最大行高 */
//@property (nonatomic, assign, readwrite) CGFloat syz_maximumLineHeight;
///** 文字书写方向 */
//@property (nonatomic, assign, readwrite) NSWritingDirection syz_baseWritingDirection;
///** 多样行高 */
//@property (nonatomic, assign, readwrite) CGFloat syz_lineHeightMultiple;
///** 链接符 */
//@property (nonatomic, assign, readwrite) float syz_hyphenationFactor;
///** 表格间隔 */
//@property (nonatomic, assign, readwrite) CGFloat syz_defaultTabInterval;
///** 字符间隔 */
//@property (nonatomic, assign, readwrite) CGFloat syz_characterSpacing;
///** 下滑线样式 */
//@property (nonatomic, assign, readwrite) NSUnderlineStyle syz_lineThroughStyle;
///** 下滑线颜色 */
//@property (nonatomic, strong, readwrite, nullable) UIColor *syz_lineThroughColor;
///** 字符链接 */
//@property (nonatomic, assign, readwrite) NSInteger syz_characterLigature;
///** 下滑样式 */
//@property (nonatomic, assign, readwrite) NSUnderlineStyle syz_underLineStyle;
///** 下滑颜色 */
//@property (nonatomic, strong, readwrite, nullable) UIColor *syz_underLineColor;
///** 触笔宽 */
//@property (nonatomic, assign, readwrite) CGFloat syz_strokeWidth;
///** 触笔颜色 */
//@property (nonatomic, strong, readwrite, nullable) UIColor *syz_strokeColor;
///** 阴影 */
//@property (nonatomic, strong, readwrite, nullable) NSShadow *syz_shadow;
///** 链接 */
//@property (nonatomic, strong, readwrite, nullable) id syz_link;
///** 基本行 */
//@property (nonatomic, assign, readwrite) CGFloat syz_baseline;
///** 倾斜 */
//@property (nonatomic, assign, readwrite) CGFloat syz_obliqueness;
///** 膨胀 */
//@property (nonatomic, assign, readwrite) CGFloat syz_expansion;
//
//#pragma mark - Get
//- (UIFont*)syz_fontAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range;
//- (UIColor*)syz_colorAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range;
//- (UIColor*)syz_backgroundColorAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range;
//
//#pragma mark - Add
///** 添加什么样式属性，属性值，范围 */
//- (void)syz_addAttribute:(NSString *)name value:(id)value range:(NSRange)range;
///** 这个范围内膨胀多少 */
//- (void)syz_addExpansion:(CGFloat)expansion range:(NSRange)range;
//
//- (void)syz_addForeColorAttributeWithValue:(UIColor *)color;
//- (void)syz_addForeColorAttributeWithValue:(UIColor *)color range:(NSRange)range;
//
//- (void)syz_addFontAttributeWithValue:(UIFont *)font;
//- (void)syz_addFontAttributeWithValue:(UIFont *)font range:(NSRange)range;
//
///**
// kCTUnderlinePatternSolid        全实下滑线 ——————————
// kCTUnderlinePatternDot          点点下滑线 ..........
// kCTUnderlinePatternDash         分割下滑线 —— —— —— ——
// kCTUnderlinePatternDashDot      _ . _ . _
// kCTUnderlinePatternDashDotDot   _ .. _..
// */
//- (void)syz_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style
//                                       modifier:(CTUnderlineStyleModifiers)modifier;
//- (void)syz_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style
//                                       modifier:(CTUnderlineStyleModifiers)modifier
//                                          range:(NSRange)range;
///** 添加触笔颜色和宽细 */
//- (void)syz_addAttributeStrokeColor:(UIColor *)strokeColor strokeWidth:(unichar)strokeWidth;
///** 字符间隙 */
//- (void)syz_addAttributeCharacterSpacing:(unichar)characterSpacing;
//- (void)syz_addAttributeCharacterSpacing:(unichar)characterSpacing range:(NSRange)rang;
//
///** 设置段落 */
//- (void)syz_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment
//                        lineSpaceStyle:(CGFloat)linesSpacing
//                   paragraphSpaceStyle:(CGFloat)paragraphSpacing
//                        lineBreakStyle:(CTLineBreakMode)lineBreakMode;
//- (void)syz_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment
//                        lineSpaceStyle:(CGFloat)linesSpacing
//                   paragraphSpaceStyle:(CGFloat)paragraphSpacing
//                        lineBreakStyle:(CTLineBreakMode)lineBreakMode
//                                  rang:(NSRange)range;
//
//- (void)syz_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
//                         lineSpaceStyle:(CGFloat)linesSpacing
//                    paragraphSpaceStyle:(CGFloat)paragraphSpacing
//                         lineBreakStyle:(NSLineBreakMode)lineBreakMode;
//- (void)syz_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
//                         lineSpaceStyle:(CGFloat)linesSpacing
//                    paragraphSpaceStyle:(CGFloat)paragraphSpacing
//                         lineBreakStyle:(NSLineBreakMode)lineBreakMode
//                                   rang:(NSRange)range;
@end
