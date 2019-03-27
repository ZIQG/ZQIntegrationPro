//
//  NSString+encode.m
//  OuLianWang
//
//  Created by hsmj on 16/9/12.
//  Copyright © 2016年 我连网. All rights reserved.
//

#import "NSString+encode.h"

@implementation NSString (encode)

//url encodeURL转码
+ (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
}

+ (NSString *)decodedUrl:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    if (decodedString) {
        return decodedString;
    }
    return @"";
}

@end
