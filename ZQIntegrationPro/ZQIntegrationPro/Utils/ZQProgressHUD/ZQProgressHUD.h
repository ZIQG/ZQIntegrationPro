//
//  ZQProgressHUD.h
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/12/1.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZQProgressHUDMaskType) {
    ZQProgressHUDMaskTypeNone,      //无遮罩，背景View可以响应事件
    ZQProgressHUDMaskTypeClear,     //透明遮罩，背景View无法响应事件
    ZQProgressHUDMaskTypeBlack,     //黑色透明遮罩，背景View无法响应事件
    ZQProgressHUDMaskTypeFullBlack, //黑色透明铺满整个view的遮罩，背景View无法响应事件
};

@interface ZQProgressHUD : NSObject

+ (void)showHUDForView:(UIView *)view;

+ (void)showHUDForView:(UIView *)view maskType:(ZQProgressHUDMaskType)maskType;

+ (void)showHUDForView:(UIView *)view text:(NSString * _Nullable)text;

+ (void)showHUDForView:(UIView *)view text:(NSString * _Nullable)text maskType:(ZQProgressHUDMaskType)maskType;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

+ (void)toastText:(NSString *)text inView:(UIView *)view;

+ (void)toastText:(NSString *)text;

+ (void)toastNetworkError;

@end
