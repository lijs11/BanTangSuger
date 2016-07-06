//
//  KKWebViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/17.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWebViewController.h"
#import "LoadingView.h"
#import <WebKit/WebKit.h>
#import "KKSubDataModel.h"


@interface KKWebViewController ()
@property (nonatomic,strong)WKWebView *web;
@property (nonatomic,strong)UILabel *titleLabel;


@property (nonatomic,strong)NSMutableArray *subTopicsArray;


@end

@implementation KKWebViewController


- (NSMutableArray *)subTopicsArray{
    if (_subTopicsArray == nil) {
        self.subTopicsArray = [NSMutableArray array];
    }
    return _subTopicsArray;
}






- (WKWebView *)web{
    if (!_web) {
        self.web = [[WKWebView alloc] init];
        self.web.backgroundColor = [UIColor whiteColor];
        self.web.frame = self.view.bounds;
       // self.web.navigationDelegate = self;
        [self.view addSubview:self.web];
        self.web.frame = self.view.bounds;
        self.web.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
       // self.web.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
    }
    
    return _web;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
  //  self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setUrlStr:(NSString *)urlStr{
    
    _urlStr = urlStr;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];
    
    
}

- (void)setSubDataModel:(KKSubDataModel *)subDataModel{
    
    _subDataModel = subDataModel;
    
    NSURL *url = [NSURL URLWithString:subDataModel.share_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];

}


- (void)setTopicmodel:(KKTopicModel *)topicmodel{
    
    _topicmodel = topicmodel;
    if (topicmodel.ID) {
         [self getOtherCellDataWithExtend:topicmodel.ID];
    }
   
}



- (void)setBamodel:(KKBannerModel *)bamodel{
    _bamodel = bamodel;
    
    
    
    if ([bamodel.type isEqualToString:@"webview"]) {
        
         self.urlStr = bamodel.extend;
        
    }else if ([bamodel.type isEqualToString:@"topic_detail"]){
        
        [self getOtherCellDataWithExtend:bamodel.extend];
    }
    
    
//    if ([bamodel.extend hasPrefix:@"http://"]) {//网址
//        
//        self.urlStr = bamodel.extend;
//        
//    }else{//ID
//        
//        [self getOtherCellDataWithExtend:bamodel.extend];
//        
//    }
    
}





//除了第一个cell，剩余几个cell判断加载
- (void)getOtherCellDataWithExtend:(NSString *)extend{
    
    [self.subTopicsArray removeAllObjects];
    
  //  NSString *idStr = [extend stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    
    
    //        NSLogg(@"idStr--%@",idStr);
    
    NSString *url1 = [NSString stringWithFormat:@"http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@&os_versions=9.2&screensize=750&statistics_uv=0&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&type_id=1&v=13",extend];
    
    [self httpConnectWithUrl:url1];
    
}

//抽取的方法
- (void)httpConnectWithUrl:(NSString *)url{
    
    [HMHttpTool get:url parameters:nil success:^(id json) {
        
        if (![json[@"msg"] isEqualToString:@"ok"]) {
            [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            
        }else{
            //JSON->模型
            KKSubDataModel *model = [KKSubDataModel mj_objectWithKeyValues:json[@"data"]];
            //                NSLog(@"分页 model %@",model.mj_keyValues);
            self.urlStr = model.share_url;
        
        }
        
        
    } failure:^(NSError *error) {
        NSLogg(@"listByScene--error %@",error);
        
    }];
    
    
    
}












- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.web removeFromSuperview];
    
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
