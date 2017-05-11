//
//  ViewController.m
//  WebHeight
//
//  Created by 刘怀轩 on 2017/5/10.
//  Copyright © 2017年 刘怀轩. All rights reserved.
//

#import "ViewController.h"
#define KScreenSize [UIScreen mainScreen].bounds.size
#import "HXWebView.h"

@interface ViewController ()<UITableViewDelegate , UITableViewDataSource , UIWebViewDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIWebView *webView;
/** <#explain#> */
@property (nonatomic , assign) CGFloat webHeight;
@end

@implementation ViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGSize viewSize = [UIScreen mainScreen].bounds.size;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, viewSize.width, viewSize.height - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)loadWebView {
    UIWebView *webView = [[UIWebView alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://www.51tsg.com/index.php?act=goods&m=1&goods_id=7008"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenSize.width, 1)];
    _webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    //预先加载url
    NSURL *url = [NSURL URLWithString:@"http://www.51tsg.com/index.php?act=goods&m=1&goods_id=7008"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        NSLog(@"-----%f" , self.webHeight);
        return _webView.frame.size.height;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 1) {
        [cell.contentView addSubview:_webView];
    }
    return cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //获取到webview的高度
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, KScreenSize.width, height);
    [self.tableView reloadData];
}

@end
