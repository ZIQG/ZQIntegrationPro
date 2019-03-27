//
//  NSString+Regex.m
//  RTrackNetWork
//
//  Created by Allen、 LAS on 2018/11/17.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

//确保字符串为安全字符串
NSString * IsSafeString(NSString * str){
    return (str != nil && str.length != 0) ? str : @"";
}

//判断两个字符串是否一致
BOOL IsSameString(NSString * str,NSString * str1){
    return [str isEqualToString:str1];
}

//正则校验
- (BOOL)r_isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

//判断是否为整形：
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

//纯数字
- (BOOL)r_isValidNumber{
    return [self r_isValidateByRegex:@"(/^[0-9]*$/)"];
}

//纯中文
- (BOOL)r_isValidChinese{
    return [self r_isValidateByRegex:@"^[\u4e00-\u9fa5]+$"];
}

//纯英文字符
- (BOOL)r_isValidCharacter{
    return [self r_isValidateByRegex:@"[a-zA-z]"];
}

//有效网址
- (BOOL)r_isValidUrl{
    return [self r_isValidateByRegex:@"^((http)|(https))+:[^\\s]+\\.[^\\s]*$"];
}

//手机号有效性
- (BOOL)r_isMobileNumber{  //简单校验, 纯数字,11位, 且是1开头
    NSString * mobile = IsSafeString(self);
    return (self.isPureInt &&  mobile.length == 11 && IsSameString([mobile substringToIndex:1], @"1"));   
}

//邮箱有效性
- (BOOL)r_isEmailAddress{
    return [self r_isValidateByRegex:@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"] && [self hasSuffix:@".com"];;
}

//简单的身份证有效性
- (BOOL)r_simpleVerifyIdentityCardNum{
    return [self r_isValidateByRegex:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

//车牌号的有效性
- (BOOL)r_isCarNumber{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self r_isValidateByRegex:carRegex];
}

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)r_bankCardluhmCheck{
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

//邮政编码有效性
- (BOOL)r_isValidPostalcode{
    return [self r_isValidateByRegex:@"^[0-8]\\d{5}(?!\\d)$"];
}

//工商税号有效性
- (BOOL)r_isValidTaxNo{
    return [self r_isValidateByRegex:@"[0-9]\\d{13}([0-9]|X)$"];
}

//判断文本是否包含中文
- (BOOL)r_isContainChinese{
    for (NSInteger index = 0; index < [self length]; index ++) {
        int indexValue = [self characterAtIndex:index];
        if (indexValue > 0x4e00 && indexValue < 0x9fff) return YES;
    }
    return NO;
}
@end
