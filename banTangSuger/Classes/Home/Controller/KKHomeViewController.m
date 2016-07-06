//
//  KKHomeViewController.m
//  banTangSuger
//
//  Created by Kenny.li on 16/5/28.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKHomeViewController.h"
#import "UINavigationBar+Extension.h"

#import "KKImageScroller.h"
#import "KKImageModel.h"

#import "HMHttpTool.h"
#import "KKRecDataModel.h"

#import "KKBannerModel.h"


#import "KKTitleScrollView.h"
#import "KKCategory_elementModel.h"

#import "KKProducterViewController.h"
#import "KKSavingTool.h"
#import "KKHomeScrollView.h"

#import "HomeCollectionCell.h"

#import "KKSubDataModel.h"
#import "KKWebViewController.h"
#import "KKTopProductViewController.h"

/** 滚动标题的高度  */
static const CGFloat kTitleVewHeight = 45;
static const CGFloat KKNavigationBarHeight = 64;
static const CGFloat KKTabbarBottomHeight = 49;
///** 滚动标题每个item的宽度  */
//static const CGFloat kTitleViewItemWidth = 64;
///** 焦点按钮与下面的距离  */
//static const CGFloat kHotViewMargin = 10;

@interface KKHomeViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,KKTitleScrollViewDelegate,UICollectionViewDelegateFlowLayout,KKImageScrollerDelegate>



/**底层*/
@property (nonatomic,strong)KKHomeScrollView *scrollMainView;
@property (nonatomic,strong)UIView *contentMainView;
@property (nonatomic,strong)UIView *headerMainView;


/**图片轮播器,数据*/
@property (nonatomic,strong)NSMutableArray *newses;
@property (nonatomic,strong)KKImageScroller *headerSc;

/**TitleView*/
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)KKTitleScrollView *titleSc;

/**CollectionView相关*/
@property (nonatomic,strong)NSMutableArray *topicsArray;
@property (nonatomic,strong)UICollectionView *collectView;

/**CollectionView相关-分页subTopicsArray*/
@property (nonatomic,strong)NSMutableArray *subTopicsArray;

/**存放总数据*/
@property (nonatomic,strong)NSMutableDictionary *dictSource;

@property (nonatomic,assign) CGFloat navigationBarAlpha;

//TableView可不可以滑动
@property (nonatomic,assign) BOOL tableViewScrollEnabled;




@property (nonatomic, assign) BOOL canScrollViewScroll;
/**TableView不能移动*/
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;

@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@property (nonatomic, assign) BOOL canTableViewScroll;


//选中的是哪个Item，每次记录点击便于TableView topic选择
@property (nonatomic, assign) NSInteger selectedItem;


//两种分页界面
@property (nonatomic,strong)KKWebViewController *webVc;
@property (nonatomic,strong)KKProducterViewController *subVc;
@property (nonatomic,assign) BOOL isSubViewWebView;

@end

@implementation KKHomeViewController

- (NSMutableArray *)newses{
    if (_newses == nil) {
        self.newses = [NSMutableArray array];
    }
    return _newses;
}

- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)topicsArray{
    if (_topicsArray == nil) {
        self.topicsArray = [NSMutableArray array];
    }
    return _topicsArray;
}


- (NSMutableArray *)subTopicsArray{
    if (_subTopicsArray == nil) {
        self.subTopicsArray = [NSMutableArray array];
    }
    return _subTopicsArray;
}

#pragma mark - 添加控件

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    //设置滑动时navigationBar颜色
    self.navigationController.navigationBarHidden = NO;
    
    CGFloat offsetY = self.scrollMainView.contentOffset.y;
    CGFloat titleScDeY = self.headerSc.frame.size.height - self.navigationController.navigationBar.height - 20;
    self.navigationBarAlpha = offsetY / titleScDeY;
    
    [self.navigationController.navigationBar zz_setBackgroundColor:[HMColor(231, 65, 65, 1) colorWithAlphaComponent:self.navigationBarAlpha]];
    [self.navigationController.navigationBar zz_setElementAlpha:self.navigationBarAlpha withIsNav:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    self.contentMainView.size = CGSizeMake(self.view.width, 836.5);
//    self.scrollMainView.contentSize = CGSizeMake(self.view.width, 836.5);

//    NSLog(@"contentMainView %lf %lf",self.contentMainView.width,self.contentMainView.height);
//    NSLog(@"scrollMainView %lf %lf",self.scrollMainView.width,self.scrollMainView.height);
//    NSLog(@"scrollMainView contentSize %lf %lf",self.scrollMainView.contentSize.width,self.scrollMainView.contentSize.height);
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar zz_reset];
}


