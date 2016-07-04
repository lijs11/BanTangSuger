//
//  KKTopProductViewController.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKTopProductViewController.h"
#import "KKHomeTableViewCell.h"
#import "KKRecDataModel.h"
#import "KKWebViewController.h"
#import "KKProducterViewController.h"

@interface KKTopProductViewController ()

@property (nonatomic,strong)NSMutableArray *subTopicsArray;
@property (nonatomic,assign) BOOL isSubViewWebView;

@property (nonatomic,strong)KKWebViewController *webVc;
@property (nonatomic,strong)KKProducterViewController *subVc;

@end

@implementation KKTopProductViewController

- (NSMutableArray *)subTopicsArray{
    if (_subTopicsArray == nil) {
        self.subTopicsArray = [NSMutableArray array];
    }
    return _subTopicsArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 250;
    self.tableView.showsVerticalScrollIndicator = YES;
//    self.tableView.delegate = self;
    
}




#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取模型赋值
    KKTopicModel *topic = self.topics[indexPath.row];
    
    //1.创建cell
    static NSString *ID = @"topicCellID";
    KKHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKHomeTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //    NSLogg(@"reloadData-%ld-%ld",indexPath.section,indexPath.row);
    cell.topic = topic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}




- (void)setTopics:(NSArray *)topics{
    _topics = topics;
    
    if (topics.count > 0) {
        
//        KKSavingTool *savingTool = [KKSavingTool sharedSavingTool];
//        [savingTool saveHistoryTopic:self.topics WithRow:self.row];
        
        [self.tableView reloadData];
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    KKTopicModel *topic = self.topics[indexPath.row];
    
        
        if (topic) {//请求数据发给subVc
            
            if ([topic.type isEqualToString:@"2"]) {//网页
                
                KKWebViewController *webVc = [[KKWebViewController alloc] init];
                self.webVc = webVc;
                [self.navigationController pushViewController:webVc animated:YES];
                self.isSubViewWebView = YES;
                
            }else{//自定义ProductView
                
                KKProducterViewController *subVc = [[KKProducterViewController alloc] init];
                self.subVc = subVc;
                [self.navigationController pushViewController:subVc animated:YES];
                self.isSubViewWebView = NO;
            }
            
            [self getDataWithID:topic.ID];
        
    }
    
    //    NSLogg(@"对应的topic为:%@",topic.mj_keyValues);
    
}

    
    







#pragma mark - SubVc的数据
- (void)getDataWithID:(NSString *)ID{
    NSString *urlStr = [NSString stringWithFormat:@"http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&from_home_rec=0&id=%@&os_versions=9.2&screensize=750&statistics_uv=1&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",ID];
    [self cellhttpConnectWithUrl:urlStr];
}

//抽取的方法
#pragma mark - 3种页面 1.网页 头部是一图片，网页放在滚动到图片下方 往上滚动 图片不动且被网页覆盖 article_content type = 2  2.图片和网页一起滚动 article_content  type = 2   前两种是网页  3.清单 图片可以下拉变大 有半糖精选和用户推荐 type = 0;
- (void)cellhttpConnectWithUrl:(NSString *)url{
    
    [HMHttpTool get:url parameters:nil success:^(id json) {
        
        if (![json[@"msg"] isEqualToString:@"ok"]) {
            [MBProgressHUD showError:@"无法获取数据，请检查网络!"];
            
        }else{
            
            //         NSLogg(@"KKSubViewVc--json--%@",json);
            
            //JSON->模型
            KKSubDataModel *subDataModel = [KKSubDataModel mj_objectWithKeyValues:json[@"data"]];
            //                NSLog(@"分页 model %@",model.mj_keyValues);
            if (self.isSubViewWebView) {
                self.webVc.subDataModel = subDataModel;
            }else{
                self.subVc.subDataModel = subDataModel;
            }
         
            
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"listByScene--error %@",error);
        
    }];
    //});
    
    
    
}













- (void)setBamodel:(KKBannerModel *)bamodel{
    
    _bamodel = bamodel;
    //假设事先存储的有，先提取,提取不到就联网更新---没有考虑下拉刷新
    //    KKSavingTool *savingTool = [KKSavingTool sharedSavingTool];
    //    NSMutableArray *dataArray = [savingTool readHistoryTopicWithRow:self.row];
    //
    //    if (dataArray.count > 0) {//有值
    //         self.topics = dataArray;
    //        NSLogg(@"本地数据");
    //    }else{
    //
    //        //联网更新
    //        [self getOtherCellDataWithExtend:camodel.extend];
    //    }
    
    [self getOtherCellDataWithExtend:bamodel.extend];
}





//除了第一个cell，剩余几个cell判断加载
- (void)getOtherCellDataWithExtend:(NSString *)extend{
    
    [self.subTopicsArray removeAllObjects];
    
           NSString *idStr = [extend stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        
        
        //        NSLogg(@"idStr--%@",idStr);
        
        NSString *url1 = [NSString stringWithFormat:@"http://open3.bantangapp.com/topics/topic/listByIds?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&ids=%@&os_versions=9.2&page=0&pagesize=20&screensize=750&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",idStr];
        
        [self httpConnectWithUrl:url1];
    
}

//抽取的方法
- (void)httpConnectWithUrl:(NSString *)url{
    
    [HMHttpTool get:url parameters:nil success:^(id json) {
        
        if (![json[@"msg"] isEqualToString:@"成功"]) {
            [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            
        }else{
            //JSON->模型
            KKRecDataModel *model = [KKRecDataModel mj_objectWithKeyValues:json[@"data"]];
            //                NSLog(@"分页 model %@",model.mj_keyValues);
            
            //UICollectionView数据
            NSArray *toArray = model.topic;
            [self.subTopicsArray addObjectsFromArray:toArray];
            
            if (self.subTopicsArray.count > 0) {//直接把值传给topics
                self.topics = self.subTopicsArray;
          
                
                
            }
            
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"listByScene--error %@",error);
        
    }];
  
    
    
}


@end
