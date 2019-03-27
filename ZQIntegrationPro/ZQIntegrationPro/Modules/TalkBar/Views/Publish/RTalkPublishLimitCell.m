//
//  RTalkPublishLimitCell.m
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkPublishLimitCell.h"

@implementation RTalkPublishSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)switchChange:(UISwitch *)sender {
    if (self.switchValueChangeBlock) {
        self.switchValueChangeBlock(sender.on);
    }
 }

@end

@implementation RTalkPublishLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
