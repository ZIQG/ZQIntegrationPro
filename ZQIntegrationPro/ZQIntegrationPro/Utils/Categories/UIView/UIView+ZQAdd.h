
//
//  UIView+ZQAdd
//  EAWADA
//
//  Created by Apple on 16/5/11.
//  Copyright © 2016年 xlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZQAdd)

@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor * _Nullable borderColor;

@property (nonatomic) IBInspectable UIColor * _Nullable shadowColor;
@property (nonatomic) IBInspectable CGFloat shadowOpacity;
@property (nonatomic) IBInspectable CGFloat shadowRadius;
@property (nonatomic) IBInspectable CGSize shadowOffset;

///类初始化加载xib
+ (instancetype _Nullable )viewFromXIBWithOwner:(nullable id)owner;
+ (instancetype _Nonnull )viewFromXIBWithOwner:(nullable id)owner frame:(CGRect)frame;

@end
