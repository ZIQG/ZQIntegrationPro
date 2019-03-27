//
//  UITableView+Category.m
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/11/17.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "UITableView+RAdd.h"

@implementation UITableView (RAdd)

- (void)registerCellNib:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle bundleForClass:NSClassFromString(nibName)]] forCellReuseIdentifier:nibName];
}

- (void)registerXIBCellFromClass:(Class)r_class {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(r_class) bundle:[NSBundle bundleForClass:r_class]] forCellReuseIdentifier:NSStringFromClass(r_class)];
}

@end
