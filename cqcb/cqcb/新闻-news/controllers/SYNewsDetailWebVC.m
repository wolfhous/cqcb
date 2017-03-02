//
//  SYNewsDetailWebVC.m
//  cqcb
//
//  Created by 壹号商圈 on 17/3/2.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "SYNewsDetailWebVC.h"
#import "UIBarButtonItem+HSExtension.h"
@interface SYNewsDetailWebVC ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;

/** 网络圈圈*/
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;

@end

@implementation SYNewsDetailWebVC
//重写setUrl方法  判断url是否包含头http
-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = [HSManager hs_getCorrectURL:urlStr];
}


#pragma mark - 懒加载
-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        CGFloat w = 100;
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, (SCREEN_HEIGHT-w)/2, w, w)];
        _activityIndicatorView.color = HSMainColor;
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:self.webView];
    }
    return _webView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.jz_navigationBarTintColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"上游新闻";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"btn_more_function_gray_22x22_" highImage:@"btn_more_function_gray_22x22_" target:self action:@selector(cliclNewsDetailWebRightItem)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}
#pragma mark - 点击右侧分享按钮
-(void)cliclNewsDetailWebRightItem{
    DLogFunc
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //开始转圈
    [self.activityIndicatorView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //结束转圈
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //结束转圈
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
    
}



@end
