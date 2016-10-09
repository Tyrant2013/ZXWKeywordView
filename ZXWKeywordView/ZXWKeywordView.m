//
//  ZXWKeywordView.m
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWKeywordView.h"
#import "ZXWKeywordItem.h"

static CGFloat const kMargin                                = 20.0f;
//static CGFloat const kBorderPadding                         = 5.0f;

@implementation ZXWKeywordView

- (instancetype)initWithKeywords:(NSArray *)keywords {
    if (self = [super initWithFrame:(CGRect){0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 300}]) {
        CGFloat totalWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * kMargin;
        CGFloat totalHeight = 2 * kMargin;
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:keywords.count];
        CGPoint pos = CGPointZero;
        pos.x += kMargin;
        pos.y += kMargin;
        for (NSString *keyword in keywords) {
            ZXWKeywordItem *item = [[ZXWKeywordItem alloc] initWithValue:keyword position:pos];
            item.borderColor = [UIColor yellowColor];
            if (item.frame.size.width + pos.x > totalWidth) {
                pos.x = kMargin;
                pos.y += kMargin + item.frame.size.height;
                [item setPostion:pos];
            }
            [items addObject:item];
            totalHeight += item.frame.size.height;
            pos.x += item.frame.size.width + kMargin;
        }
        _items = [items copy];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    for (ZXWKeywordItem *item in self.items) {
        [item.value drawInRect:item.frame withAttributes:item.attrs];
        if (item.selected) {
            CGContextAddPath(contextRef, item.borderPath.CGPath);
            if (item.borderColor) {
                [item.borderColor setStroke];
                CGContextStrokePath(contextRef);
            }
            if (item.selectedBackgroundColor) {
                [item.selectedBackgroundColor setFill];
                CGContextFillPath(contextRef);
            }
        }
        else {
            CGContextAddPath(contextRef, item.borderPath.CGPath);
            if (item.borderColor && !item.onlyShowBorderOnSelection) {
                [item.borderColor setStroke];
                CGContextStrokePath(contextRef);
            }
            if (item.normalBackgroundColor) {
                [item.normalTextColor setFill];
                CGContextFillPath(contextRef);
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    [self __checkTouchWithPoint:touchPoint];
    [super touchesEnded:touches withEvent:event];
}

- (void)__checkTouchWithPoint:(CGPoint)point {
    BOOL touchedItem = NO;
    for (ZXWKeywordItem *item in self.items) {
        item.selected = NO;
        if (CGRectContainsPoint(item.frame, point)) {
            item.selected = YES;
            touchedItem = YES;
        }
    }
    if (touchedItem) {
        [self setNeedsDisplay];
    }
}

- (void)__drawSelectedForItem:(ZXWKeywordItem *)item {
    
}

@end
