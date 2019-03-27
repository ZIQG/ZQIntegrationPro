//
//  RTalkPublishPicsCell.m
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkPublishPicsCell.h"
#import "RTalkPublishAddPicCell.h"
#import "RTalkBarPicCell.h"

@interface RTalkPublishPicsCell ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    CGFloat picWH;
    CGFloat picMargin;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RTalkPublishPicsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    picMargin = 13;
    picWH = (kScreenWidth - 40 - picMargin *2) / 3;
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerCellNib:NSStringFromClass(RTalkPublishAddPicCell.class)];
    [self.collectionView registerCellNib:NSStringFromClass(RTalkBarPicCell.class)];
    
}

-(void)setImages:(NSMutableArray *)images{
    _images = images;
    
    CGFloat height ;
    NSInteger count = images.count +1;
    NSInteger rows = 0;
    int col = count % 3;
    if (col == 0) {
        rows = count/3;
    }else{
        rows = count/3 +1;
    }
    height = picWH * rows + picMargin *(rows-1);
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height + 35 * 2);
    }];
    
    [self.collectionView reloadData];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count + 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row != self.images.count) {
        RTalkBarPicCell *cell = [collectionView reusableCellWithIdentifier:NSStringFromClass(RTalkBarPicCell.class) indexPath:indexPath];
        cell.imageView.image = self.images[indexPath.row];
        
        return cell;
    } else {
        RTalkPublishAddPicCell *cell = [collectionView reusableCellWithIdentifier:NSStringFromClass(RTalkPublishAddPicCell.class) indexPath:indexPath];
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(picWH, picWH);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.images.count) {
        if (self.selectImageBlock) {
            self.selectImageBlock();
        }
    }
}

@end
