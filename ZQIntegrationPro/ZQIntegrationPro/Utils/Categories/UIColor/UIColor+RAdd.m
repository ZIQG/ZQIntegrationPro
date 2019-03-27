//
//  UIColor+R.m
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/11/19.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "UIColor+RAdd.h"

@implementation UIColor (RAdd)

//获取rgba颜色
UIColor * RGBA(CGFloat r , CGFloat g,CGFloat b ,CGFloat a){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

//获取rgb颜色
UIColor * RGB(CGFloat r , CGFloat g,CGFloat b){
    return RGBA(r, g, b, 1.0);
}

//获取随机色
UIColor * Arc4randomColor(){
    return RGBA(arc4random() % 256,arc4random() % 256,arc4random() % 256,1.0f);
}

// 获取十六进制颜色
UIColor * Hex_colorA(uint32_t rgbValue,CGFloat a){
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)];
}

// 获取十六进制颜色
UIColor * Hex_color(uint32_t rgbValue){
    return Hex_colorA(rgbValue, 1.0);
}

+ (UIColor *)r_navigationBarBgColor {
    return [UIColor colorWithHexString:@"#F6F6F6"];
}

+ (UIColor *)r_navigationBarShadowColor {
    return [UIColor colorWithHexString:@"#EFEFEF"];
}


//黑色遮罩主色
+ (UIColor *)r_maskColor{
    
    return RGBA(0,0,0,0.2);
}

//系统主色
+ (UIColor *)r_systemColor{
    
    return Hex_color(0x417df5);
}

//高亮系统主色
+ (UIColor *)r_systemHLColor{
    
    return Hex_color(0x316dbf);
}

//系统背景色
+ (UIColor *)r_backGroundColor{
    
    return  kRGBColor(245, 245, 245); //Hex_color(0xf5f4f8);
}

//系统黑色
+ (UIColor *)r_blackColor{
    
    return [UIColor colorWithHexString:@"#212121"];
}

//系统灰色
+ (UIColor *)r_grayColor {
    return [UIColor colorWithHexString:@"#F6F6F6"];
}

//边框颜色
+ (UIColor*)r_borderColor{
    
    return Hex_color(0xEDEDED);
}

+ (instancetype)r_colorGradientChangeWithSize:(CGSize)size
                                     direction:(RGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor {
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == RGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case RGradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case RGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case RGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case RGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

@end
