//
//  NSString+Trims.h
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/11/26.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Trims)

/**
 *  @brief  去除前后空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)r_trimmingWhitespace;

/**
 *  @brief 从首到尾去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)r_trimmingWhitespaceAndNewlines;

/**
 *  @brief  去除浮点型数字字符串小数点后最后一个0
 *
 *  @return 校验好的字符串
 */
- (NSString *)r_trimmingNumberLastZero;

/**
 *  @brief  去住空白符和换行符
 *
 *  @return 校验好的字符串
 */
- (NSString *)r_trimmingLineBreak;



@end

NS_ASSUME_NONNULL_END
