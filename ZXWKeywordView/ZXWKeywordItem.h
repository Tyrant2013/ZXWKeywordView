//
//  ZXWKeywordItem.h
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXWKeywordItem : NSObject

/// 显示的文本
@property (nonatomic, copy, readonly) NSString              *value;
/// 位置，大小
@property (nonatomic, assign, readonly) CGRect              frame;
/// 边框
@property (nonatomic, strong, readonly) UIBezierPath        *borderPath;
/// 显示属性
@property (nonatomic, copy, readonly) NSDictionary          *attrs;

/// 是否允许多选
@property (nonatomic, assign) BOOL                          allowsMutipleSelection;
/// 只在选中时显示边框
@property (nonatomic, assign) BOOL                          onlyShowBorderOnSelection;
/// 是否选中
@property (nonatomic, assign) BOOL                          selected;
/// 未选中时文本色
@property (nonatomic, strong) UIColor                       *normalTextColor;
/// 未选中时的背景色
@property (nonatomic, strong) UIColor                       *normalBackgroundColor;
/// 边框颜色
@property (nonatomic, strong) UIColor                       *borderColor;
/// 选中时的文本色
@property (nonatomic, strong) UIColor                       *selectedTextColor;
/// 选中时的背景色
@property (nonatomic, strong) UIColor                       *selectedBackgroundColor;


/**
 初始化方法

 @param val 需要显示的文本
 @param pos 显示的位置

 @return ZXWKeywordItem 对象
 */
- (instancetype)initWithValue:(NSString *)val position:(CGPoint)pos;

/**
 初始化方法，可以指定文本杠的大小，超出部分隐藏

 @param val  需要显示的文本
 @param pos  显示的位置
 @param size 显示大小，为CGSizeZero时表示不限制大小

 @return ZXWKeywordItem 对象
 */
- (instancetype)initWithValue:(NSString *)val position:(CGPoint)pos size:(CGSize)size;


/**
 设置显示的位置

 @param pos 新的显示位置
 */
- (void)setPostion:(CGPoint)pos;


/**
 添加文本设置

 @param attrName 属性名
 @param value    属性值
 */
- (void)addAttributeName:(NSString *)attrName value:(id)value;

@end
