//
//  UtilsMacros.h
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/16.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//导航高度(控制器使用)
#define kNavBarHeightForController (self.navigationController.navigationBar.frame.size.height)

//tabbar高度(控制器使用)
#define kTabBarHeightForController self.tabBarController.tabBar.frame.size.height)

#define kScreenRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)


//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//颜色
#define kRGBColor(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kRGBAColor(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// 随机颜色
#define kRandomColor [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]

//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];



#endif /* UtilsMacros_h */
