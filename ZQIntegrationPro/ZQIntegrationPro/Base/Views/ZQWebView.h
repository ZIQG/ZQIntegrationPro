//
//  ZQWebView.h
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/12/4.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQWebView : WKWebView
@property (nonatomic,copy)void (^wkWebprogressHandler)(CGFloat progress);
@end

NS_ASSUME_NONNULL_END
