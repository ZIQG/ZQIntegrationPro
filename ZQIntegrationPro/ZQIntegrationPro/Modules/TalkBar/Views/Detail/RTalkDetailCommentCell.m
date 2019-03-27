//
//  RTalkDetailCommentCell.m
//  Rong518
//
//  Created by hzq on 2019/3/26.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkDetailCommentCell.h"

@interface RTalkDetailCommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *replyView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation RTalkDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)replyBtnClick:(UIButton *)sender {
    
    if (self.replyClickBlock) {
        self.replyClickBlock();
    }
    
}

@end
