//
//  KKDisViewController.m
//  banTangSuger
//
//  Created by Kenny.li on 16/5/28.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKDisViewController.h"
#import "KKDoubleSeleView.h"
#import "HMHttpTool.h"
#import "KKImageScroller.h"
#import "KKBannerModel.h"
#import "KKTopicModel.h"
#import "KKWebViewController.h"
#import "KKDiscTableViewCell.h"
#import "KKPageCollectionView.h"
#import "KKWaterFlowView.h"
#import "KKCategory_list_Model.h"
#import "KKHotRecommendModel.h"

@interface KKDisViewController ()<doubleSeleViewDelegate,KKImageScrollerDelegate,UITableViewDataSource,UITableViewDelegate>


/**图片轮播器,数据  第一页*/
@property (nonatomic,strong)NSMutableArray *newses;
//头部
@property (nonatomic,strong)KKImageScroller *headerScView;

/**tab数据*/
@property (nonatomic,strong)NSMutableArray *topics;
//tableView
@property (nonatomic,strong)UITableView *tableView;



/**pageCollView 第二页*/
@property (nonatomic,strong)KKPageCollectionView *pageCollView;
/**KKWaterFlowView 第二页*/
@property (nonatomic,strong)KKWaterFlowView *waterFlowView;
/**mianScrollView 第二页*/
@property (nonatomic,strong)UIScrollView *mainScrollView;
/**mianScrollView 第二页*/
@property (nonatomic,strong)UIView *maincontentView;

/**第二页是否添加*/
@property (nonatomic,assign) BOOL isSecondTabAdd;

@property (nonatomic,strong)NSMutableArray *category_lists;
@property (nonatomic,strong)NSMutableArray *hotRecommends;

@end

@implementation KKDisViewController

- (NSMutableArray *)newses{
    if (_newses == nil) {
        self.newses = [NSMutableArray array];
    }
    return _newses;
}


- (NSMutableArray *)topics{
    if (_topics == nil) {
        self.topics = [NSMutableArray array];
    }
    return _topics;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //状态栏标签
    KKDoubleSeleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"KKDoubleSeleView" owner:nil options:nil] lastObject];
    titleView.delegate  = self;
    
    self.navigationItem.titleView = titleView;
    
    
    [self getArticleData];
    [titleView setBtnSelectedAtIndex:0];
    
    
    
}


- (void)doubleSeleViewDidSelectedBtn:(UIButton *)button atIndex:(NSUInteger)index{
    
    NSLogg(@"%lu",(unsigned long)index);
    
    if (index == 0) {//清单页
        //article -> tableview
        
        self.tableView.hidden = NO;
        self.waterFlowView.hidden = YES;
        
        
    }else if (index == 1){
        
         self.waterFlowView.hidden = NO;
         self.tableView.hidden = YES;
        
        [self setSingleProduct];
        
        
    }
    
}



#pragma mark - 清单
- (void)getArticleData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        NSString *url = @"http://open3.bantangapp.com/community/post/article";
        
//     app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.2&screensize=750&track_device_info=iPhone7%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"app_id"]= @"com.jzyd.BanTang";
        param[@"app_installtime"]= @"1464188730";
        param[@"app_versions"]= @"5.8";
        param[@"channel_name"]= @"appStore";
        param[@"client_id"]= @"bt_app_ios";
        param[@"client_secret"]= @"9c1e6634ce1c5098e056628cd66a17a5";
        param[@"os_versions"]= @"9.2";
        param[@"screensize"]= @"750";
        param[@"track_device_info"]= @"iPhone7%2C2";
        param[@"track_deviceid"]= @"3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13";
        
        
        [HMHttpTool post:url parameters:param success:^(id json) {
            
            //            NSLog(@"json %@",json);
//            if (![json[@"msg"] isEqualToString:@"成功"]) {
//                [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
//            }else{
                //JSON->模型
                //NSLog(@"model %@",model.mj_keyValues);
                //头部图片轮播数据
            NSDictionary *dataDict = json[@"data"];
            NSArray *bnanerArray = dataDict[@"banner"];
        
            self.newses = [KKBannerModel mj_objectArrayWithKeyValuesArray:bnanerArray];
            
             //清单头部
            //2.设置tableview Data
            [self getTabData];
   //     }
       
            
        } failure:^(NSError *error) {
            
            NSLog(@"getData--error %@",error);
            
        }];
    });
    
}



#pragma mark - getTabData

