//
//  UIScrollView+ZQRefresh.h
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/27.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ZQRefresh)

/**
 头部刷新
 @param block 回调
*/
- (void)zq_normalHeaderRefreshWithBlock:(void(^)(void))block;



/**
 头部刷新结束
 */
- (void)zq_endNormalHeaderRefresh;



/**
 头部开始刷新
 */
-(void)zq_beginNormalHeaderRefresh;



/**
 底部刷新
 @param block 回调
 */
- (void)zq_normalFooterRefreshWithBlock:(void(^)(void))block;


/**
 底部刷新结束
 */
- (void)zq_endNormalFooterRefresh;



/**
 底部刷新结束
 */
- (void)zq_endNormalFooterRefreshWithNoMoreData;

@property (nonatomic, assign)BOOL footerHiden;

/**
 */
-(void)zq_resetFooterRefresh;


@end

NS_ASSUME_NONNULL_END
