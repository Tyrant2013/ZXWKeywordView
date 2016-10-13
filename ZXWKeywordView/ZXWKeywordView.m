//
//  ZXWKeywordView.m
//  ZXWKeywordView
//
//  Created by 庄晓伟 on 16/10/9.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWKeywordView.h"
#import "ZXWKeywordItem.h"

static CGFloat const kMargin                                            = 10.0f;
static CGFloat const kLineSpace                                         = 15.0f;
static CGFloat const kItemSpace                                         = 15.0f;

@implementation ZXWKeywordView

- (instancetype)initWithKeywords:(NSArray *)keywords {
    if (self = [super initWithFrame:(CGRect){0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 300}]) {
        [self setupColor];
        _numberPerLine = 3;
        [self configKeywords:keywords];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _numberPerLine = 3;
    [self setupColor];
}

- (void)setupColor {
    self.normalTextColor = [UIColor whiteColor];
    self.normalBackgroundColor = nil;
    self.selectedTextColor = [UIColor greenColor];
    self.selectedBackgroundColor = nil;
}

- (void)configKeywords:(NSArray *)keywords {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:keywords.count];
    for (NSString *keyword in keywords) {
        /// 不固定长度
        ZXWKeywordItem *item = [[ZXWKeywordItem alloc] initWithValue:keyword position:CGPointZero];
        /// 固定长度和宽度
        //            ALKeywordItem *item = [[ALKeywordItem alloc] initWithValue:keyword position:pos size:(CGSize){60, 20}];
        [items addObject:item];
    }
    
    _items = [items copy];
    
    if (self.items.count > 0) {
        [self resizeText];
    }
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [self resizeText];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    for (ZXWKeywordItem *item in self.items) {
        CGContextSaveGState(contextRef);
        [item.value drawWithRect:item.frame
                         options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                      attributes:item.attrs
                         context:NULL];
        if (item.selected) {
            CGContextAddPath(contextRef, item.borderPath.CGPath);
            if (self.borderColor) {
                [self.borderColor setStroke];
                CGContextStrokePath(contextRef);
            }
            if (self.selectedBackgroundColor) {
                [self.selectedBackgroundColor setFill];
                CGContextFillPath(contextRef);
            }
        }
        else {
            CGContextAddPath(contextRef, item.borderPath.CGPath);
            if (self.borderColor && !self.onlyShowBorderOnSelection) {
                [self.borderColor setStroke];
                CGContextStrokePath(contextRef);
            }
            if (self.normalBackgroundColor) {
                [self.normalTextColor setFill];
                CGContextFillPath(contextRef);
            }
        }
        CGContextRestoreGState(contextRef);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    [self __checkTouchWithPoint:touchPoint];
    [super touchesEnded:touches withEvent:event];
}

- (void)__checkTouchWithPoint:(CGPoint)point {
    BOOL touchedItem = NO;
    NSUInteger index = 0;
    for (ZXWKeywordItem *item in self.items) {
        item.selected = NO;
        if (CGRectContainsPoint(item.frame, point)) {
            item.selected = YES;
            touchedItem = YES;
            if ([self.delegate respondsToSelector:@selector(keywordView:didSelectedAtIndex:value:)]) {
                [self.delegate keywordView:self didSelectedAtIndex:index value:item.value];
            }
        }
        UIColor *fontColor = item.selected ? self.selectedTextColor : self.normalTextColor;
        [item addAttributeName:NSForegroundColorAttributeName value:fontColor];
        ++index;
    }
    if (touchedItem) {
        [self setNeedsDisplay];
    }
}

- (NSDictionary *)calculateMarginPerLine {
    CGFloat placeWidth = CGRectGetWidth(self.bounds);
    CGFloat totalWidth = placeWidth - 2 * kMargin;
    __block CGPoint pos = (CGPoint){kMargin, kMargin};
    NSMutableDictionary *marginPerLine = [NSMutableDictionary dictionary];
    __block NSUInteger line = 0;
    NSMutableArray *lineItems = [NSMutableArray array];
    
    void (^calculateMargin)() = ^ {
        __block CGFloat width = 0.0f;
        [lineItems enumerateObjectsUsingBlock:^(ZXWKeywordItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            width += CGRectGetWidth(obj.frame);
        }];
        if (lineItems.count - 1 > 0) {
            marginPerLine[@(line)] = @((totalWidth - width) / (lineItems.count - 1));
        }
        else {
            marginPerLine[@(line)] = @(kItemSpace);
        }
        ++line;
        [lineItems removeAllObjects];
        pos.x = kMargin;
    };
    
    [self.items enumerateObjectsUsingBlock:^(ZXWKeywordItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (lineItems.count < self.numberPerLine) {
            if (pos.x + CGRectGetWidth(obj.frame) > placeWidth) {
                calculateMargin();
            }
        }
        else {
            calculateMargin();
        }
        [lineItems addObject:obj];
        pos.x += CGRectGetWidth(obj.frame) + kItemSpace;
    }];
    if (lineItems.count > 0) {
        calculateMargin();
    }
    return [marginPerLine copy];
}

- (void)resizeText {
    CGFloat placeWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat maxWidth = placeWidth - 2 * kMargin;
    CGFloat realHeight = 2 * kMargin + CGRectGetHeight(self.items.firstObject.frame);
    NSDictionary *marginPerLine = [self calculateMarginPerLine];
    NSUInteger line = 0;
    CGPoint pos = (CGPoint){kMargin, kMargin};
    for (ZXWKeywordItem *item in self.items) {
        if (CGRectGetWidth(item.frame) > maxWidth) {
            [item resizeWidth:maxWidth];
        }
        if (CGRectGetWidth(item.frame) + pos.x > placeWidth) {
            pos.x = kMargin;
            pos.y += kLineSpace + CGRectGetHeight(item.frame);
            realHeight += CGRectGetHeight(item.frame) + kLineSpace;
            ++line;
        }
        [item setPostion:pos];
        pos.x += CGRectGetWidth(item.frame) + [marginPerLine[@(line)] floatValue];
    }
    _realHeight = realHeight;
    if (self.heightConstraint) {
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0f
                                                                   constant:realHeight];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:height];
        self.heightConstraint = height;
    }
    else {
        self.heightConstraint.constant = realHeight;
    }
}

@end
