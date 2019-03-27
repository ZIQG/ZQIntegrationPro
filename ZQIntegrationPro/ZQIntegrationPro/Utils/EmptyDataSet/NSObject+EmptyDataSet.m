//
//  NSObject+EmptyDataSet.m
//  EmptyDataHandle
//
//  Created by GTLand on 2018/11/26.
//  Copyright © 2018年 ZXL. All rights reserved.
//

#import "NSObject+EmptyDataSet.h"
#import <objc/runtime.h>
#import "UIScrollView+EmptyDataSet.h"

static char *ZScrollViewKey = "ZScrollViewKey";
static char *ZNodataTitleKey = "ZNodataTitleKey";
static char *ZNoDataImgNameKey = "ZNoDataImgNameKey";
static char *ZNoDataDetailTitleKey = "ZNoDataDetailTitleKey";
static char *ZBtnTitleKey = "ZBtnTitleKey";
static char *ZBtnImgNameKey = "ZBtnImgNameKey";


@interface NSObject (DZNEmptySet)<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, weak) UIScrollView *zScrollView;

@end

@implementation NSObject (DZNEmptySet)

- (void)setZScrollView:(UIScrollView *)zScrollView {
    objc_setAssociatedObject(self, ZScrollViewKey, zScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)zScrollView{
    return objc_getAssociatedObject(self, ZScrollViewKey);
}

@end


@implementation NSObject (EmptyDataSet)

- (void)setEmptyDataWithScrollView:(UIScrollView *)scrollView {
    self.zScrollView = scrollView;
    self.zScrollView.emptyDataSetDelegate = self;
    self.zScrollView.emptyDataSetSource = self;
}


-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.noDataImgName) {
        return [UIImage imageNamed:self.noDataImgName];
    }
    return [UIImage imageNamed:@"pn_icon_noData"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.noDataTitle?self.noDataTitle:@"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.noDataDetailTitle;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return self.noDataDetailTitle?[[NSAttributedString alloc] initWithString:text attributes:attributes]:nil;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
//{
//    return self.isShowEmptyData;
//}

//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -self.xlTableView.tableHeaderView.frame.size.height/2.0f;
//}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f]};
    
    return self.btnTitle?[[NSAttributedString alloc] initWithString:self.btnTitle attributes:attributes]:nil;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return self.btnImgName?[UIImage imageNamed:self.btnImgName]:nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
//    [self buttonEvent];
}

#pragma mark - setter & getter

- (void)setNoDataTitle:(NSString *)noDataTitle {
    objc_setAssociatedObject(self, ZNodataTitleKey, noDataTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.zScrollView reloadEmptyDataSet];
}

- (NSString *)noDataTitle {
    return objc_getAssociatedObject(self, ZNodataTitleKey);
}

- (void)setNoDataImgName:(NSString *)noDataImgName {
    objc_setAssociatedObject(self, ZNoDataImgNameKey, noDataImgName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)noDataImgName {
    return objc_getAssociatedObject(self, ZNoDataImgNameKey);
}

- (void)setNoDataDetailTitle:(NSString *)noDataDetailTitle {
    objc_setAssociatedObject(self, ZNoDataDetailTitleKey, noDataDetailTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)noDataDetailTitle {
    return objc_getAssociatedObject(self, ZNoDataDetailTitleKey);
}

- (void)setBtnTitle:(NSString *)btnTitle {
    objc_setAssociatedObject(self, ZBtnTitleKey, btnTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)btnTitle {
    return objc_getAssociatedObject(self, ZBtnTitleKey);
}

- (void)setBtnImgName:(NSString *)btnImgName {
    objc_setAssociatedObject(self, ZBtnImgNameKey, btnImgName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)btnImgName {
    return objc_getAssociatedObject(self, ZBtnImgNameKey);
}



@end
