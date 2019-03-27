//
//  RTalkDetailCommentCell.h
//  Rong518
//
//  Created by hzq on 2019/3/26.
//  Copyright © 2019 hzq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTalkDetailCommentCell : UITableViewCell

@property (nonatomic, copy) void(^replyClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
