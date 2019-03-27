//
//  NSString+Trims.m
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/11/26.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "NSString+Trims.h"

@implementation NSString (Trims)

// 去除空格后的字符串
- (NSString *)r_trimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//去除字符串与空行的字符串
- (NSString *)r_trimmingWhitespaceAndNewlines{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//去除浮点型数字字符串小数点后最后一个0
- (NSString *)r_trimmingNumberLastZero{
    NSString * trim = IsSafeString(self).r_trimmingWhitespaceAndNewlines;
    if (trim.length > 1) {
        if ([trim rangeOfString:@"."].location != NSNotFound) { // 包含小数点
            NSRange lastRange = NSMakeRange(trim.length - 1, 1);
            //最后一位是小数点, 或是小数点的0
            if ([[trim substringWithRange:lastRange] isEqualToString:@"0"] || [[trim substringWithRange:lastRange] isEqualToString:@"."] ) {
                trim = [trim substringWithRange:NSMakeRange(0, trim.length - 1)];
            }
        }
    }
    return trim;
}

//去住空白符和换行符
- (NSString *)r_trimmingLineBreak{
    NSString * trim = IsSafeString(self).r_trimmingWhitespaceAndNewlines;
    trim = [trim stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    trim = [trim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return IsSafeString(trim);
}
@end
