//
//  UIViewController+Load.h
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/16.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZQAdd)

+ (instancetype)controllerFromXIB;

+ (instancetype)controllerFromStoryboard:(NSString *)sbName;

@end
