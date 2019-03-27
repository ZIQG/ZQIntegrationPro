//
//  NSString+encode.h
//  OuLianWang
//
//  Created by hsmj on 16/9/12.
//  Copyright © 2016年 我连网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

@interface NSString (encode)

//url encodeURL转码
+ (NSString*)encodeURL:(NSString *)string;

+ (NSString *)decodedUrl:(NSString *)str;

@end