//-(void)viewDidLayoutSubviews
//{
//       self.scrollMainView.contentSize = CGSizeMake(self.view.width, self.topicsArray.count * 250 + 225);
//}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    
    [self setNav];
    [self setupMainViews];
    [self getData];
//    [self setupHeaderWithData];
    
}


- (void)setNav{
    
    //标题
    UIImageView *navTitileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nar_logo"]];
    navTitileView.size = navTitileView.image.size;
    self.navigationItem.titleView = navTitileView;
    
    //左
    UIImage *navLeftImage = [UIImage imageNamed:@"subscribe_icon"];
    navLeftImage = [navLeftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:navLeftImage style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClicked)];
    leftItem.imageInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右
    UIImage *navRightImage = [UIImage imageNamed:@"sign_bar_icon"];
    navRightImage = [navRightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:navRightImage style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
    rightItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.navigationItem.rightBarButtonItem = rightItem;

   self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)leftItemClicked{
    NSLogg(@"leftItemClicked");
}

- (void)rightItemClicked{
    NSLogg(@"rightItemClicked");
    
}



- (void)setupMainViews{
    
    
    KKHomeScrollView *scrollMainView = [[KKHomeScrollView alloc] init];
    scrollMainView.delegate = self;
    scrollMainView.showsVerticalScrollIndicator = NO;
    self.scrollMainView = scrollMainView;
    scrollMainView.backgroundColor = [UIColor whiteColor];
    

    
    self.contentMainView = [[UIView alloc] init];
    self.contentMainView.backgroundColor = [UIColor whiteColor];
    
    [scrollMainView addSubview:self.contentMainView];
    [self.view addSubview:scrollMainView];
    [self.scrollMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollMainView);
        make.width.equalTo(self.scrollMainView);
    }];
    
    
}




#pragma mark - 各个控件数据------有网才能显示
- (void)setupHeaderWithData{
    
    
    
    
    
    
    //1.顶部图片轮播器
    self.headerMainView = [[UIView alloc] init];
    KKImageScroller *headerSc = [[KKImageScroller alloc] init];
//    [headerSc.subviews firstObject].backgroundColor = [UIColor redColor];
    headerSc.delegate = self;
    [self.headerMainView addSubview:headerSc];
    self.headerSc = headerSc;
    
    //Data
    NSMutableArray *imageArray = [NSMutableArray array];
    for (KKBannerModel *bamodel in self.newses) {
        [imageArray addObject:bamodel.photo];
    }
    if (imageArray.count > 0) {
        [self.headerSc setImageScrollerWithImages:imageArray];
    }
    

    //2.TableView顶部Title
    NSMutableArray *titleMuArray = [NSMutableArray array];
    for (KKCategory_elementModel *camodel in self.titleArray) {
        [titleMuArray addObject:camodel.title];
    }
    
    KKTitleScrollView *titleSc;
    if (titleMuArray.count > 0) {//网络有数据
       titleSc = [[KKTitleScrollView alloc] initWithTitleArray:titleMuArray titleSubWidth:75];
    }else{//网络无数据，加载本地
        NSString *path = [[NSBundle mainBundle] pathForResource:@"titleData" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *camodelArray= [KKCategory_elementModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        
        for (KKCategory_elementModel *camodel in camodelArray) {
            NSLogg(@"本地数据 %@",camodel.title);
            [titleMuArray addObject:camodel.title];
            
        }
        titleSc = [[KKTitleScrollView alloc] initWithTitleArray:titleMuArray titleSubWidth:64];
    }
    
    [self.headerMainView addSubview:titleSc];
     self.titleSc = titleSc;
    self.titleSc.delegate = self;
    
    
    [headerSc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.headerMainView);
        make.height.mas_equalTo(210);
    }];
    
    
    [titleSc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerSc.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.headerMainView);
//        make.height.mas_equalTo(45);
    }];
    
    [self.contentMainView addSubview:self.headerMainView];
    [self.headerMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentMainView);
        make.leading.trailing.equalTo(self.contentMainView);
        make.height.mas_equalTo(255);
    }];
    
   
    
    
    //3.UIcollectionView 设置
    [self.contentMainView addSubview:self.collectView];
    
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerMainView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.contentMainView);
//        make.height.mas_equalTo(self.topicsArray.count * 250);
        make.height.mas_equalTo(HMScreenH - KKNavigationBarHeight - KKTabbarBottomHeight - kTitleVewHeight);
    }];
    [self.collectView reloadData];

}

