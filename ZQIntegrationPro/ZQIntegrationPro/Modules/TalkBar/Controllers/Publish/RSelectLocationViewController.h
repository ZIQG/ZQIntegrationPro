//
//  RSelectLocationViewController.h
//  Rong518
//
//  Created by hzq on 2019/3/21.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "ZQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSelectLocationViewController : ZQBaseViewController

@property (nonatomic, copy) void(^selectConfirmBlock)(NSString *location);

@end

NS_ASSUME_NONNULL_END
