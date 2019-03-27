//
//  RTalkBarPicCell.m
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkBarPicCell.h"

@interface RTalkBarPicCell ()

@end

@implementation RTalkBarPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl {
    if ([imageUrl isKindOfClass:NSNull.class]) {
        return;
    }
    if (imageUrl&&imageUrl.length==0) {
        self.imageView.image = [UIImage r_defaultPlaceholder];
        return;
    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage r_defaultPlaceholder]];
}

@end
