//
//  ZQShareView.m
//  PursuitNetworkPro
//
//  Created by GTLand on 2018/12/8.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "ZQShareView.h"
#import "UIButton+ImageTitleSpacing.h"

@interface ZQShareView ()

@end

@implementation ZQShareView

- (void)awakeFromNib {
    [super awakeFromNib];
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:UIButton.class]) {
            [b layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:12];
        }
    }
}

- (IBAction)shareWeixin:(id)sender {
    if (self.selectShareBlock) {
        self.selectShareBlock(0);
    }
    [self dismissWithCompletion:nil];
}
- (IBAction)shareQQ:(id)sender {
    if (self.selectShareBlock) {
        self.selectShareBlock(1);
    }
    [self dismissWithCompletion:nil];
}
- (IBAction)shareWeibo:(id)sender {
    if (self.selectShareBlock) {
        self.selectShareBlock(2);
    }
    [self dismissWithCompletion:nil];
}
- (IBAction)cancel:(id)sender {
    [self dismissWithCompletion:nil];
}

@end
