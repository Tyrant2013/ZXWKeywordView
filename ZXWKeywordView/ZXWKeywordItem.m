//
//  ZXWKeywordItem.m
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWKeywordItem.h"

static CGFloat const kBorderPadding                         = 5.0f;

@implementation ZXWKeywordItem

- (instancetype)initWithValue:(NSString *)val position:(CGPoint)pos {
    if (self = [super init]) {
        [self __initValue:val
                 position:pos
                     size:CGSizeZero
          normalTextColor:[UIColor grayColor]
            normalBGColor:nil
        selectedTextColor:[UIColor greenColor]
          selectedBGColor:nil];
    }
    return self;
}

- (instancetype)initWithValue:(NSString *)val position:(CGPoint)pos size:(CGSize)size {
    if (self = [super init]) {
        [self __initValue:val
                 position:pos
                     size:size
          normalTextColor:[UIColor grayColor]
            normalBGColor:nil
        selectedTextColor:[UIColor greenColor]
          selectedBGColor:nil];
    }
    return self;
}

- (void)__initValue:(NSString *)val
           position:(CGPoint)pos
               size:(CGSize)size
    normalTextColor:(UIColor *)ntColor
      normalBGColor:(UIColor *)nbgColor
  selectedTextColor:(UIColor *)stColor
    selectedBGColor:(UIColor *)sbgColor {
    _value = val;
    UIColor *fontColor = ntColor ? ntColor : [UIColor blackColor];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                            NSForegroundColorAttributeName : fontColor,
                            };
    _attrs = attrs;
    CGSize valSize = CGSizeEqualToSize(size, CGSizeZero) ? [val sizeWithAttributes:attrs] : size;
    _frame = (CGRect){pos, valSize};
    
    [self __initBorderPath];
    
//    _normalTextColor = ntColor;
//    _normalBackgroundColor = nbgColor;
//    _selectedTextColor = stColor;
//    _selectedBackgroundColor = sbgColor;
}

- (void)__initBorderPath {
    CGRect frame = _frame;
    frame.size.width += kBorderPadding * 2;
    frame.size.height += kBorderPadding;
    frame.origin.y -= kBorderPadding / 2;
    frame.origin.x -= kBorderPadding;
    CGFloat radius = CGRectGetHeight(frame) / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius];
    _borderPath = path;
}

- (void)setPostion:(CGPoint)pos {
    _frame.origin.x = pos.x;
    _frame.origin.y = pos.y;
    [self __initBorderPath];
}

//- (void)setSelected:(BOOL)selected {
//    _selected = selected;
//    UIColor *fontColor = selected ? self.selectedTextColor : self.normalTextColor;
//    [self addAttributeName:NSForegroundColorAttributeName value:fontColor];
//}

- (void)addAttributeName:(NSString *)attrName value:(id)value {
    if (value && attrName) {
        NSMutableDictionary *mutableAttrDic = [[NSMutableDictionary alloc] initWithDictionary:_attrs];
        mutableAttrDic[attrName] = value;
        _attrs = [mutableAttrDic copy];
    }
}

@end
