//
//  UIScrollView+ZQRefresh.m
//  PursuitNetworkPro
//
//  Created by hzq on 2018/11/27.
//  Copyright © 2018年 zq. All rights reserved.
//

#import "UIScrollView+ZQRefresh.h"
#import "MJRefresh.h"

@interface ZQRefreshNormalHeader : MJRefreshNormalHeader

@end

@implementation ZQRefreshNormalHeader

- (void)prepare {
    [super prepare];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"获取数据中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"再下拉一点点就可以刷新了" forState:MJRefreshStateIdle];
}

//如果需要自己重新布局子控件
- (void)placeSubviews {
    [super placeSubviews];
}

@end

@interface ZQRefreshNormalFooter : MJRefreshAutoNormalFooter

@end

@implementation ZQRefreshNormalFooter

- (void)prepare {
    [super prepare];
    
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"获取数据中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"再上拉一点点就可以刷新了" forState:MJRefreshStateIdle];
    
}

//如果需要自己重新布局子控件
- (void)placeSubviews {
    [super placeSubviews];
}

@end

@interface ZQRefreshBackNormalFooter : MJRefreshBackNormalFooter

@end

@implementation ZQRefreshBackNormalFooter

- (void)prepare {
    [super prepare];
    
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"获取数据中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"再上拉一点点就可以刷新了" forState:MJRefreshStateIdle];
    
}

//如果需要自己重新布局子控件
- (void)placeSubviews {
    [super placeSubviews];
}

@end

@implementation UIScrollView (ZQRefresh)

/**
 头部刷新
 @param block 回调
 */
- (void)zq_normalHeaderRefreshWithBlock:(void(^)(void))block {
    __weak typeof(self) weakSelf = self;
    self.mj_header = [ZQRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            weakSelf.userInteractionEnabled = NO;
            block();
        }
    }];
    [self.mj_footer resetNoMoreData];
}



/**
 头部刷新结束
 */
- (void)zq_endNormalHeaderRefresh {
    self.userInteractionEnabled = YES;
    [self.mj_header endRefreshing];
}



/**
 头部开始刷新
 */
-(void)zq_beginNormalHeaderRefresh {
    [self.mj_header beginRefreshing];
    [self.mj_footer resetNoMoreData];
}

/**
 底部刷新
 @param block 回调
 */
- (void)zq_normalFooterRefreshWithBlock:(void(^)(void))block {
    __weak typeof(self) weakSelf = self;
    self.mj_footer = [ZQRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            weakSelf.userInteractionEnabled = NO;
            block();
        }
    }];
}

/**
 底部刷新结束
 */
- (void)zq_endNormalFooterRefresh {
    self.userInteractionEnabled = YES;
    [self.mj_footer endRefreshing];
}

/**
 底部刷新结束
 */
- (void)zq_endNormalFooterRefreshWithNoMoreData {
    self.userInteractionEnabled = YES;
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (BOOL)footerHiden {
    return self.mj_footer.hidden;
}

- (void)setFooterHiden:(BOOL)footerHiden {
    self.mj_footer.hidden = footerHiden;
}

/**
 */
-(void)zq_resetFooterRefresh {
    [self.mj_footer resetNoMoreData];
}

@end
