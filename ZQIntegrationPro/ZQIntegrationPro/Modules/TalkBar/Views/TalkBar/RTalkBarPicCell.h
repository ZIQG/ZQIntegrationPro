//
//  RTalkBarPicCell.h
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTalkBarPicCell : UICollectionViewCell

@property (nonatomic, copy) NSString * imageUrl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