/*UIcollectionView 懒加载**/
- (UICollectionView *)collectView{
    if (_collectView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        layout.itemSize = CGSizeMake(self.view.width,self.topicsArray.count * 250);
//        layout.itemSize = CGSizeMake(self.view.width, 5 * 250);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
//        layout.headerReferenceSize = CGSizeZero;
//        layout.footerReferenceSize = CGSizeZero;
        
        self.collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectView.pagingEnabled = YES;
        self.collectView.backgroundColor = [UIColor whiteColor];
        self.collectView.delegate = self;
        self.collectView.dataSource = self;
        self.collectView.bounces = NO;//默认YES
        
//        [self.collectView registerNib:[UINib nibWithNibName:@"KKHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKHomeCollectionViewCellID"];
          [self.collectView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeCollectionCell class])];
        
    }
    
    return _collectView;
}


#pragma mark - UICollectionView--Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeCollectionCell class]) forIndexPath:indexPath];
    cell.tableView.delegate = self;
    cell.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0 && indexPath.item == 0 ) {//第一个不一样,是总数据里面带有分数据，分数据单独拿出来加载后赋值
//        NSLogg(@"indexPath--%@,item--%ld",indexPath,(long)indexPath.item);
        cell.topics = self.topicsArray;
        
    }else{
//         NSLogg(@"collectionView--%@,Item--%ld",indexPath,(long)indexPath.item);
        cell.topics = nil;
        KKCategory_elementModel *camodel = self.titleArray[indexPath.item];
        cell.camodel = camodel;//直接传extend给cell
        
}
//    cell.tableView.scrollEnabled = self.tableViewScrollEnabled;
    cell.row = indexPath.row;
    cell.navCC = self.navigationController;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectView.bounds.size;
}





#pragma mark - 在这里实现TableView代理方法，更好的监听UICollectionView里的tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLogg(@"选中了第%ld行--是UICollectionView第%ld个Item",(long)indexPath.row,self.selectedItem);
    
  
    
//点击的是UICollectionView第几个Item
//假设事先存储的有，先提取,提取不到就联网更新---没有考虑下拉刷新
    KKSavingTool *savingTool = [KKSavingTool sharedSavingTool];
    NSMutableArray *dataArray = [savingTool readHistoryTopicWithRow:self.selectedItem];
    
    if (dataArray.count > 0) {//有值
     
       //取模型赋值
        KKTopicModel *topic = dataArray[indexPath.row];
        
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
        
    }
    
    //    NSLogg(@"对应的topic为:%@",topic.mj_keyValues);
    
}







//CollectionView滚到一个Item，计算contentOffset.x所在index-->传给TitileView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        NSInteger indexOfSc = scrollView.contentOffset.x / self.view.width;
        self.selectedItem = indexOfSc;//记录
//        NSLogg(@"CollectionView IndexPath--%ld",(long)indexOfSc);
        [self.titleSc selectItemAtIndex:indexOfSc];
    }
}




