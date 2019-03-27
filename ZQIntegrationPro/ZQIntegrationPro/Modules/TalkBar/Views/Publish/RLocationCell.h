//
//  RLocationCell.h
//  Rong518
//
//  Created by hzq on 2019/3/22.
//  Copyright © 2019 hzq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RLocationEntity;

NS_ASSUME_NONNULL_BEGIN

@interface RLocationCell : UITableViewCell
@property (nonatomic, strong) RLocationEntity *entity;
@end

NS_ASSUME_NONNULL_END
