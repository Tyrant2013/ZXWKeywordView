//
//  ZXWKeywordItem.m
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWKeywordItem.h"

@implementation ZXWKeywordItem

- (instancetype)initWithValue:(NSString *)val position:(CGPoint)pos {
    if (self = [super init]) {
        _value = val;
        
        NSDictionary *attrs = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                NSForegroundColorAttributeName : [UIColor whiteColor],
                                };
        _attrs = attrs;
        CGSize size = [val sizeWithAttributes:attrs];
        _frame = (CGRect){pos, size};
    }
    return self;
}

- (void)setPostion:(CGPoint)pos {
    _frame.origin.x = pos.x;
    _frame.origin.y = pos.y;
}

@end
