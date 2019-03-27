//
//  ZZVerticalCycleView.m
//  Rong518
//
//  Created by hzq on 2019/3/22.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "ZZVerticalCycleView.h"
#import <Masonry/Masonry.h>

@interface ZZVerticalCycleCell : UICollectionViewCell

@property(nonatomic,weak)UIView * customView;

@end

@implementation ZZVerticalCycleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

-(void)setCustomView:(UIView *)customView{
    if (!_customView) {
        _customView = customView;
        [self.contentView addSubview:_customView];
        [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
}


@end


@interface ZZVerticalCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;

@end

static NSString * ZZCycleScrollCellIdentify = @"ZZCycleScrollCellIdentify";

static NSUInteger  const ZZCycleMaxSections = 3;

@implementation ZZVerticalCycleView

#pragma mark - 初始化


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSubviews];
    
    [self initData];
}

- (void)initData {
    self.timeInterval = 3.0;
    
    [self addTimer];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        
        [self initData];
    }
    return self;
}

// 添加子控件
- (void)setupSubviews {
    
    //layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    self.layout = layout;
    
    // collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.scrollEnabled = NO;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:ZZVerticalCycleCell.class forCellWithReuseIdentifier:ZZCycleScrollCellIdentify];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.collectionView.frame;
    self.layout.itemSize = frame.size;
}

#pragma mark - - - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return ZZCycleMaxSections;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZZVerticalCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZZCycleScrollCellIdentify forIndexPath:indexPath];
    cell.customView = [self cycleCustomView];
    [self setupDataWithCustomView:cell.customView index:indexPath.item];
    return cell;
}

#pragma mark - - - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(cycleScrollDidClickItemWithIndex:)]) {
        [self.delegate cycleScrollDidClickItemWithIndex:indexPath.row];
    }
}

#pragma mark - - - 创建timer
- (void)addTimer {
    [self removeTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(scrollContentView) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark - - - 移除timer
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}
#pragma mark - - - timer方法
- (void)scrollContentView {
    if (_dataCount <=1 ) return;
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:ZZCycleMaxSections / 2];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == _dataCount) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
}

#pragma mark - - - setter

- (void)setTimeInterval:(CGFloat)timeInterval {
    _timeInterval = timeInterval;
    [self addTimer];
}

-(void)setDataCount:(NSInteger)dataCount{
    _dataCount = dataCount;
    [self.collectionView reloadData];
}


#pragma mark - ZZCycleScrollDelegate

-(void)setupDataWithCustomView:(UIView *)customView index:(NSInteger )index{
    if ([self.delegate respondsToSelector:@selector(cycleSetupDataWithCustomView:index:)]) {
        [self.delegate cycleSetupDataWithCustomView:customView index:index];
    }
}

-(UIView *)cycleCustomView{
    if ([self.delegate respondsToSelector:@selector(cycleScrollCustomView)]) {
        return [self.delegate cycleScrollCustomView];
    }else{
        return nil;
    }
    
}

@end
