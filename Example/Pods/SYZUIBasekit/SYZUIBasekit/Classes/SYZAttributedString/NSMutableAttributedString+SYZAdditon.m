//
//  NSMutableAttributedString+SYZAdditon.m
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import "NSMutableAttributedString+SYZAdditon.h"

#define syz_attributeFilterRange(range) \
if([self syz_isInvalidRange:range]) return;

#define syz_setParagraphStyleProperty(_property_,_range_) \
[self enumerateAttribute:NSParagraphStyleAttributeName inRange:_range_ options:kNilOptions usingBlock:^(NSParagraphStyle *value, NSRange subRange, BOOL *stop) {\
NSMutableParagraphStyle *style = nil;\
if (!value) {\
style = [[NSMutableParagraphStyle alloc]init];\
if (style._property_ == _property_) {\
return ;\
}\
} else {\
if (value._property_ == _property_) {\
return ;\
}\
if ([value isKindOfClass:[NSMutableParagraphStyle class]]) {\
style = (NSMutableParagraphStyle *)value;\
}else {\
style = [value mutableCopy];\
}\
}\
style._property_ = _property_;\
[self syz_addParagraphStyle:style range:subRange];\
}];\

@implementation NSMutableAttributedString (SYZAdditon)

- (void)syz_addAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if ([self syz_isInvalidRange:range]) return;
    if (SYZIsEmptyString(name)) return;
    
    if (SYZIsEmpty(value)) {
        [self removeAttribute:name range:range];
    } else {
        [self addAttribute:name value:value range:range];
    }
}

#pragma mark - Get
- (UIFont *)syz_font {
    return [self syz_fontAtIndex:0 effectiveRange:NULL];
}

- (void)setsyz_font:(UIFont *)syz_font {
    [self syz_addAttribute:NSFontAttributeName value:syz_font range:self.syz_allRange];
}

- (UIFont*)syz_fontAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range {
    return [self attribute:NSFontAttributeName atIndex:index effectiveRange:range];
}

- (UIColor *)syz_color {
    return [self syz_colorAtIndex:0 effectiveRange:NULL];
}

- (void)setsyz_color:(UIColor *)syz_color {
    [self syz_addAttribute:NSForegroundColorAttributeName value:syz_color range:self.syz_allRange];
}

- (UIColor*)syz_colorAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range {
    return [self attribute:NSForegroundColorAttributeName atIndex:index effectiveRange:range];
}

- (UIColor *)syz_backgroundColor {
    return [self syz_backgroundColorAtIndex:0 effectiveRange:NULL];
}

- (UIColor *)syz_backgroundColorAtIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range {
    return [self attribute:NSBackgroundColorAttributeName atIndex:index effectiveRange:range];
}

