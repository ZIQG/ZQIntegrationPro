//
//  RTalkPublishLimitCell.h
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTalkPublishSwitchCell : UITableViewCell

@property (nonatomic, copy) void(^switchValueChangeBlock)(BOOL on);

@end

@interface RTalkPublishLocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
