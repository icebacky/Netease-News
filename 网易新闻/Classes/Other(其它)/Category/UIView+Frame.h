//
//  UIView+Frame.h
//  彩票
//
//  Created by 韩啸宇 on 15/10/8.
//  Copyright (c) 2015年 韩啸宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/** size的get/set方法声明 */
@property (nonatomic, assign) CGSize size;

/** 中心点X的get/set方法声明 */
@property (nonatomic, assign) CGFloat centerX;
/** 中心点Y的get/set方法声明 */
@property (nonatomic, assign) CGFloat centerY;

/** X的get/set方法声明 */
@property (nonatomic, assign) CGFloat x;
/** Y的get/set方法声明 */
@property (nonatomic, assign) CGFloat y;
/** Widhth的get/set方法声明 */
@property (nonatomic, assign) CGFloat width;
/** Height的get/set方法声明 */
@property (nonatomic, assign) CGFloat height;
@end
