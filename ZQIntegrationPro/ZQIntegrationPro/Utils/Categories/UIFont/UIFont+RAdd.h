//
//  UIFont+RAdd.h
//  XKTrackNetWork
//
//  Created by Allen、 LAS on 2018/11/17.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (RAdd)

/**
 获取系统字体大小
 
 @param f 字体大小
 @return UIFont
 */
UIFont * FontOfSize(CGFloat f);

/**
 获取系统加粗字体大小
 
 @param f 字体大小
 @return UIFont
 */
UIFont * BoldFontOfSize(CGFloat f);

/**
 根据字体大小计算单行文本size
 
 @param text 文本
 @param f 字体大小
 @return CGSize
 */
CGSize SizeWithAttributes(NSString * text , UIFont * f);

/**
 根据字体大小计算多行文本size
 
 @param  text       文本
 @return s          最大空间size
 @param  f          字体
 */
CGRect BoundingRectWithFont(NSString * text , CGSize s,UIFont * f);

/**
 根据富文本属性计算多行文本size
 
 @param text       文本
 @return s         最大空间size
 @param attributes 属性
 */
CGRect BoundingRectWithSize(NSString * text , CGSize s,NSDictionary * attributes);


@end

NS_ASSUME_NONNULL_END
