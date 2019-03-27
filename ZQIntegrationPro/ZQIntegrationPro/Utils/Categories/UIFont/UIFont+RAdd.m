//
//  UIFont+RAdd.m
//  XKTrackNetWork
//
//  Created by Allen、 LAS on 2018/11/17.
//  Copyright © 2018年 重楼. All rights reserved.
//

#import "UIFont+RAdd.h"

@implementation UIFont (RAdd)

// 获取系统字体大小
UIFont * FontOfSize(CGFloat f){
    return [UIFont systemFontOfSize:f];
}

//获取系统加粗字体大小
UIFont * BoldFontOfSize(CGFloat f){
    return [UIFont boldSystemFontOfSize:f];
}

// 根据字体大小计算单行文本size
CGSize SizeWithAttributes(NSString * text , UIFont * f){
    return  [text sizeWithAttributes:@{NSFontAttributeName:f}];
}

// 根据字体大小计算多行文本size
CGRect BoundingRectWithFont(NSString * text , CGSize s,UIFont * f){
    return BoundingRectWithSize(text, s, @{NSFontAttributeName:f});
}

CGRect BoundingRectWithSize(NSString * text , CGSize s,NSDictionary * attributes){
    return [text boundingRectWithSize:s options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}


@end
