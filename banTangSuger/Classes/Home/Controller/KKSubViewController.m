//
//  KKSubViewController.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKSubViewController.h"
#import "UIImageView+WebCache.h"
#import "KKProductModel.h"
#import "KKSubDataModel.h"

@interface KKSubViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *text;



@end

@implementation KKSubViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}

- (void)setTopic:(KKTopicModel *)topic{
    
    _topic = topic;
    
//    [self.pic sd_setImageWithURL:[NSURL URLWithString:topic.pic]];
//    self.titleLable.text = topic.title;
   
    if (topic) {
      [self getDataWithID:topic.ID];
    }
    
}


- (void)getDataWithID:(NSString *)ID{
    NSString *urlStr = [NSString stringWithFormat:@"http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&from_home_rec=0&id=%@&os_versions=9.2&screensize=750&statistics_uv=1&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",ID];    
    [self httpConnectWithUrl:urlStr];
}


//抽取的方法
#pragma mark - 3种页面 1.网页 头部是一图片，网页放在滚动到图片下方 往上滚动 图片不动且被网页覆盖 article_content type = 2  2.图片和网页一起滚动 article_content  type = 2     3.清单 图片可以下拉变大 有半糖精选和用户推荐 type = 0;
- (void)httpConnectWithUrl:(NSString *)url{
    
    [HMHttpTool get:url parameters:nil success:^(id json) {
        
        if (![json[@"msg"] isEqualToString:@"ok"]) {
            [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            
        }else{
            
//            NSLogg(@"KKSubViewVc--json--%@",json);
            
            //JSON->模型
            KKSubDataModel *model = [KKSubDataModel mj_objectWithKeyValues:json[@"data"]];
            //                NSLog(@"分页 model %@",model.mj_keyValues);
            
            //Product的数据
        //    NSArray *proArray = model.product;
           
            //设置页面
            
            [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic]];
            self.titleLable.text = model.title;
            self.text.text = model.desc;
            
            //下面加上半糖精选子栏目 product子类的放进去
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        NSLogg(@"listByScene--error %@",error);
        
    }];
    //});
    
    
    
}

@end
