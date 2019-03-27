//
//  ZQWebViewController.m
//  PursuitNetworkPro
//
//  Created by Allen、 LAS on 2018/12/4.
//  Copyright © 2018年 GTLand. All rights reserved.
//

#import "ZQWebViewController.h"
#import "ZQWebView.h"
@interface ZQWebViewController ()<WKNavigationDelegate>
@property (nonatomic,strong)ZQWebView * wkWebView;
@property (nonatomic,strong)UIProgressView * progressView;
@end

@implementation ZQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //设置返回按钮
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ricon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(onClickLeftBarButtonItem:)];

    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(2);
    }];

    [self.view layoutIfNeeded];
    
    [self loadRequestUrl];
}

- (void)onClickLeftBarButtonItem:(UIBarButtonItem*)sender{
    if (!self.wkWebView.canGoBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self.wkWebView goBack];
    }
}

- (void)loadRequestUrl{
    self.progressView.progress = 0.1;
    
    if ([_urlString r_isContainChinese]) { //是否包含中文
        _urlString = [_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
 
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [self.wkWebView loadRequest:urlRequest];
}

#pragma mark - 懒加载
- (ZQWebView*)wkWebView{
    if (!_wkWebView) {
       
        _wkWebView = [[ZQWebView alloc]init];
        _wkWebView.navigationDelegate = self;
        @weakify(self);
        _wkWebView.wkWebprogressHandler = ^(CGFloat progress) {
            @strongify(self);
            self.progressView.progress = progress;
            self.progressView.hidden = progress >= 0.7;
        };
    }
    return _wkWebView;
}

- (UIProgressView*)progressView{
    if (!_progressView) {
        _progressView  = [[UIProgressView alloc]init];
        _progressView.progressTintColor = [UIColor colorWithRGB:0x0066FF];
        _progressView.progressViewStyle = UIProgressViewStyleBar;
    }
    return _progressView;
}
@end
