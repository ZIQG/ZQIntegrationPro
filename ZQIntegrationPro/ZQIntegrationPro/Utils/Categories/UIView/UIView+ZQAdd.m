//
//  UIView+ZQAdd.m
//  EAWADA
//
//  Created by hzq on 16/5/11.
//  Copyright © 2018年 hzq. All rights reserved.
//

#import "UIView+ZQAdd.h"


@implementation UIView (ZQAdd)

- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, @selector(borderColor));
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)shadowColor {
    return objc_getAssociatedObject(self, @selector(shadowColor));
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (CGFloat)shadowOpacity {
    return [objc_getAssociatedObject(self, @selector(shadowOpacity)) floatValue];
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowRadius {
    return [objc_getAssociatedObject(self, @selector(shadowRadius)) floatValue];
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGSize)shadowOffset {
    return [objc_getAssociatedObject(self, @selector(shadowOffset)) CGSizeValue];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}


+ (instancetype)viewFromXIBWithOwner:(nullable id)owner {
   return [[[NSBundle bundleForClass:self.class] loadNibNamed:NSStringFromClass(self.class) owner:owner options:nil] firstObject];
}

+ (instancetype)viewFromXIBWithOwner:(nullable id)owner frame:(CGRect)frame {
    UIView * view = [self viewFromXIBWithOwner:owner];
    view.frame = frame;
    return view;
}


@end