- (void)getTabData{

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        NSString *url = @"http://open3.bantangapp.com/topics/topic/listByUsers?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.2&page=0&pagesize=20&screensize=750&sort_type=1&track_device_info=iPhone7%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13";

        
        
        [HMHttpTool get:url parameters:nil success:^(id json) {
            
            //            NSLog(@"json %@",json);
        if (![json[@"msg"] isEqualToString:@"成功"]) {
               [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
           }else{
            //JSON->模型
            //NSLog(@"model %@",model.mj_keyValues);
            //头部图片轮播数据
            NSDictionary *dataDict = json[@"data"];
            NSArray *bnanerArray = dataDict[@"topic"];
            
            self.topics = [KKTopicModel mj_objectArrayWithKeyValuesArray:bnanerArray];
            //清单头部
            [self setupTabViews];
               
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"getData--error %@",error);
            
        }];
    });
    
    
}


- (UITableView *)tableView{
    
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = HMColor(239, 239, 239, 1);
        self.tableView.sectionFooterHeight = 0;
        self.tableView.showsVerticalScrollIndicator = YES;
//        self.tableView.estimatedRowHeight = 700;
//        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
    
    
}



#pragma mark - 更新Tab
- (void)setupTabViews{
    
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, self.tableView.width, 164);
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    //1.顶部图片轮播器
    KKImageScroller *headerScView = [[KKImageScroller alloc] init];
    headerScView.delegate = self;
    [bgView addSubview:headerScView];
    self.headerScView = headerScView;
    
    //Data
    NSMutableArray *imageArray  = [NSMutableArray array];
    
    for (KKBannerModel *model in self.newses) {
        [imageArray addObject:model.photo];
    }
    
    if (imageArray.count > 0) {
        [self.headerScView setImageScrollerWithImages:imageArray];
    }
    
    
    [headerScView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(bgView);
        make.height.mas_equalTo(120);
    }];
    
    
   
    
    //2 .headerView 原创文章
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 120, HMScreenW, 44);
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *leftImageV = [[UIImageView alloc] init];
    leftImageV.backgroundColor = [UIColor clearColor];
    leftImageV.image = [UIImage imageNamed:@"text2"];
    leftImageV.contentMode =  UIViewContentModeScaleToFill;
    leftImageV.frame = CGRectMake(0, 7, 20, 30);
    [headerView addSubview:leftImageV];
    
    UILabel *titleHeaderL = [[UILabel alloc] init];
    titleHeaderL.text = @"原创文章";
    titleHeaderL.backgroundColor = [UIColor whiteColor];
    titleHeaderL.frame = CGRectMake(20, 0, HMScreenW, 44);
    titleHeaderL.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:titleHeaderL];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0,43, HMScreenW, 0.6);
    lineView.alpha = 0.25;
    lineView.backgroundColor = [UIColor blackColor];
    [headerView addSubview:lineView];
    
    [bgView addSubview:headerView];
    
    self.tableView.tableHeaderView = bgView;
    
    //3.TableView
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.leading.trailing.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
}



#pragma mark - Tab Data


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.topics.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //1.创建cell
    static NSString *ID = @"disCCellID";
    KKDiscTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKDiscTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
  
    KKTopicModel *model = self.topics[indexPath.section];
    cell.topic = model;    
    return cell;
    
    
//    KKProductTableViewCell *cell = [KKProductTableViewCell cellWithTableView:tableView];
//    cell.product_pic_host = self.subDataModel.product_pic_host;//在产品赋值前面
//    cell.user_avatr_host = self.subDataModel.user_avatr_host;//头像也在前
//    cell.productModel = self.productArray[indexPath.row];
//    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
      return 199;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//   
//    
//}


#pragma mark - tableView 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKWebViewController *wbeVc = [[KKWebViewController alloc] init];
    [self.navigationController pushViewController:wbeVc animated:YES];
    
    KKTopicModel *topic = self.topics[indexPath.section];
    wbeVc.topicmodel = topic;
    
}

#pragma mark - imageScroller 选中
- (void)imageScroller:(KKImageScroller *)imageScroller didClickedAtIndex:(NSInteger)index{
    
    KKBannerModel *bamodel =  self.newses[index];
    KKWebViewController *webView = [[KKWebViewController alloc] init];
    [self.navigationController pushViewController:webView animated:YES];
    
    webView.bamodel = bamodel;
  
    
    
}




#pragma mark - 单品

- (NSMutableArray *)category_lists{
    if (_category_lists == nil) {
        self.category_lists = [NSMutableArray array];
    }
    return _category_lists;
}

- (NSMutableArray *)hotRecommends{
    if (_hotRecommends == nil) {
        self.hotRecommends = [NSMutableArray array];
    }
    return _hotRecommends;
}

