//
//  ZQBaseTabBarController.m
//  ZQIntegrationPro
//
//  Created by hzq on 2019/3/8.
//  Copyright © 2019 ZQ. All rights reserved.
//

#import "ZQBaseTabBarController.h"
#import "ZQHomePageViewController.h"
#import "ZQMineViewController.h"
#import "ZQBaseNavigationController.h"
#import "RTalkBarViewController.h"

@interface ZQBaseTabBarController ()

@end

@implementation ZQBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAllChildViewController];
    
}


#pragma mark -

-(void)setupAllChildViewController{
    
    ZQHomePageViewController *homeVC = [ZQHomePageViewController controllerFromXIB];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"fl_icon_home" seleceImageName:@"fl_icon_home_sel"];
    
    ZQMineViewController *mineVC = [ZQMineViewController controllerFromXIB];
    [self setupChildViewController:mineVC title:@"我的" imageName:@"fl_icon_mine" seleceImageName:@"fl_icon_mine_sel"];
    RTalkBarViewController *talkVC = [RTalkBarViewController controllerFromXIB];
    [self setupChildViewController:talkVC title:@"说吧" imageName:@"fl_icon_mine" seleceImageName:@"fl_icon_mine_sel"];
    
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    //包装导航控制器
    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRGB:0x0066FF],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    ZQBaseNavigationController *nvc = [[ZQBaseNavigationController alloc]initWithRootViewController:controller];
    
    [self addChildViewController:nvc];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
