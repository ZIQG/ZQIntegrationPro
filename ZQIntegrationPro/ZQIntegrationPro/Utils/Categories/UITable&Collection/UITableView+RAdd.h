//
//  UITableView+Category.h
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/17.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RAdd)

- (void)registerCellNib:(NSString *)nibName;

- (void)registerXIBCellFromClass:(Class)r_class;

@end
