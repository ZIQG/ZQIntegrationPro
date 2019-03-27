//
//  RTalkPublishPicsCell.h
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTalkPublishPicsCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, copy) void(^selectImageBlock)(void);

@end

NS_ASSUME_NONNULL_END
