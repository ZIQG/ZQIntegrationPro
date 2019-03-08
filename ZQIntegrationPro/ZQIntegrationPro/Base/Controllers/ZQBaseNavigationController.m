//
//  ZQBaseNavigationController.m
//  ZQIntegrationPro
//
//  Created by hzq on 2019/3/8.
//  Copyright © 2019 ZQ. All rights reserved.
//

#import "ZQBaseNavigationController.h"

@interface ZQBaseNavigationController ()

@end

@implementation ZQBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18], NSForegroundColorAttributeName : [UIColor blackColor]}];

    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarPosition:(UIBarPositionAny) barMetrics:(UIBarMetricsDefault)];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithRGB:0xEEEEEE]]];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


//拦截所有push的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    if (self.viewControllers.count > 0) { //设置返回按钮
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.viewControllers.lastObject.navigationItem.backBarButtonItem = backItem;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
