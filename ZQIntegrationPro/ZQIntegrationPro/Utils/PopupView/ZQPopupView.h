//
//  ZQPopupView.h
//  TourShare_iOS_Seller
//
//  Created by Lying on 2018/4/23.
//  Copyright © 2018年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZQPopupShowCmpletion)(void);
typedef void(^ZQPopupDismissCompletion)(void);

typedef enum : NSUInteger {
    ZQPopupTypeSheet, //由下往上,最终位置在底部
    ZQPopupTypeAlert, //中间，由小变大，最终位置在屏幕中间
    ZQPopupTypeDrop,  //由上往下，最终位置由设置的frame决定
} ZQPopupType;

@interface ZQPopupView : UIView

//遮罩能否点击隐藏
@property (nonatomic, assign) BOOL coverViewUserInteractionEnable;

/**
 设置弹窗1 弹出在window
 @param popupType 弹窗类型,三种 1.由下往上； 2.中间，由小变大；3由上往下
 @param backgroundViewColor 背景遮罩颜色,需要透明度也在颜色这里设置
 @param showCompletion 弹出来的block
 */
- (void)showWithPopupType:(ZQPopupType)popupType
      backgroundViewColor:(UIColor *)backgroundViewColor
           showCompletion:(ZQPopupShowCmpletion)showCompletion;

/**
 设置弹窗2 弹出在指定view
 @param containerView 指定view
 @param popupType 弹窗类型,三种 1.由下往上； 2.中间，由小变大；3由上往下
 @param backgroundViewColor 背景遮罩颜色,需要透明度也在颜色这里设置
 @param showCompletion 弹出来的block
 */
- (void)showWithPopupContainerView:(UIView *)containerView
                         popupType:(ZQPopupType)popupType
               backgroundViewColor:(UIColor *)backgroundViewColor
                    showCompletion:(ZQPopupShowCmpletion)showCompletion;

/**
 消失
 @param dismissCompletion 消失时的block
 */
- (void)dismissWithCompletion:(ZQPopupShowCmpletion)dismissCompletion;

@end
