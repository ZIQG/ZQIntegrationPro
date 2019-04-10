//
//  ZZCustomCycleView.h
//  Rong518
//
//  Created by hzq on 2019/3/22.
//  Copyright © 2019 hzq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZZCycleType) {
    ZZCycleTypeVertical,
    ZZCycleTypeHorizontal,
};

@class ZZCustomCycleView;

@protocol ZZCustomCycleViewDelegate <NSObject>

@optional
- (void)cycleSetupDataWithCustomView:(UIView *)customView index:(NSInteger)index;//配置数据

- (UIView *)cycleScrollCustomView;//配置需要轮播的视图

- (void)cycleScrollDidClickItemWithIndex:(NSInteger )index;//点击事件

@end

@interface ZZCustomCycleView : UIView

/** 滚动方向 */
@property (nonatomic, assign) ZZCycleType cycleType;

/** 设置滚动时间间隔(默认 3s) */
@property (nonatomic, assign) CGFloat timeInterval;

@property(nonatomic, assign) NSInteger dataCount;

@property (nonatomic, weak) id<ZZCustomCycleViewDelegate> delegate;

@end

