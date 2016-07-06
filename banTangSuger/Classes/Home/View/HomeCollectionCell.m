//
//  HomeCollectionCell.m
//  BanTang
//


#import "HomeCollectionCell.h"
#import "KKHomeTableViewCell.h"
#import "HMHttpTool.h"
#import "KKRecDataModel.h"
#import "KKSavingTool.h"
#import "KKSubViewController.h"
#import "KKWebViewController.h"

@interface HomeCollectionCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *subTopicsArray;
@end

@implementation HomeCollectionCell

- (NSMutableArray *)subTopicsArray{
    if (_subTopicsArray == nil) {
        self.subTopicsArray = [NSMutableArray array];
    }
    return _subTopicsArray;
}




- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        
        _tableView.rowHeight = 250;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [self addSubview:_tableView];
        
    }
    return self;
}

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


//代理是主Vc 此处不在监听
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLogg(@"选中了第%ld行",(long)indexPath.row);
//    
//    //取模型赋值
//    KKTopicModel *topic = self.topics[indexPath.row];
////    NSLogg(@"对应的topic为:%@",topic.mj_keyValues);
//    
//    //赋值给第二个页面
//    KKSubViewController *subVc = [[KKSubViewController alloc] init];
//    subVc.topic = topic;
//    [self.navCC presentViewController:subVc animated:YES completion:nil];
//    
//}




- (void)setTopics:(NSArray *)topics{
    _topics = topics;
   
    if (topics.count > 0) {
        
        KKSavingTool *savingTool = [KKSavingTool sharedSavingTool];
        [savingTool saveHistoryTopic:self.topics WithRow:self.row];
        
     [self.tableView reloadData];
    }
  
    
}

- (void)setCamodel:(KKCategory_elementModel *)camodel{
    
    _camodel = camodel;
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
   
    [self getOtherCellDataWithExtend:camodel.extend];
}





//除了第一个cell，剩余几个cell判断加载
- (void)getOtherCellDataWithExtend:(NSString *)extend{
    
    [self.subTopicsArray removeAllObjects];
    
//extend总共三种情况 1.http 头部较多 2.单个 listByScene  3.多个 listByIds
   
//    if ([extend hasPrefix:@"http://"]) {//头部较多，此处暂时不考虑
//        
//        KKWebViewController *webVc = [[KKWebViewController alloc] init];
//        webVc.urlStr = extend;
//        [self.navCC presentViewController:webVc animated:YES completion:nil];
//        return;
//    }
    
    
    NSString *sepString =@",";
    NSArray *strArray = [extend componentsSeparatedByString:sepString]; //从字符A中分隔成2个/Users/mac/Desktop/log2元素的数组
//    NSLogg(@"array- %@",strArray);
    
    if (strArray.count == 1) {//就一个元素，加载的是页面 id listByScene
        
        NSString *str = [strArray firstObject];
        NSString *url1 = [NSString stringWithFormat:@"http://open3.bantangapp.com/topics/topic/listByScene?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@&os_versions=9.2&page=0&pagesize=20&screensize=750&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",str];
//        NSLogg(@"请求url---%@",url1);
//        NSString *url = @"http://open3.bantangapp.com/topics/topic/listByScene?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=13&os_versions=9.2&page=0&pagesize=20&screensize=750&track_device_info=iPhone7%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13";
        
        //         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self httpConnectWithUrl:url1];
        
    }else if (strArray.count > 1){//多个元素，加载的是多个ids listByIds
        
//        NSString *str = [strArray firstObject];
//        NSString *url1 = [NSString stringWithFormat:@"http://open3.bantangapp.com/topics/topic/listByIds?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&ids=%@%%2C3728%%2C3446%%2C3702%%2C3668%%2C3679%%2C3685%%2C3634%%2C3656%%2C3641%%2C3602%%2C3478%%2C3614%%2C3545%%2C3533%%2C3464%%2C3453%%2C3297%%2C3408%%2C3168%%2C3390%%2C3363%%2C3209%%2C3127%%2C3135%%2C3096%%2C3080%%2C3083%%2C3075%%2C3036%%2C2942%%2C3007%%2C2966%%2C2953%%2C2948%%2C2884%%2C2888&os_versions=9.2&page=0&pagesize=20&screensize=750&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",str];
//        [self httpConnectWithUrl:url1];
        
//        NSString *strAll;
//        for (NSString *str  in strArray) {
//            if (str != [strArray lastObject]) {
//                [str stringByAppendingString:@"%2C"];
//            }
//            [strAll stringByAppendingString:str];
//        }
        
        NSString *idStr = [extend stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        
        
//        NSLogg(@"idStr--%@",idStr);
        
        NSString *url1 = [NSString stringWithFormat:@"http://open3.bantangapp.com/topics/topic/listByIds?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&ids=%@&os_versions=9.2&page=0&pagesize=20&screensize=750&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",idStr];
        
        [self httpConnectWithUrl:url1];
        
    }
    
}

//抽取的方法
- (void)httpConnectWithUrl:(NSString *)url{
    
    [HMHttpTool get:url parameters:nil success:^(id json) {
        
        if (![json[@"msg"] isEqualToString:@"成功"]) {
            [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            
        }else{
            //JSON->模型
            KKRecDataModel *model = [KKRecDataModel mj_objectWithKeyValues:json[@"data"]];
            //                NSLogg(@"分页 model %@",model.mj_keyValues);
            
            //UICollectionView数据
            NSArray *toArray = model.topic;
            [self.subTopicsArray addObjectsFromArray:toArray];
            
            if (self.subTopicsArray.count > 0) {//直接把值传给topics
                self.topics = self.subTopicsArray;
//                KKSavingTool *savingTool = [KKSavingTool sharedSavingTool];
//                [savingTool saveHistoryTopic:self.topics WithRow:self.row];
                
                
            }
            
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLogg(@"listByScene--error %@",error);
        
    }];
    //});

    
    
}








@end