- (void)setsyz_paragraphStyle:(NSParagraphStyle *)paragraphStyle {
    [self syz_addParagraphStyle:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)syz_addParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    [self syz_addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

- (void)setsyz_lineSpacing:(CGFloat)lineSpacing {
    [self syz_addLineSpacing:lineSpacing range:NSMakeRange(0, self.length)];
}
- (void)syz_addLineSpacing:(CGFloat)lineSpacing range:(NSRange)range {
    syz_setParagraphStyleProperty(lineSpacing,range);
}

- (void)setsyz_paragraphSpacing:(CGFloat)paragraphSpacing {
    [self syz_addParagraphSpacing:paragraphSpacing range:NSMakeRange(0, self.length)];
}
- (void)syz_addParagraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range {
    syz_setParagraphStyleProperty(paragraphSpacing,range);
}

- (void)setsyz_paragraphSpacingBefore:(CGFloat)paragraphSpacingBefore {
    [self syz_addParagraphSpacing:paragraphSpacingBefore range:NSMakeRange(0, self.length)];
}
- (void)syz_addParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range {
    syz_setParagraphStyleProperty(paragraphSpacingBefore,range);
}

- (void)setsyz_alignment:(NSTextAlignment)alignment {
    [self syz_addAlignment:alignment range:NSMakeRange(0, self.length)];
}
- (void)syz_addAlignment:(NSTextAlignment)alignment range:(NSRange)range {
    syz_setParagraphStyleProperty(alignment,range);
}

- (void)setsyz_firstLineHeadIndent:(CGFloat)firstLineHeadIndent {
    [self syz_addFirstLineHeadIndent:firstLineHeadIndent range:NSMakeRange(0, self.length)];
}
- (void)syz_addFirstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range {
    syz_setParagraphStyleProperty(firstLineHeadIndent,range);
}

- (void)setsyz_headIndent:(CGFloat)headIndent {
    [self syz_addHeadIndent:headIndent range:NSMakeRange(0, self.length)];
}
- (void)syz_addHeadIndent:(CGFloat)headIndent range:(NSRange)range {
    syz_setParagraphStyleProperty(headIndent,range);
}

- (void)setsyz_tailIndent:(CGFloat)tailIndent {
    [self syz_addTailIndent:tailIndent range:NSMakeRange(0, self.length)];
}
- (void)syz_addTailIndent:(CGFloat)tailIndent range:(NSRange)range {
    syz_setParagraphStyleProperty(tailIndent,range);
}

- (void)setsyz_lineBreakMode:(NSLineBreakMode)lineBreakMode {
    [self syz_addLineBreakMode:lineBreakMode range:NSMakeRange(0, self.length)];
}
- (void)syz_addLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range {
    syz_setParagraphStyleProperty(lineBreakMode,range);
}

- (void)setsyz_minimumLineHeight:(CGFloat)minimumLineHeight {
    [self syz_addMinimumLineHeight:minimumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)syz_addMinimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range {
    syz_setParagraphStyleProperty(minimumLineHeight,range);
}

- (void)setsyz_maximumLineHeight:(CGFloat)maximumLineHeight {
    [self syz_addMinimumLineHeight:maximumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)syz_addMaximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range {
    syz_setParagraphStyleProperty(maximumLineHeight,range);
}

- (void)setsyz_baseWritingDirection:(NSWritingDirection)baseWritingDirection {
    [self syz_addBaseWritingDirection:baseWritingDirection range:NSMakeRange(0, self.length)];
}
- (void)syz_addBaseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range {
    syz_setParagraphStyleProperty(baseWritingDirection,range);
}

- (void)setsyz_lineHeightMultiple:(CGFloat)lineHeightMultiple {
    [self syz_addLineHeightMultiple:lineHeightMultiple range:NSMakeRange(0, self.length)];
}
- (void)syz_addLineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range {
    syz_setParagraphStyleProperty(lineHeightMultiple,range);
}

- (void)setsyz_hyphenationFactor:(float)hyphenationFactor {
    [self syz_addHyphenationFactor:hyphenationFactor range:NSMakeRange(0, self.length)];
}
- (void)syz_addHyphenationFactor:(float)hyphenationFactor range:(NSRange)range {
    syz_setParagraphStyleProperty(hyphenationFactor,range);
}

- (void)setsyz_defaultTabInterval:(CGFloat)defaultTabInterval {
    [self syz_addDefaultTabInterval:defaultTabInterval range:NSMakeRange(0, self.length)];
}
- (void)syz_addDefaultTabInterval:(CGFloat)defaultTabInterval range:(NSRange)range {
    syz_setParagraphStyleProperty(defaultTabInterval,range);
}

- (void)setsyz_characterSpacing:(CGFloat)characterSpacing {
    [self syz_addCharacterSpacing:characterSpacing range:NSMakeRange(0, self.length)];
}
- (void)syz_addCharacterSpacing:(CGFloat)characterSpacing range:(NSRange)range {
    [self syz_addAttribute:NSKernAttributeName value:@(characterSpacing) range:range];
}

- (void)setsyz_lineThroughStyle:(NSUnderlineStyle)lineThroughStyle {
    [self syz_addLineThroughStyle:lineThroughStyle range:NSMakeRange(0, self.length)];
}
- (void)syz_addLineThroughStyle:(NSUnderlineStyle)style range:(NSRange)range {
    [self syz_addAttribute:NSStrikethroughStyleAttributeName value:@(style) range:range];
}

- (void)setsyz_lineThroughColor:(UIColor *)lineThroughColor {
    [self syz_addLineThroughColor:lineThroughColor range:NSMakeRange(0, self.length)];
}
- (void)syz_addLineThroughColor:(UIColor *)color range:(NSRange)range {
    [self syz_addAttribute:NSStrikethroughColorAttributeName value:color range:range];
}

- (void)setsyz_underLineStyle:(NSUnderlineStyle)underLineStyle {
    [self syz_addUnderLineStyle:underLineStyle range:NSMakeRange(0, self.length)];
}
- (void)syz_addUnderLineStyle:(NSUnderlineStyle)style range:(NSRange)range {
    [self syz_addAttribute:NSUnderlineStyleAttributeName value:@(style) range:range];
}

- (void)setsyz_underLineColor:(UIColor *)underLineColor {
    [self syz_addUnderLineColor:underLineColor range:NSMakeRange(0, self.length)];
}
- (void)syz_addUnderLineColor:(UIColor *)color range:(NSRange)range {
    [self syz_addAttribute:NSUnderlineColorAttributeName value:color range:range];
}

- (void)setsyz_characterLigature:(NSInteger)characterLigature {
    [self syz_addCharacterLigature:characterLigature range:NSMakeRange(0, self.length)];
}
- (void)syz_addCharacterLigature:(NSInteger)characterLigature range:(NSRange)range {
    [self syz_addAttribute:NSLigatureAttributeName value:@(characterLigature) range:range];
}

- (void)setsyz_strokeColor:(UIColor *)strokeColor {
    [self syz_addStrokeColor:strokeColor range:NSMakeRange(0, self.length)];
}
- (void)syz_addStrokeColor:(UIColor *)color range:(NSRange)range {
    [self syz_addAttribute:NSStrokeColorAttributeName value:color range:range];
}

- (void)setsyz_strokeWidth:(CGFloat)strokeWidth {
    [self syz_addStrokeWidth:strokeWidth range:NSMakeRange(0, self.length)];
}
- (void)syz_addStrokeWidth:(CGFloat)strokeWidth range:(NSRange)range {
    [self syz_addAttribute:NSStrokeWidthAttributeName value:@(strokeWidth) range:range];
}

- (void)setsyz_shadow:(NSShadow *)shadow {
    [self syz_addShadow:shadow range:NSMakeRange(0, self.length)];
}
- (void)syz_addShadow:(NSShadow *)shadow range:(NSRange)range {
    [self syz_addAttribute:NSShadowAttributeName value:shadow range:range];
}

- (void)syz_addAttachment:(NSTextAttachment *)attachment range:(NSRange)range {
    [self syz_addAttribute:NSAttachmentAttributeName value:attachment range:range];
}

- (void)setsyz_link:(id)link {
    [self syz_addLink:link range:NSMakeRange(0, self.length)];
}
- (void)syz_addLink:(id)link range:(NSRange)range {
    [self syz_addAttribute:NSLinkAttributeName value:link range:range];
}

- (void)setsyz_baseline:(CGFloat)baseline {
    [self syz_addBaseline:baseline range:NSMakeRange(0, self.length)];
}
- (void)syz_addBaseline:(CGFloat)baseline range:(NSRange)range {
    [self syz_addAttribute:NSBaselineOffsetAttributeName value:@(baseline) range:range];
}

- (void)syz_addWritingDirection:(NSWritingDirection)writingDirection range:(NSRange)range {
    [self syz_addAttribute:NSWritingDirectionAttributeName value:@(writingDirection) range:range];
}

- (void)setsyz_obliqueness:(CGFloat)obliqueness {
    [self syz_addObliqueness:obliqueness range:NSMakeRange(0, self.length)];
}
- (void)syz_addObliqueness:(CGFloat)obliqueness range:(NSRange)range {
    [self syz_addAttribute:NSObliquenessAttributeName value:@(obliqueness) range:range];
}

- (void)setsyz_expansion:(CGFloat)expansion {
    [self syz_addExpansion:expansion range:NSMakeRange(0, self.length)];
}
- (void)syz_addExpansion:(CGFloat)expansion range:(NSRange)range {
    [self syz_addAttribute:NSExpansionAttributeName value:@(expansion) range:range];
}


#pragma mark - Add
- (void)syz_addForeColorAttributeWithValue:(UIColor *)color {
    [self syz_addForeColorAttributeWithValue:color range:self.syz_allRange];
}
- (void)syz_addForeColorAttributeWithValue:(UIColor *)color range:(NSRange)range {
    [self syz_addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)syz_addFontAttributeWithValue:(UIFont *)font {
    [self syz_addFontAttributeWithValue:font range:self.syz_allRange];
}
- (void)syz_addFontAttributeWithValue:(UIFont *)font range:(NSRange)range {
    [self syz_addAttribute:NSFontAttributeName value:font range:range];
}

- (void)syz_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style
modifier:(CTUnderlineStyleModifiers)modifier {
    [self syz_addUnderlineStyleAttributeWithValue:style modifier:modifier range:self.syz_allRange];
}

- (void)syz_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier range:(NSRange)range {
    [self removeAttribute:(NSString *)kCTUnderlineStyleAttributeName range:range];
    
    if (style != kCTUnderlineStyleNone) {
        [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                     value:@(style | modifier)
                     range:range];
    }
}

- (void)syz_addAttributeStrokeColor:(UIColor *)strokeColor strokeWidth:(unichar)strokeWidth {
    [self removeAttribute:(id)kCTStrokeWidthAttributeName range:self.syz_allRange];
    if (strokeWidth > 0) {
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &strokeWidth);
        [self addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)num range:self.syz_allRange];
    }
    
    [self removeAttribute:(id)kCTStrokeColorAttributeName range:self.syz_allRange];
    if (strokeColor) {
        [self addAttribute:(id)kCTStrokeColorAttributeName value:(id)strokeColor.CGColor range:self.syz_allRange];
    }
}

- (void)syz_addAttributeCharacterSpacing:(unichar)characterSpacing {
    [self syz_addAttributeCharacterSpacing:characterSpacing range:self.syz_allRange];
}

- (void)syz_addAttributeCharacterSpacing:(unichar)characterSpacing range:(NSRange)rang {
    [self removeAttribute:(id)kCTKernAttributeName range:rang];
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &characterSpacing);
    [self addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:rang];
    CFRelease(num);
}

- (void)syz_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment lineSpaceStyle:(CGFloat)linesSpacing paragraphSpaceStyle:(CGFloat)paragraphSpacing lineBreakStyle:(CTLineBreakMode)lineBreakMode {
    [self syz_addAttributeAlignmentStyle:textAlignment
                          lineSpaceStyle:linesSpacing
                     paragraphSpaceStyle:paragraphSpacing
                          lineBreakStyle:lineBreakMode
                                    rang:self.syz_allRange];
}

- (void)syz_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment lineSpaceStyle:(CGFloat)linesSpacing paragraphSpaceStyle:(CGFloat)paragraphSpacing lineBreakStyle:(CTLineBreakMode)lineBreakMode rang:(NSRange)range {
    [self removeAttribute:(id)kCTParagraphStyleAttributeName range:range];
    
    
    //创建文本对齐方式
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment; //指定对齐属性
    alignmentStyle.valueSize = sizeof(textAlignment);
    alignmentStyle.value = &textAlignment;
    
    //创建文本行间距
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(linesSpacing);
    lineSpaceStyle.value = &linesSpacing;
    
    //段落间距
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.value = &paragraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(paragraphSpacing);
    
    //折行模式
    CTParagraphStyleSetting lineBreakStyle;
    lineBreakStyle.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakStyle.value = &lineBreakMode;
    lineBreakStyle.valueSize = sizeof(lineBreakMode);
    
    //创建样式数组
    CTParagraphStyleSetting settings[] = {alignmentStyle,lineSpaceStyle,paragraphSpaceStyle,lineBreakStyle};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    
    [self addAttribute:(id)kCTParagraphStyleAttributeName value:(id)CFBridgingRelease(paragraphStyle) range:range];
}

- (void)syz_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
lineSpaceStyle:(CGFloat)linesSpacing
paragraphSpaceStyle:(CGFloat)paragraphSpacing
lineBreakStyle:(NSLineBreakMode)lineBreakMode {
    [self syz_addAttributeAlignmentStyle2:textAlignment
                           lineSpaceStyle:linesSpacing
                      paragraphSpaceStyle:paragraphSpacing
                           lineBreakStyle:lineBreakMode
                                     rang:self.syz_allRange];
}

- (void)syz_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
lineSpaceStyle:(CGFloat)linesSpacing
paragraphSpaceStyle:(CGFloat)paragraphSpacing
lineBreakStyle:(NSLineBreakMode)lineBreakMode
rang:(NSRange)range {
    [self removeAttribute:NSParagraphStyleAttributeName range:range];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = linesSpacing;
    style.alignment = textAlignment;
    style.lineBreakMode = lineBreakMode;
    style.paragraphSpacing = paragraphSpacing;
    [self syz_addAttribute:NSParagraphStyleAttributeName value:style range:range];
}

@end
