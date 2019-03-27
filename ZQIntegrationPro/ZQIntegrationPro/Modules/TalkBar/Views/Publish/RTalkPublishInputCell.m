
//
//  RTalkPublishInputCell.m
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkPublishInputCell.h"

@interface RTalkPublishInputCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@end

@implementation RTalkPublishInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.text.length > 0;
    if (self.textViewChangeBlock) {
        self.textViewChangeBlock(textView.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
