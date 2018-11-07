//
//  UIView+HYCategory.h
//  HYQMUIBranch
//
//  Created by 徐浩宇 on 2018/8/29.
//  Copyright © 2018年 XuHaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HYCategory)

@property (nonatomic) CGFloat x_hy;
@property (nonatomic) CGFloat y_hy;
@property (nonatomic) CGFloat maxX_hy;  // x + width
@property (nonatomic) CGFloat maxY_hy;  // y + height
@property (nonatomic) CGFloat centerX_hy;
@property (nonatomic) CGFloat centerY_hy;

@property (nonatomic) CGFloat width_hy;
@property (nonatomic) CGFloat height_hy;

@property (nonatomic) CGPoint origin_hy;
@property (nonatomic) CGSize  size_hy;

@end
