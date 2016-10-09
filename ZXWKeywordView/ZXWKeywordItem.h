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

@property (nonatomic, copy) NSString                        *value;
@property (nonatomic, assign) CGRect                        frame;
@property (nonatomic, copy) NSDictionary                    *attrs;
@property (nonatomic, assign) BOOL                          selected;

- (instancetype)initWithValue:(NSString *)val position:(CGPoint)pos;
- (void)setPostion:(CGPoint)pos;

@end
