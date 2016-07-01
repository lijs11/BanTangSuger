//
//  KKWebViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/17.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWebViewController.h"
#import "LoadingView.h"
@interface KKWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *web;
@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation KKWebViewController

- (UIWebView *)web{
    if (!_web) {
        self.web = [[UIWebView alloc] init];
        self.web.backgroundColor = [UIColor whiteColor];
        self.web.frame = self.view.bounds;
        self.web.delegate = self;
        [self.view addSubview:self.web];
    }
    
    return _web;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)setUrlStr:(NSString *)urlStr{
    
    _urlStr = urlStr;
    //    self.web.scalesPageToFit = YES;
    //    self.web.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    self.web.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

- (void)setSubDataModel:(KKSubDataModel *)subDataModel{
    
    _subDataModel = subDataModel;
    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    self.titleLabel = titleLabel;
//    titleLabel.textColor =[UIColor whiteColor];
//    self.titleLabel.text = subDataModel.title;
//    [self.titleLabel sizeToFit];
//    self.navigationItem.titleView = self.titleLabel;
    
    NSURL *url = [NSURL URLWithString:subDataModel.share_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];
    

}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [LoadingView show];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [LoadingView dismiss];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [LoadingView dismiss];
    
}




//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //获取页面高度（像素）
//    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    float clientheight = [clientheight_str floatValue];
//    //设置到WebView上
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
//    //获取WebView最佳尺寸（点）
//    CGSize frame = [webView sizeThatFits:webView.frame.size];
//    //获取内容实际高度（像素）
//    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
//    float height = [height_str floatValue];
//    //内容实际高度（像素）* 点和像素的比
//    height = height * frame.height / clientheight;
//    //再次设置WebView高度（点）
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
//}


@end
