//
//  UIImage+RAdd.h
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/11/19.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (RAdd)

+ (instancetype)r_defaultHead;

+ (instancetype)r_defaultPlaceholder;

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)r_imageWithColor:(UIColor *)color;

/**
 *  @brief  根据视图生成视图图片
 *
 *  @param view 对象视图
 *
 *  @return 图片
 */
+ (UIImage*)r_imageWithView:(UIView*)view;

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)r_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;


/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)r_resizeImage:(UIImage *)image withNewSize:(CGSize) newSize;


/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)r_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;


/**
 
 *  图片左右拉伸
 
 *  ReftCapWidth:  第一次拉伸的left点
 
 *  fTopCapHeight:  第一次拉伸的top点
 
 *  tempWidth:      图片最后要展示的宽度
 
 *  sLeftCapWidth:  第二次拉伸的left点
 
 *  sTopCapHeight:  第二次拉伸的top点
 
 */

- (UIImage *)r_stretchImageWithFLeftCapWidth:(CGFloat)ReftCapWidth

                             fTopCapHeight:(CGFloat)fTopCapHeight

                                 tempWidth:(CGFloat)tempWidth

                             sLeftCapWidth:(CGFloat)sLeftCapWidth

                             sTopCapHeight:(CGFloat)sTopCapHeight;
@end

NS_ASSUME_NONNULL_END
