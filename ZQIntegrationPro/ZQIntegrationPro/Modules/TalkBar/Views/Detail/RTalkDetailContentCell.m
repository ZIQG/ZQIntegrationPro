//
//  RTalkDetailContentCell.m
//  Rong518
//
//  Created by hzq on 2019/3/26.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkDetailContentCell.h"
#import "RTalkBarPicCell.h"

@interface RTalkDetailContentCell ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    CGFloat picW;
    CGFloat picH;
    CGFloat picMargin;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

static NSString *cellidentifier = @"RTalkBarPicCell";

@implementation RTalkDetailContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    picMargin = 5;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerCellNib:cellidentifier];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pics.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    RTalkBarPicCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];
    cell.imageUrl = self.pics[indexPath.row];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(picW, picH);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)setPics:(NSArray *)pics{
    _pics = pics;
    NSInteger count = pics.count;
    CGFloat height = 0.0 ;
    if (count==0) {
        height = 0;
        self.collectionView.hidden = YES;
    }else{
        if (count == 111) {
            picW = 173;
            picH = picW;
            height = picH;
        } else {
            if (count == 4) {
                NSMutableArray * mutArray = [pics mutableCopy];
                [mutArray insertObject:[NSNull null] atIndex:2];
                pics = mutArray;
                _pics = pics;
                count += 1;
            }
            picW = (kScreenWidth - 115 - picMargin *2) / 3;
            picH = picW;
            if (count == 1) {
                picW = 130 * kScreenRatio;
                picH = 170 * kScreenRatio;
            }
            NSInteger rows = 0;
            int col = count % 3;
            if (col == 0) {
                rows = count/3;
            }else{
                rows = count/3 +1;
            }
            height = picH * rows + picMargin *(rows-1);
            self.collectionView.hidden = NO;
        }
    }
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    [self.collectionView reloadData];
    
}

@end




