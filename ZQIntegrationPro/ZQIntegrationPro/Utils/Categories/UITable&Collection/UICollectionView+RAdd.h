//
//  UICollectionView+RAdd.h
//  LvTaotao
//
//  Created by SIMT180321 on 2018/4/3.
//  Copyright © 2018年 Kerwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICollectionView (RAdd)

- (void)registerHeaderNib:(NSString *)nibName;
- (void)registerFooterNib:(NSString *)nibName;
- (void)registerCellNib:(NSString *)nibName;

- (void)registerHeaderClass:(Class)className;
- (void)registerFooterClass:(Class)className;
- (void)registerCellClass:(Class)className;

- (__kindof UICollectionReusableView *)reusableHeaderWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionReusableView *)reusableFooterWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionViewCell *)reusableCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

@end
