//
//  ZQProgressHUD.m
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/12/1.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "ZQProgressHUD.h"
#import "MBProgressHUD.h"

@implementation ZQProgressHUD

+ (void)showHUD {
    [ZQProgressHUD showHUDForView:nil text:nil maskType:ZQProgressHUDMaskTypeClear];
}

+ (void)showHUDForView:(UIView *)view {
    [ZQProgressHUD showHUDForView:view text:nil maskType:ZQProgressHUDMaskTypeClear];
}

+ (void)showHUDForView:(UIView *)view maskType:(ZQProgressHUDMaskType)maskType {
    [ZQProgressHUD showHUDForView:view text:nil maskType:maskType];
}

+ (void)showHUDForView:(UIView *)view text:(NSString * _Nullable)text {
    [ZQProgressHUD showHUDForView:view text:text maskType:ZQProgressHUDMaskTypeClear];
}

+ (void)showHUDForView:(UIView *)view text:(NSString * _Nullable)text maskType:(ZQProgressHUDMaskType)maskType {
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *HUD = [[[self alloc] init] configureHUDWithView:view];
    HUD.mode = MBProgressHUDModeIndeterminate;
    if (text.length>0) {
        HUD.label.text = text;
    }
    
    
    switch (maskType) {
        case ZQProgressHUDMaskTypeNone:
            HUD.userInteractionEnabled = NO;
            break;
            
        case ZQProgressHUDMaskTypeClear:
            HUD.userInteractionEnabled = YES;
            break;
            
        case ZQProgressHUDMaskTypeBlack:
        case ZQProgressHUDMaskTypeFullBlack:
            HUD.userInteractionEnabled = YES;
            HUD.backgroundView.color = [UIColor blackColor];
            HUD.backgroundView.alpha = 0.3;
            break;
    }
    
    if ((maskType != ZQProgressHUDMaskTypeNone) && [view isKindOfClass:[UIScrollView class]]) {
        view.userInteractionEnabled = NO;
    }
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
      [MBProgressHUD hideHUDForView:view animated:YES];
}


+ (void)toastText:(NSString *)text inView:(UIView *)view {
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *HUD = [[[self alloc] init] configureHUDWithView:view];
    HUD.userInteractionEnabled = NO;
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.text = text;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:15];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [ZQProgressHUD hideHUDForView:view];
    });
}

+ (void)toastText:(NSString *)text {
    [self toastText:text inView:nil];
}

+ (void)toastNetworkError {
    [self toastText:@"您的网络开小差了，\n请稍后重试！" inView:nil];
}

#pragma mark - Private Methods

- (MBProgressHUD *)configureHUDWithView:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.animationType = MBProgressHUDAnimationZoom;
    
    return HUD;
}

@end

