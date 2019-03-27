//
//  RLocationSearchResultViewController.h
//  Rong518
//
//  Created by hzq on 2019/3/22.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "ZQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^RResultSelectedBlock)(NSString *result);

@interface RLocationSearchResultViewController : ZQBaseViewController

@property (nonatomic, weak) UISearchController *searchController;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) RResultSelectedBlock itemSeletectedBlock;

@end

NS_ASSUME_NONNULL_END