//- (KKPageCollectionView *)pageCollView{
//    if (_pageCollView == nil) {
//        self.pageCollView = [[KKPageCollectionView alloc] init];
//     //   self.pageCollView.frame = CGRectMake(0, 64, HMScreenW, 250);
//        self.pageCollView.backgroundColor = [UIColor redColor];
//    }
//    return _pageCollView;
//}

- (KKWaterFlowView *)waterFlowView{
    if (_waterFlowView == nil) {
        self.waterFlowView = [[KKWaterFlowView alloc] init];
       // self.waterFlowView.frame = CGRectMake(0, 314, HMScreenW, self.view.height);
        self.waterFlowView.backgroundColor = [UIColor yellowColor];
        self.waterFlowView.navgationCC = self.navigationController;
    }
    return _waterFlowView;
}

//- (UIScrollView *)mainScrollView{
//    
//    if (_mainScrollView == nil) {
//        self.mainScrollView = [[UIScrollView alloc] init];
//        self.mainScrollView.backgroundColor = [UIColor grayColor];
//        self.mainScrollView.showsVerticalScrollIndicator = YES;
//        
//    }
//    return _mainScrollView;
//    
//}
//
//
//- (UIView *)maincontentView{
//    
//    if (_maincontentView == nil) {
//        self.maincontentView =  [[UIView alloc] init];
//        self.maincontentView.backgroundColor = [UIColor purpleColor];
//        
//    }
//    return _maincontentView;
//    
//}



- (void)setSingleProduct{
 
    
//    
//  
//    [self.view addSubview:self.mainScrollView];
//    
//    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    
//    [self.maincontentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.mainScrollView);
//        make.width.equalTo(self.mainScrollView);
//      //  make.height.mas_equalTo(HMScreenH);
//    }];
//    
    if (self.isSecondTabAdd == NO) {//如果第二个页面没有添加则添加 不然跳过
        self.isSecondTabAdd = YES;
        [self.view addSubview:self.waterFlowView];
        [self.waterFlowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(64);
            make.leading.trailing.bottom.mas_equalTo(self.view);
        }];
        
        
        [self getSingleProductData];
        [self getWaterFlowData];
    }
    
    
//    [self.pageCollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.maincontentView.mas_top).offset(64);
//        make.leading.trailing.mas_equalTo(self.maincontentView);
//        make.height.mas_equalTo(250);
//    }];

    
    
    
//    
//    [self.maincontentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.waterFlowView.mas_bottom).offset(10);
//    }];
//    
    
    
//    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//        make.width.mas_equalTo(self.view);
//    }];
//    
//    [self.pageCollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mainScrollView.mas_top).offset(64);
//        make.leading.trailing.mas_equalTo(self.mainScrollView);
//        make.height.mas_equalTo(250);
//    }];
//    
//    [self.waterFlowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.pageCollView.mas_bottom).offset(10);
//        make.leading.trailing.mas_equalTo(self.mainScrollView);
//        make.bottom.mas_equalTo(self.mainScrollView.mas_bottom);
//    }];
    
    
    
}


- (void)getSingleProductData{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        NSString *url =  @"http://open3.bantangapp.com/community/post/index?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.2&screensize=750&track_device_info=iPhone7%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13";
        
        
        
        [HMHttpTool get:url parameters:nil success:^(id json) {
            
            //            NSLog(@"json %@",json);
            if (![json[@"msg"] isEqualToString:@"ok"]) {
                [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            }else{
                //JSON->模型
                //NSLog(@"model %@",model.mj_keyValues);
                //头部图片轮播数据
                NSDictionary *dataDict = json[@"data"];
                NSArray *category_listArray = dataDict[@"category_list"];
                
                self.category_lists = [KKCategory_list_Model mj_objectArrayWithKeyValuesArray:category_listArray];
                //分类
                self.waterFlowView.category_lists = self.category_lists;
                
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"getData--error %@",error);
            
        }];
    });
    
}


- (void)getWaterFlowData{
    


    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        NSString *url =  @"http://open3.bantangapp.com/community/post/hotRecommend?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&os_versions=9.2&page=0&pagesize=30&screensize=750&track_device_info=iPhone7%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13";
        
        
        
        [HMHttpTool get:url parameters:nil success:^(id json) {
            
            //            NSLog(@"json %@",json);
            if (![json[@"msg"] isEqualToString:@"ok"]) {
                [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            }else{
                //JSON->模型
                //NSLog(@"model %@",model.mj_keyValues);
                //头部图片轮播数据
                NSArray *category_listArray = json[@"data"];;
                
                self.hotRecommends = [KKHotRecommendModel mj_objectArrayWithKeyValuesArray:category_listArray];
                //分类
                self.waterFlowView.hotRecommends = self.hotRecommends;
                
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"getData--error %@",error);
            
        }];
    });
    
}




@end
