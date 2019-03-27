//
//  UIImage+RAdd.m
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/11/19.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "UIImage+RAdd.h"

@implementation UIImage (RAdd)

+ (instancetype)r_defaultHead {
    return [UIImage imageNamed:@"r_defaultHead"];
}

+ (instancetype)r_defaultPlaceholder {
    UIImage *image =[self imageWithColor:kRGBColor(245, 245, 245)];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

//根据颜色生成纯色图片
+ (UIImage *)r_imageWithColor:(UIColor *)color{
    
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 渲染上下文
    CGContextFillRect(context, rect);
    
    // 从上下文中获取图片
    UIImage * theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

// 根据视图生成视图图片
+ (UIImage*)r_imageWithView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//压缩上传图片到指定字节
+ (NSData *)r_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth{
    NSAssert(maxLength > 0, @"图片的大小必须大于 0");
    NSAssert(maxWidth > 0, @"图片的最大边长必须大于 0");
    if (!image) return nil;
    
    CGFloat compression = 0.9f;
    
    CGSize newSize = [self r_scaleImage:image withLength:maxWidth];
    UIImage *newImage = [self r_resizeImage:image withNewSize:newSize];
    
    NSData *data = UIImageJPEGRepresentation(newImage, compression);
    
    while (data.length > maxLength && compression > 0.01) {
        compression -= 0.02f;
        data = UIImageJPEGRepresentation(newImage, compression);
    }
    return data;
}

//获得指定size的图片
+ (UIImage *)r_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//通过指定图片最长边，获得等比例的图片size
+ (CGSize)r_scaleImage:(UIImage *) image withLength:(CGFloat)imageLength {
    
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > imageLength || height > imageLength){
        
        if (width > height) {
            
            newWidth = imageLength;
            newHeight = newWidth * height / width;
            
        }else if(height > width){
            
            newHeight = imageLength;
            newWidth = newHeight * width / height;
            
        }else{
            
            newWidth = imageLength;
            newHeight = imageLength;
        }
        
    }else{
        return CGSizeMake(width, height);
    }
    
    return CGSizeMake(newWidth, newHeight);
}

- (UIImage *)r_stretchImageWithFLeftCapWidth:(CGFloat)ReftCapWidth

                             fTopCapHeight:(CGFloat)fTopCapHeight

                                 tempWidth:(CGFloat)tempWidth

                             sLeftCapWidth:(CGFloat)sLeftCapWidth

                             sTopCapHeight:(CGFloat)sTopCapHeight

{
    
    UIImage *image1 = [self stretchableImageWithLeftCapWidth:ReftCapWidth topCapHeight:fTopCapHeight];
    
    
    
    CGSize imageSize = self.size;
    
    CGFloat tw = tempWidth / 2.0 + imageSize.width / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw, imageSize.height), NO, [UIScreen mainScreen].scale);
    
    [image1 drawInRect:CGRectMake(0, 0, tw, imageSize.height)];
    
    UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return [image2 stretchableImageWithLeftCapWidth:sLeftCapWidth topCapHeight:sTopCapHeight];
    
}



@end
