//
//  UIView+Frame.m
//  RuntimeBase
//
//  Created by 杨小雨 on 2017/2/13.
//  Copyright © 2017年 杨小雨. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)hy_x {
    return self.frame.origin.x;
}

-(CGFloat)hy_y {
    return self.frame.origin.y;
}

- (CGFloat)hy_width {
    return self.frame.size.width;
}

- (CGFloat)hy_height {
    return  self.frame.size.height;
}

- (CGFloat)hy_centerX {
    return self.center.x;
}

- (CGFloat)hy_centerY {
    return self.center.y;
}

- (void)setHy_x:(CGFloat)hy_x {
    CGRect frame = self.frame;
    frame.origin.x = hy_x;
    self.frame = frame;
}

- (void)setHy_y:(CGFloat)hy_y {
    CGRect frame = self.frame;
    frame.origin.y = hy_y;
    self.frame = frame;
}

- (void)setHy_width:(CGFloat)hy_width {
    CGRect frame = self.frame;
    frame.size.width = hy_width;
    self.frame = frame;
}

- (void)setHy_height:(CGFloat)hy_height {
    CGRect frame = self.frame;
    frame.size.height = hy_height;
    self.frame = frame;
}

- (void)setHy_centerX:(CGFloat)hy_centerX {
    CGPoint center = self.center;
    center.x = hy_centerX;
    self.center = center;
}

- (void)setHy_centerY:(CGFloat)hy_centerY {
    CGPoint center = self.center;
    center.y = hy_centerY;
    self.center = center;
}
@end
