//
//  ZXWKeywordView.h
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXWKeywordView;

@protocol ZXWKeywordViewDelegate <NSObject>

- (void)keywordView:(ZXWKeywordView *)keywordView didSelectedAtIndex:(NSUInteger)index;

@end

@interface ZXWKeywordView : UIView

@property (nonatomic, copy) NSArray                         *items;

/// 是否允许多选
@property (nonatomic, assign) BOOL                          allowsMutipleSelection;
/// 只在选中时显示边框
@property (nonatomic, assign) BOOL                          onlyShowBorderOnSelection;
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

- (instancetype)initWithKeywords:(NSArray *)keywords;

@end
