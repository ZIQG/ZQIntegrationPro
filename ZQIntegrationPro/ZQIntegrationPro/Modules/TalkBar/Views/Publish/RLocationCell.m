//
//  RLocationCell.m
//  Rong518
//
//  Created by hzq on 2019/3/22.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RLocationCell.h"
#import "RLocationEntity.h"

@interface RLocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerConstraint;

@end

@implementation RLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.checkBtn.selected = selected;
    self.nameLabel.textColor = selected ? [UIColor colorWithHexString:@"#4273C4"] : [UIColor colorWithHexString:@"#212121"];
}

- (void)setEntity:(RLocationEntity *)entity {
    _entity = entity;
    [self.nameLabel setText:entity.name];
    self.adressLabel.text = entity.address ? : @"";
    self.centerConstraint.priority = entity.address.length > 0 ? 250 : 1000;
}

@end
