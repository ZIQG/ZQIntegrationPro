//
//  UIColor+RAdd.h
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/11/19.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 渐变方式
 
 - RGradientChangeDirectionLevel:              水平渐变
 - RGradientChangeDirectionVertical:           竖直渐变
 - RGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - RGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, RGradientChangeDirection) {
    RGradientChangeDirectionLevel,
    RGradientChangeDirectionVertical,
    RGradientChangeDirectionUpwardDiagonalLine,
    RGradientChangeDirectionDownDiagonalLine,
};


@interface UIColor (RAdd)


/**
 获取rgba颜色
 
 @param r Red
 @param g Green
 @param b Blue
 @param a alpha
 @return UIColor
 */
UIColor * RGBA(CGFloat r , CGFloat g,CGFloat b ,CGFloat a);

/**
 获取rgb颜色
 
 @param r Red
 @param g Green
 @param b Blue
 @return UIColor
 */
UIColor * RGB(CGFloat r , CGFloat g,CGFloat b);

/**
 获取随机色
 
 @return UIColor
 */
UIColor * Arc4randomColor(void);

/**
 获取十六进制颜色
 
 @param rgbValue 十六进制
 @param a alpha
 @return UIColor
 */
UIColor * Hex_colorA(uint32_t rgbValue,CGFloat a);

/**
 获取十六进制颜色
 
 @param rgbValue 十六进制
 @return UIColor
 */
UIColor * Hex_color(uint32_t rgbValue);

/**
 默认导航栏颜色
 
 @return UIColor
 */
+ (UIColor *)r_navigationBarBgColor;

+ (UIColor *)r_navigationBarShadowColor;

#pragma mark - 系统的

/**
 黑色遮罩主色
 
 @return UIColor
 */
+ (UIColor *)r_maskColor;

/**
 系统主色
 
 @return UIColor
 */
+ (UIColor *)r_systemColor;

/**
 高亮系统主色
 
 @return UIColor
 */
+ (UIColor *)r_systemHLColor;

/**
 系统背景色
 
 @return UIColor
 */
+ (UIColor *)r_backGroundColor;

/**
 系统黑色
 
 @return UIColor
 */
+ (UIColor *)r_blackColor;

/**
 系统黑色
 
 @return UIColor
 */
+ (UIColor *)r_grayColor;

/**
 边框颜色
 
 @return UIColor
 */
+ (UIColor *)r_borderColor;

/**
 创建渐变颜色
 
 @param size       渐变的size
 @param direction  渐变方式
 @param startcolor 开始颜色
 @param endColor   结束颜色
 
 @return 创建的渐变颜色
 */
+ (instancetype)r_colorGradientChangeWithSize:(CGSize)size
                                     direction:(RGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor;


@end

NS_ASSUME_NONNULL_END
