//
//  UIView+HYCategory.m
//  HYQMUIBranch
//
//  Created by 徐浩宇 on 2018/8/29.
//  Copyright © 2018年 XuHaoyu. All rights reserved.
//

#import "UIView+HYCategory.h"

@implementation UIView (HYCategory)
//x
- (CGFloat)x_hy {
    return self.frame.origin.x;
}
- (void)setX_hy:(CGFloat)x_hy {
    CGRect frame = self.frame;
    frame.origin.x = x_hy;
    self.frame = frame;
}

//y
- (CGFloat)y_hy {
    return self.frame.origin.y;
}
- (void)setY_hy:(CGFloat)y_hy {
    CGRect frame = self.frame;
    frame.origin.y = y_hy;
    self.frame = frame;
}

//x+width
- (CGFloat)maxX_hy {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setMaxX_hy:(CGFloat)maxX_hy {
    CGRect frame = self.frame;
    frame.origin.x = maxX_hy - frame.size.width;
    self.frame = frame;
}

//y+height
- (CGFloat)maxY_hy {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setMaxY_hy:(CGFloat)maxY_hy {
    CGRect frame = self.frame;
    frame.origin.y = maxY_hy - frame.size.height;
    self.frame = frame;
}

//centerX
- (CGFloat)centerX_hy {
    return self.x_hy + self.width_hy * 0.5;
}
- (void)setCenterX_hy:(CGFloat)centerX_hy {
    self.x_hy = centerX_hy - self.width_hy * 0.5;
}

//centerY
- (CGFloat)centerY_hy {
    return self.y_hy + self.height_hy * 0.5;
}
- (void)setCenterY_hy:(CGFloat)centerY_hy {
    self.y_hy = centerY_hy - self.height_hy * 0.5;
}

//width
- (CGFloat)width_hy {
    return self.frame.size.width;
}
- (void)setWidth_hy:(CGFloat)width_hy {
    CGRect frame = self.frame;
    frame.size.width = width_hy;
    self.frame = frame;
}

//height
- (CGFloat)height_hy {
    return self.frame.size.height;
}
- (void)setHeight_hy:(CGFloat)height_hy {
    CGRect frame = self.frame;
    frame.size.height = height_hy;
    self.frame = frame;
}

//origin
- (CGPoint)origin_hy {
    return self.frame.origin;
}
- (void)setOrigin_hy:(CGPoint)origin_hy {
    CGRect frame = self.frame;
    frame.origin = origin_hy;
    self.frame = frame;
}

//size
- (CGSize)size_hy {
    return self.frame.size;
}
- (void)setSize_hy:(CGSize)size_hy {
    CGRect frame = self.frame;
    frame.size = size_hy;
    self.frame = frame;
}




@end
