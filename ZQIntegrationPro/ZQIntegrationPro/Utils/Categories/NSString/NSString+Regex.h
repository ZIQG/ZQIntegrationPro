//
//  NSString+Regex.h
//  RTrackNetWork
//
//  Created by Allen、 LAS on 2018/11/17.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Regex)

/**
 *  @brief  确保字符串为安全字符串
 *
 *  @return 校验好的字符串
 */
NSString * IsSafeString(NSString * str);

/**
 *  @brief  判断两个字符串是否一致
 *
 *  @return 校验好的字符串
 */
BOOL IsSameString(NSString * str,NSString * str1);

/**
 *  判断是否为整形：
 */
- (BOOL)isPureInt;

/**
 *  判断是否为浮点形：
 */
- (BOOL)isPureFloat;

/**
 *  纯数字
 */
- (BOOL)r_isValidNumber;

/**
 *  纯中文
 */
- (BOOL)r_isValidChinese;

/**
 *  纯英文字符
 */
- (BOOL)r_isValidCharacter;

/**
 *  网址有效性
 */
- (BOOL)r_isValidUrl;

/**
 *  手机号有效性
 */
- (BOOL)r_isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)r_isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)r_simpleVerifyIdentityCardNum;

/**
 *  车牌号的有效性
 */
- (BOOL)r_isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)r_bankCardluhmCheck;

/**
 *  邮政编码
 */
- (BOOL)r_isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)r_isValidTaxNo;

/**
 *  @brief  判断文本中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)r_isContainChinese;


@end

NS_ASSUME_NONNULL_END
