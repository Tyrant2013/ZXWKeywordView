//
//  ZXWKeywordView.h
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWKeywordView : UIView

@property (nonatomic, copy) NSArray                         *items;

- (instancetype)initWithKeywords:(NSArray *)keywords;

@end
