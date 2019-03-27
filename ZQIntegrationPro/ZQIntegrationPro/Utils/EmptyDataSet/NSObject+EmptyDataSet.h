//
//  NSObject+EmptyDataSet.h
//  EmptyDataHandle
//
//  Created by GTLand on 2018/11/26.
//  Copyright © 2018年 ZXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (EmptyDataSet)

- (void)setEmptyDataWithScrollView:(UIScrollView *)scrollView;

//空数据页面的title -- 可不传，默认为：暂无任何数据
@property(nonatomic, copy) NSString *noDataTitle;

//空数据页面的图片 -- 可不传，默认图片为：NoData
@property(nonatomic, copy) NSString *noDataImgName;

//显示副标题的时候，需要赋值副标题，否则不显示
@property(nonatomic, copy) NSString *noDataDetailTitle;

//按钮标题、图片 --不常用
@property(nonatomic, copy) NSString *btnTitle;
@property(nonatomic,copy) NSString *btnImgName;


@end

NS_ASSUME_NONNULL_END
