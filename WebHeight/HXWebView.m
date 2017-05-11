//
//  HXWebView.m
//  WebHeight
//
//  Created by 刘怀轩 on 2017/5/10.
//  Copyright © 2017年 刘怀轩. All rights reserved.
//

#import "HXWebView.h"

#define KScreenSize [UIScreen mainScreen].bounds.size

@interface HXWebView ()<UIWebViewDelegate>
/** <#explain#> */
@property (nonatomic , assign) CGFloat webHeight;
@end

@implementation HXWebView

- (void)loadWebView:(NSString *)strUrl {
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.userInteractionEnabled = NO;
    [webView loadRequest:request];
    [self addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //HTML5的高度
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    //HTML5的宽度
    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    //宽高比
    float i = [htmlWidth floatValue]/[htmlHeight floatValue];
    
    //webview控件的最终高度
    float height = KScreenSize.width/i;
    self.webHeight = height;
}

- (CGFloat)webViewToHeightWithURL:(NSString *)url {
    [self loadWebView:url];
    return self.webHeight;
}

@end