#pragma mark - KKImageScrollerDelegate
- (void)imageScroller:(KKImageScroller *)imageScroller didClickedAtIndex:(NSInteger)index{
    
    NSLogg(@"imageScroller click %ld picture",index);
    
    KKBannerModel *bamodel =  self.newses[index];
    KKTopProductViewController *topProductVc = [[KKTopProductViewController alloc] init];
    [self.navigationController pushViewController:topProductVc animated:YES];
    topProductVc.bamodel = bamodel;
}


#pragma mark - KKTitleScrollViewDelegate
//TitileView选中一个,CollectionView滚到对应的Item
- (void)titleScrollViewDidClicked:(KKTitleScrollView *)titleScrollView atIndex:(NSInteger)index{
//    NSLogg(@"KKTitleScrollView--Clicked--%ld",(long)index);
     self.selectedItem = index;
    //滚到对应的Item
    CGPoint position = CGPointMake(index * self.view.width, 0);
    [self.collectView setContentOffset:position animated:YES];
    
}

// setContentOffset这个方法不会调用本方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
//    if ([scrollView isKindOfClass:[UITableView class]]) {
//        
//        if (!self.canTableViewScroll) {
//            scrollView.scrollEnabled = NO;
//            
//        }else{
//            scrollView.scrollEnabled = YES;
//        }
//        
//    
//    }
  
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    // 移动UICollectionView时主scrollView不能动
    if ([scrollView isKindOfClass:[UICollectionView class]]) {//只能判断横向滑动
        self.scrollMainView.scrollEnabled = NO;
//        CGFloat offsetY = scrollView.contentOffset.y;
//        NSLog(@"UICollectionView offsetY--%lf",offsetY);
    }

    
    if ([scrollView isKindOfClass:[UITableView class]]) {

        if (!self.canTableViewScroll) {//NO
            
            [scrollView setContentOffset:CGPointZero];
//             NSLog(@"UITableView setContentOffset CGPointZero");
            
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        
        if (offsetY<0) {//下拉滑到边界--一直置0
            self.canScrollViewScroll = YES;
            [scrollView setContentOffset:CGPointZero];
            self.canTableViewScroll = NO;
//            NSLog(@"UITableView offsetY<0  %lf",offsetY);
        }
      
        
    }
    
    

    if ([scrollView isEqual:self.scrollMainView]) {//底层的那个scrollView
        
        
        //设置滑动时navigationBar颜色
        self.navigationController.navigationBarHidden = NO;
        
        CGFloat offsetY = self.scrollMainView.contentOffset.y;
        CGFloat titleScDeY = self.headerMainView.frame.size.height - KKNavigationBarHeight - kTitleVewHeight;
        self.navigationBarAlpha = offsetY / titleScDeY;
        
        [self.navigationController.navigationBar zz_setBackgroundColor:[HMColor(231, 65, 65, 1) colorWithAlphaComponent:self.navigationBarAlpha]];
        [self.navigationController.navigationBar zz_setElementAlpha:self.navigationBarAlpha withIsNav:YES];
        
//        计算
        CGFloat tabOffsetY = self.headerMainView.frame.size.height -KKNavigationBarHeight - kTitleVewHeight;
        CGFloat scrollViewOffY = self.scrollMainView.contentOffset.y;
        _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
        if (scrollViewOffY>=tabOffsetY) {
//            NSLogg(@"scrollMainView   scrollViewOffY>=tabOffsetY scrollViewContentOffset:%lf",scrollViewOffY);
            self.scrollMainView.contentOffset = CGPointMake(0, tabOffsetY);
            _isTopIsCanNotMoveTabView = YES;
        }else{
//             NSLogg(@"scrollMainView   scrollViewOffY<tabOffsetY scrollViewContentOffset:%lf",scrollViewOffY);
            _isTopIsCanNotMoveTabView = NO;
        }
        
        if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {//状态改变
            if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {//原来能拉 现在不能拉
                self.canTableViewScroll =YES;
                self.canScrollViewScroll = NO;
//                NSLogg(@"!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView");
            }
            if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){//原来不能拉 现在能拉
//                NSLogg(@"_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView");
                if (!self.canScrollViewScroll) {
//                    NSLogg(@"!self.canScrollViewScroll");
                    self.scrollMainView.contentOffset = CGPointMake(0, tabOffsetY);
                }
            }
        }

        
        
    }
    
    
    self.scrollMainView.scrollEnabled = YES;
}







