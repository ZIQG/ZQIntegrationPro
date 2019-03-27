//
//  ZQInputView.m
//  Rong518
//
//  Created by hzq on 2019/3/26.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "ZQInputView.h"

@interface ZQInputView ()

/**
 *  占位文字View: 为什么使用UITextView，这样直接让占位文字View = 当前textView,文字就会重叠显示
 */
@property (nonatomic, weak) UITextView *placeholderView;

/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger textH;

/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;

@end

@implementation ZQInputView

- (UITextView *)placeholderView {
    if (_placeholderView == nil) {
        UITextView *placeholderView = [[UITextView alloc] init];
        _placeholderView = placeholderView;
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font = self.font;
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
    }
    return _placeholderView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    [self addObserver:self forKeyPath:@"textContainerInset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"textContainerInset"]) {
        NSValue *value = change[@"new"];
        self.placeholderTextContainerInset = value.UIEdgeInsetsValue;
    }
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    
    // 计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
}

- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setR_textHeightChangeBlock:(void (^)(NSString *, CGFloat))r_textChangeBlock {
    _r_textHeightChangeBlock = r_textChangeBlock;
    
    [self textDidChange];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderView.text = placeholder;
}

- (void)textDidChange {
    // 占位文字是否显示
    self.placeholderView.hidden = self.text.length > 0;
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (_textH != height) { // 高度不一样，就改变了高度
        
        // 最大高度，可以滚动
        self.scrollEnabled = height > _maxTextH && _maxTextH > 0;
        
        _textH = height;
        
        if (_r_textHeightChangeBlock && self.scrollEnabled == NO) {
            _r_textHeightChangeBlock(self.text,height);
            [self.superview layoutIfNeeded];
            self.placeholderView.frame = self.bounds;
        }
    }
}

- (void)setPlaceholderTextContainerInset:(UIEdgeInsets)placeholderTextContainerInset {
    _placeholderTextContainerInset = placeholderTextContainerInset;
    self.placeholderView.textContainerInset = placeholderTextContainerInset;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"textContainerInset"];
}


@end
