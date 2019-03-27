//
//  ZQShareView.h
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/12/8.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "ZQPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZQShareView : ZQPopupView

@property (nonatomic, copy) void(^selectShareBlock)(NSInteger selectIndex);

@end

NS_ASSUME_NONNULL_END
