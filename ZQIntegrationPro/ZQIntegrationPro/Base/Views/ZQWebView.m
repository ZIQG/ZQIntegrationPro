//
//  ZQWebView.m
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/12/4.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "ZQWebView.h"

@implementation ZQWebView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (self.wkWebprogressHandler)self.wkWebprogressHandler(newprogress);
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
