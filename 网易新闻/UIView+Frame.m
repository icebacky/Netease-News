//
//  UIView+Frame.m
//  彩票
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
#pragma mark - size
// size的get/set方法实现
- (void)setSize:(CGSize)size
{
    CGRect bounds = self.bounds;
    
    bounds.size = size;
    
    self.bounds = bounds;
}
- (CGSize)size
{
    return self.bounds.size;
}

#pragma mark - 中心点x,y
// centerX的get/set方法实现
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

// centerY的get/set方法实现
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark - x,y,width,height
// x的get/set方法实现
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;

    frame.origin.x = x;
    
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

// y的get/set方法实现
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

// width的get/set方法实现
- (void)setWidth:(CGFloat)width
{
    CGRect bounds = self.frame;
    
    bounds.size.width = width;
    
    self.bounds = bounds;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

// height的get/set方法实现
- (void)setHeight:(CGFloat)height
{
    CGRect bounds = self.frame;
    
    bounds.size.height = height;
    
    self.bounds = bounds;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

@end