#pragma mark - tableView点击
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLogg(@"tableView--clicked %ld",(long)indexPath.row);
//    
//}




#pragma mark - GetData--获得数据
- (void)getData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        NSString *url = @"http://open3.bantangapp.com/recommend/index?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&last_get_time=1464362873&os_versions=9.2&page=0&pagesize=20&screensize=750&track_device_info=iPhone7%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13";
        
        [HMHttpTool get:url parameters:nil success:^(id json) {
            
//            NSLog(@"json %@",json);
            if (![json[@"msg"] isEqualToString:@"ok"]) {
                [MBProgressHUD showError:@"无法获取错误，请检查网络!"];
            }else{
                //JSON->模型
                KKRecDataModel *model = [KKRecDataModel mj_objectWithKeyValues:json[@"data"]];
//                NSLog(@"model %@",model.mj_keyValues);
                
                //头部图片轮播数据
                NSArray *bnanerArray = model.banner;
                [self.newses addObjectsFromArray:bnanerArray];
                
                
                //TableView头部数据
                NSArray *categoryArray = model.category_element;
                [self.titleArray addObjectsFromArray:categoryArray];
                
                //UICollectionView数据
                NSArray *toArray = model.topic;
                [self.topicsArray addObjectsFromArray:toArray];
                
                
                
                [self setupHeaderWithData];
            }
            
            
            
        } failure:^(NSError *error) {
            
            NSLogg(@"getData--error %@",error);
            
        }];
    });
    
}





#pragma mark - SubVc的数据
- (void)getDataWithID:(NSString *)ID{
    NSString *urlStr = [NSString stringWithFormat:@"http://open3.bantangapp.com/topic/newInfo?app_id=com.jzyd.BanTang&app_installtime=1464188730&app_versions=5.8&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&from_home_rec=0&id=%@&os_versions=9.2&screensize=750&statistics_uv=1&track_device_info=iPhone7%%2C2&track_deviceid=3F91F3E2-708B-431E-AD8D-30FE16E5EFCE&v=13",ID];
    [self httpConnectWithUrl:urlStr];
}

//抽取的方法
#pragma mark - 3种页面 1.网页 头部是一图片，网页放在滚动到图片下方 往上滚动 图片不动且被网页覆盖 article_content type = 2  2.图片和网页一起滚动 article_content  type = 2   前两种是网页  3.清单 图片可以下拉变大 有半糖精选和用户推荐 type = 0;
- (void)httpConnectWithUrl:(NSString *)url{
    
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
            //判断type
//            if ([subDataModel.type isEqualToNumber:[NSNumber numberWithInt:0]]||[subDataModel.type isEqualToNumber:[NSNumber numberWithInt:1]]) {//带产品推荐KKProduct
//                
//                KKProducterViewController *subVc = [[KKProducterViewController alloc] init];
//                [self.navigationController pushViewController:subVc animated:YES];
//                
//                subVc.subDataModel = subDataModel;
//                
//            }if ([subDataModel.type isEqualToNumber:[NSNumber numberWithInt:2]]){//网页
//                
//                KKWebViewController *webVc = [[KKWebViewController alloc] init];
//                [self.navigationController pushViewController:webVc animated:YES];
//                
//                webVc.subDataModel = subDataModel;
//            }

           
            
            
            //设置页面
            
            //            [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic]];
            //            self.titleLable.text = model.title;
            //            self.text.text = model.desc;
            
            //下面加上半糖精选子栏目 product子类的放进去
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        NSLogg(@"listByScene--error %@",error);
        
    }];
    //});
    
    
    
}





#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    self.navigationController.hidesBarsOnSwipe = YES;
//    self.navigationController.barHideOnSwipeGestureRecognizer;
//    self.navigationController.navigationBar.barTintColor = HMColor(228, 57, 65, 0.1);
    
//    self.navigationController.navigationBar.alpha = 1;
    
    
}




@end
