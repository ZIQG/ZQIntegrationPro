//
//  UICollectionView+RAdd.m
//  LvTaotao
//
//  Created by SIMT180321 on 2018/4/3.
//  Copyright © 2018年 Kerwin. All rights reserved.
//

#import "UICollectionView+RAdd.h"

@implementation UICollectionView (RAdd)

- (void)registerHeaderNib:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle bundleForClass:[NSClassFromString(nibName) class]]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:nibName];
}

- (void)registerFooterNib:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle bundleForClass:[NSClassFromString(nibName) class]]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:nibName];
}

- (void)registerCellNib:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:[NSBundle bundleForClass:[NSClassFromString(nibName) class]]] forCellWithReuseIdentifier:nibName];
}

- (void)registerHeaderClass:(Class)className {
    [self registerClass:className forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(className)];
}

- (void)registerFooterClass:(Class)className {
    [self registerClass:className forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(className)];
}

- (void)registerCellClass:(Class)className {
    [self registerClass:className forCellWithReuseIdentifier:NSStringFromClass(className)];
}

- (__kindof UICollectionReusableView *)reusableHeaderWithIdentifier:(NSString *)identifier indexPath:indexPath {
    UICollectionReusableView *reusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    
    return reusableView;
}

- (__kindof UICollectionReusableView *)reusableFooterWithIdentifier:(NSString *)identifier indexPath:indexPath {
    UICollectionReusableView *reusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
    
    return reusableView;
}

- (__kindof UICollectionViewCell *)reusableCellWithIdentifier:(NSString *)identifier indexPath:indexPath {
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

@end
