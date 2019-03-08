//
//  UIViewController+Load.m
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/16.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "UIViewController+ZQAdd.h"

@implementation UIViewController (ZQAdd)

+ (instancetype)controllerFromXIB {
    UIViewController * vc = [[self alloc]initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:self.class]];
    return vc;
}

+ (instancetype)controllerFromStoryboard:(NSString *)sbName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle bundleForClass:self.class]];
    id viewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    return viewController;
}

@end
