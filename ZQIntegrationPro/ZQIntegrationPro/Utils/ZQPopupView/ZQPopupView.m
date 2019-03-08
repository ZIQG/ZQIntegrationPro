//
//  ZQPopupView.m
//  TourShare_iOS_Seller
//
//  Created by hzq on 2018/4/23.
//  Copyright © 2018年 hzq. All rights reserved.
//

#import "ZQPopupView.h"
#define kwindow   ([UIApplication sharedApplication].keyWindow)
#define kAnimateDuration 0.3

@interface ZQPopupView ()

@property (nonatomic,strong) UIView                     *backgroundCoverView;//有颜色的背景遮罩
@property (nonatomic,strong) UIVisualEffectView         *effectView;//玻璃遮罩，暂时不使用
@property (nonatomic,strong) UIView                     *containerView;//放bgCoverView和self两个view
@property (nonatomic,assign) ZQPopupType                popupType;
@property (nonatomic,  copy) ZQPopupShowCmpletion       showCompletion;
@property (nonatomic,  copy) ZQPopupDismissCompletion   dismissCompletion;
@property (nonatomic,assign) CGRect                     setupFrame;
@property (nonatomic,  weak) UIView                     *popupContainerView;

@end

@implementation ZQPopupView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        _coverViewUserInteractionEnable = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillChangeFrameNotify:)
                                                     name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showWithPopupContainerView:(UIView *)containerView
                         popupType:(ZQPopupType)popupType
               backgroundViewColor:(UIColor *)backgroundViewColor
                    showCompletion:(ZQPopupShowCmpletion)showCompletion {
    self.popupContainerView = containerView;
    self.containerView.frame = containerView.bounds;
    self.backgroundCoverView.frame = containerView.bounds;
    [self showWithPopupType:popupType backgroundViewColor:backgroundViewColor showCompletion:showCompletion];
}

- (void)showWithPopupType:(ZQPopupType)popupType
      backgroundViewColor:(UIColor *)backgroundViewColor
           showCompletion:(ZQPopupShowCmpletion)showCompletion {
    self.popupType = popupType;
    self.backgroundCoverView.backgroundColor = backgroundViewColor;
    if (self.popupContainerView == nil) {
        self.popupContainerView = kwindow;
    }
    [self.popupContainerView addSubview:self.containerView];
    
    self.showCompletion = showCompletion;
    
    switch (popupType) {
        case ZQPopupTypeDrop:{
            self.setupFrame = self.frame;
            self.frame = CGRectMake(self.setupFrame.origin.x,
                                    -(self.setupFrame.origin.y+self.setupFrame.size.height),
                                    self.frame.size.width,
                                    self.frame.size.height);
            [self.containerView addSubview:self];
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.backgroundCoverView.alpha = 1;
                self.frame = CGRectMake(self.setupFrame.origin.x,
                                        self.setupFrame.origin.y,
                                        self.frame.size.width,
                                        self.frame.size.height);
            } completion:^(BOOL finished) {
                if(self.showCompletion){
                    self.showCompletion();
                }
            }];
        }
            break;
        case ZQPopupTypeAlert:{
            self.center = self.popupContainerView.center;
            self.transform = CGAffineTransformMakeScale(0.1, 0.1);
            [self.containerView addSubview:self];
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.backgroundCoverView.alpha = 1;
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                if(self.showCompletion){
                    self.showCompletion();
                }
                self.setupFrame = self.frame;
            }];
        }
            break;
            
        case ZQPopupTypeSheet:{
            self.frame = CGRectMake((self.popupContainerView.frame.size.width-self.frame.size.width)/2,
                                    self.popupContainerView.frame.size.height,
                                    self.frame.size.width,
                                    self.frame.size.height);
            [self.containerView addSubview:self];
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.backgroundCoverView.alpha = 1;
                self.frame = CGRectMake(self.frame.origin.x,
                                        self.popupContainerView.frame.size.height - self.frame.size.height,
                                        self.frame.size.width,
                                        self.frame.size.height);
            } completion:^(BOOL finished) {
                if(self.showCompletion){
                    self.showCompletion();
                }
                self.setupFrame = self.frame;
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)dismissWithCompletion:(ZQPopupShowCmpletion)dismissCompletion {
    self.dismissCompletion = dismissCompletion;
    switch (self.popupType) {
        case ZQPopupTypeDrop:{
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.frame = CGRectMake(self.frame.origin.x,
                                        -(self.frame.origin.y+self.frame.size.height),
                                        self.frame.size.width,
                                        self.frame.size.height);
                self.backgroundCoverView.alpha = 0;
            } completion:^(BOOL finished) {
                if(self.dismissCompletion){
                    self.dismissCompletion();
                }
                [self.containerView removeFromSuperview];
                [self removeFromSuperview];
            }];
        }
            break;
        case ZQPopupTypeAlert:{
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                self.backgroundCoverView.alpha = 0;
            } completion:^(BOOL finished) {
                if(self.dismissCompletion){
                    self.dismissCompletion();
                }
                [self.containerView removeFromSuperview];
                [self removeFromSuperview];
            }];
        }
            break;
            
        case ZQPopupTypeSheet:{
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.frame = CGRectMake(self.frame.origin.x,
                                        self.popupContainerView.frame.size.height,
                                        self.frame.size.width,
                                        self.frame.size.height);
                self.backgroundCoverView.alpha = 0;
            } completion:^(BOOL finished) {
                if(self.dismissCompletion){
                    self.dismissCompletion();
                }
                [self.containerView removeFromSuperview];
                [self removeFromSuperview];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)setCoverViewUserInteractionEnable:(BOOL)coverViewUserInteractionEnable {
    _coverViewUserInteractionEnable = coverViewUserInteractionEnable;
}

- (void)bgCoverViewClickAction {
    if (_coverViewUserInteractionEnable == NO) {
        return;
    }
    [self dismissWithCompletion:nil];
}

- (UIView *)backgroundCoverView {
    if (_backgroundCoverView == nil) {
        _backgroundCoverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backgroundCoverView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgCoverViewClickAction)];
        _backgroundCoverView.userInteractionEnabled = YES;
        [_backgroundCoverView addGestureRecognizer:tap];
        _backgroundCoverView.alpha = 0;
    }
    return _backgroundCoverView;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc]init];
        _containerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.layer.masksToBounds = YES;
        [_containerView addSubview:self.backgroundCoverView];
    }
    return _containerView;
}

#pragma mark - 监听事件
- (void)keyboardWillChangeFrameNotify:(NSNotification*)notify {
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    __block CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    NSLog(@"keyboardFrame %@",NSStringFromCGRect(keyboardFrame));
    if (keyboardFrame.size.height != 44) {
        [UIView animateWithDuration:duration animations:^{
            if(keyboardFrame.origin.y == kScreenHeight) {
                self.top = self.setupFrame.origin.y;
            }else{
                self.top = keyboardFrame.origin.y-self.height;
            }
        }completion:nil];
    }
}

@end
