//
//  KKProducterViewController.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKProducterViewController.h"
#import "UINavigationBar+Extension.h"
#import "LoadingView.h"
#import "KKProductTableViewCell.h"

#import "KKHomeScrollView.h"
#import "KKTitleScrollView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "KKWebViewController.h"

/** 顶部图片的高度  */
#define topImageViewHeight  0.55 * HMScreenW
/** TableViewCell的高度  */
#define tableViewCellHeight  88

@interface KKProducterViewController ()<UINavigationControllerDelegate,KKTitleScrollViewDelegate,UIScrollViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)KKHomeScrollView *scrollMainView;
@property (nonatomic,strong)UIView *contentMainView;
@property (nonatomic,strong)UIView *headerMainView;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,assign) CGFloat navigationBarAlpha;

@property (nonatomic,strong)KKTitleScrollView *titleSc;

@property (nonatomic,strong) NSMutableArray *productArray;
@property (nonatomic,assign) BOOL isSecondIndex;
@property (nonatomic,assign) CGSize textSize;

@property (nonatomic, assign) BOOL canScrollViewScroll;
/**TableView不能移动*/
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;

@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@property (nonatomic, assign) BOOL canTableViewScroll;



@end

@implementation KKProducterViewController

- (NSMutableArray *)productArray{
    if (_productArray == nil) {
        self.productArray = [NSMutableArray array];
    }
    return _productArray;
}






#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置滑动时navigationBar颜色
    [self.navigationController.navigationBar zz_setBackgroundColor:[HMColor(231, 65, 65, 1) colorWithAlphaComponent:self.navigationBarAlpha]];
    [self.navigationController.navigationBar zz_setElementAlpha:self.navigationBarAlpha];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.scrollMainView.contentSize = CGSizeMake(self.view.width, 1500);
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar zz_reset];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    [self setNav];
    [self setupTopViews];
//    [LoadingView show];
}


#pragma mark - 设置
- (void)setNav{
    
    //标题
    UILabel *label = [[UILabel alloc]init];
    label.text = @"购物清单";
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    //左
//    UIImage *navLeftImage = [UIImage imageNamed:@"subscribe_icon"];
//    navLeftImage = [navLeftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:navLeftImage style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClicked)];
//    leftItem.imageInsets = UIEdgeInsetsMake(0, -2, 0, 0);
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右
    UIImage *navRightImage1 = [UIImage imageNamed:@"goodsDetail_fav_un"];
    navRightImage1 = [navRightImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:navRightImage1 style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
    
    
    UIImage *navRightImage2 = [UIImage imageNamed:@"goodsDetail_share"];
    navRightImage2 = [navRightImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:navRightImage2 style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
   rightItem2.imageInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    self.navigationItem.rightBarButtonItems = @[rightItem2,rightItem1];
    
    
    
    //contentView
//    self.scrollMainView = [[KKHomeScrollView alloc] init];
//    self.contentMainView = [[UIView alloc] init];
//    self.headerMainView = [[UIView alloc] init];
//    [self.scrollMainView addSubview:self.contentMainView];
//    [self.contentMainView addSubview:self.headerMainView];
//    
//    self.contentMainView.backgroundColor = [UIColor grayColor];
//    self.headerMainView.backgroundColor = [UIColor yellowColor];
    
    
    
    KKHomeScrollView *scrollMainView = [[KKHomeScrollView alloc] init];
    scrollMainView.delegate = self;
    scrollMainView.scrollEnabled = YES;
    scrollMainView.showsVerticalScrollIndicator = NO;
    
    self.scrollMainView = scrollMainView;
    scrollMainView.backgroundColor = [UIColor whiteColor];
    
    
    self.contentMainView = [[UIView alloc] init];
    self.contentMainView.backgroundColor = [UIColor grayColor];
    
    self.headerMainView = [[UIView alloc] init];
    self.headerMainView.backgroundColor = [UIColor whiteColor];
    
    [self.contentMainView addSubview:self.headerMainView];
    [self.scrollMainView addSubview:self.contentMainView];
    [self.view addSubview:self.scrollMainView];
    
   
    
    
    [self.scrollMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollMainView);
        make.width.equalTo(self.scrollMainView);
    }];
    
      
    
    [self.headerMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentMainView);
    }];
    
    
    
}

- (void)leftItemClicked{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)rightItemClicked{
    
    
    
}

- (void)setupTopViews{
    
    //图片
    self.topImageView = [[UIImageView alloc] init];
    [self.contentMainView addSubview:self.topImageView];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.headerMainView);
        make.height.mas_equalTo(HMScreenW * 0.55);
    }];
    
    
}

- (void)setSubDataModel:(KKSubDataModel *)subDataModel{
    _subDataModel = subDataModel;
 [self setupData];
    
}




#pragma mark - 传入数据
- (void)setupData{
    
    
    //1.图片
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.subDataModel.share_pic]];
    
    //2.文本框
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:KKLightFont size:17];
//    label.layer.borderColor=[UIColor redColor].CGColor;
    [self.headerMainView addSubview:label];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.selectable = NO;
    textView.delegate = self;
    self.textView = textView;
    textView.font = [UIFont fontWithName:KKThinFont size:13];
    textView.backgroundColor = [UIColor whiteColor];
    [self.headerMainView addSubview:textView];
    
    
    //赋值
    label.text = self.subDataModel.title;
    textView.text = self.subDataModel.desc;
    
    CGSize textSize = [self sizeWithText:self.subDataModel.desc font:[UIFont fontWithName:KKThinFont size:14] maxSize:CGSizeMake(self.view.width, 1000)];
    self.textSize = textSize;
//    CGSize textSize = [self.subDataModel.desc sizeWithAttributes: @{NSFontAttributeName: [UIFont fontWithName:@"AppleGothic" size:17]}];
//    
//    CGSize textSize = [self.subDataModel.desc sizeWithFont: textView.font constrainedToSize:CGSizeMake(self.view.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    //自动布局
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.headerMainView).offset(13);
        make.trailing.mas_equalTo(self.headerMainView);
        make.height.mas_equalTo(20);
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.leading.equalTo(self.headerMainView).offset(10);
        make.trailing.equalTo(self.headerMainView).offset(-10);
        make.height.mas_equalTo(textSize.height + 20);
    }];
    
//    NSLogg(@"label %lf %lf  %lf  %lf",label.width,label.height,label.x,label.y);

    [self.headerMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textView.mas_bottom);
    }];
    
    
    //3.Tab Product的数据
    NSArray *proArray = self.subDataModel.product;
    [self.productArray addObjectsFromArray:proArray];
    
    if (self.productArray.count > 0) {//更新Tab
        [self setupTabViews];
    }
    
    
    
}



- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




#pragma mark - 更新Tab
- (void)setupTabViews{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = YES;
    self.tableView = tableView;
    
    self.tableView.estimatedRowHeight = 700;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //注册
 //   [tableView registerClass:[KKProductTableViewCell class] forCellReuseIdentifier:@"productTableViewCell"];
    
    [self.contentMainView addSubview:self.tableView];
    
    
    

    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerMainView.mas_bottom);
        make.leading.trailing.equalTo(self.contentMainView);
        make.bottom.mas_equalTo(self.contentMainView.mas_bottom).offset(-25);
    }];

    

//    NSLogg(@"tableView %lf",self.headerMainView.y);
    
    
    [self.contentMainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.headerMainView.mas_bottom).offset(self.productArray.count * tableViewCellHeight);
         make.bottom.mas_equalTo(self.headerMainView.mas_bottom).offset(HMScreenH - 64 - 49);
    }];
    
    
}

- (void)titleScrollViewDidClicked:(KKTitleScrollView *)titleScrollView atIndex:(NSInteger)index{
    
    if (index == 1) {//用户推荐
        self.isSecondIndex = YES;
    }else{//半糖精选
        self.isSecondIndex = NO;
    }
    NSLogg(@"点击了第%ld个按钮",index);
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.productArray.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.创建cell
//    static NSString *ID = @"setting";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"1234576--------%ld",(long)indexPath.row];
//    return cell;
//    
//    KKProductTableViewCell *cell = (KKProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"productTableViewCell" forIndexPath:indexPath];
//    cell.productModel = nil;
//    if (cell == nil) {
//        cell = [[KKProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"productTableViewCell"];
//    }
    
    KKProductTableViewCell *cell = [KKProductTableViewCell cellWithTableView:tableView];    
    cell.product_pic_host = self.subDataModel.product_pic_host;//在产品赋值前面
    cell.user_avatr_host = self.subDataModel.user_avatr_host;//头像也在前
    cell.productModel = self.productArray[indexPath.row];    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    return [tableView fd_heightForCellWithIdentifier:@"productTableViewCell" configuration:^(KKProductTableViewCell *cell) {
//        
//        cell.product_pic_host = self.subDataModel.product_pic_host;//在产品赋值前面
//        cell.user_avatr_host = self.subDataModel.user_avatr_host;//头像也在前
//        cell.productModel = self.productArray[indexPath.row];
//        
//    } ];
    
  //  return 900;
    
    KKProductModel *productModel = self.productArray[indexPath.row];
    NSLogg(@"%lf",productModel.cellHeight);
    return productModel.cellHeight;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, self.tableView.width, 44);
    bgView.backgroundColor = [UIColor whiteColor];

    KKTitleScrollView *titleSc = [[KKTitleScrollView alloc] initWithTitleArray:@[@"半糖精选",@"用户推荐"] titleSubWidth:self.view.width * 0.5];
    titleSc.delegate = self;
    titleSc.frame = CGRectMake(0, 0, self.view.width, 44);
    self.titleSc = titleSc;

    [bgView addSubview:titleSc];
    return  bgView;

    
}


#pragma mark - tableView 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKWebViewController *wbeVc = [[KKWebViewController alloc] init];
    [self.navigationController pushViewController:wbeVc animated:YES];
    
     KKProductModel *productModel = self.productArray[indexPath.row];
     wbeVc.urlStr = productModel.url;
    
}




#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {//只能判断横向滑动
        self.scrollMainView.scrollEnabled = NO;
        //        CGFloat offsetY = scrollView.contentOffset.y;
        //        NSLog(@"UICollectionView offsetY--%lf",offsetY);
    }
    
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
        if (!self.canTableViewScroll) {//NO
            
            [scrollView setContentOffset:CGPointZero];
 //            NSLog(@"UITableView //NO CGPointZero");
            
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        
        
        //NSLogg(@"UITableView offsetY %lf",offsetY);
        if (offsetY<0) {//下拉滑到边界--一直置0
            self.canScrollViewScroll = YES;
  //           NSLogg(@"1 ScrollViewScroll = YES");
            [scrollView setContentOffset:CGPointZero];
            self.canTableViewScroll = NO;
  //           NSLog(@"UITableView CGPointZero offsetY<0  %lf",offsetY);
  //           NSLogg(@"1 TableViewScroll = NO");
        }
        
        
    }
    
    
    
    if ([scrollView isEqual:self.scrollMainView]) {//底层的那个scrollView
    
    //高度
   // 图片 HMScreenW * 0.55 //间距10 Label 20 textView self.textSize + 20
    
    //设置滑动时navigationBar颜色
    self.navigationController.navigationBarHidden = NO;
    
    CGFloat offsetY = self.scrollMainView.contentOffset.y;
    CGFloat titleScDeY = CGRectGetMaxY(self.headerMainView.frame) - 64;
    
//    NSLog(@"titleScDeY %lf   offsetY %lf",titleScDeY,offsetY);
    
    self.navigationBarAlpha = MIN(1,offsetY/titleScDeY);
    
    [self.navigationController.navigationBar zz_setBackgroundColor:[HMColor(231, 65, 65, 1) colorWithAlphaComponent:self.navigationBarAlpha]];
    [self.navigationController.navigationBar zz_setElementAlpha:self.navigationBarAlpha];
    
    
       // 计算
//        CGFloat tabOffsetY = HMScreenW * 0.55 + 50 + self.textSize.height - 64;
        CGFloat tabTopY = CGRectGetMaxY(self.headerMainView.frame) - 64;
        CGFloat scrollViewOffY = self.scrollMainView.contentOffset.y;
        
//         NSLogg(@"scrollViewOffY:%lf tabOffsetY:%lf",scrollViewOffY,tabTopY);
        
        //计算TopImage Frame
        if (scrollView.contentOffset.y  < 0) {
//            NSLogg(@"scrollView.contentOffset.y:%lf",scrollView.contentOffset.y);
            CGFloat bigImageH =  HMScreenW * 0.55 - scrollView.contentOffset.y;
            CGFloat scale = bigImageH / (HMScreenW * 0.55);
            self.topImageView.frame = CGRectMake(-(HMScreenW * scale - HMScreenW) * 0.5, scrollView.contentOffset.y, HMScreenW * scale, bigImageH);
        }else{
//            NSLogg(@"scrollView.contentOffset.y:%lf",scrollView.contentOffset.y);
            self.topImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.topImageView.frame), CGRectGetHeight(self.topImageView.frame));
        }
        
        
        
        
        //计算TableView何时滚动
        _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
        if (scrollViewOffY>=tabTopY) {
 //            NSLogg(@"scrollMainView   scrollViewOffY>=tabOffsetY scrollViewContentOffset:%lf",scrollViewOffY);
            self.scrollMainView.contentOffset = CGPointMake(0, tabTopY + 0.2);
            _isTopIsCanNotMoveTabView = YES;
//             NSLogg(@"_isTopIsCanNotMoveTabView = YES");
        }else{
//             NSLogg(@"scrollMainView   scrollViewOffY<tabOffsetY scrollViewContentOffset:%lf",scrollViewOffY);
            _isTopIsCanNotMoveTabView = NO;
 //             NSLogg(@"_isTopIsCanNotMoveTabView = NO");
        }
        
        if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {//状态改变
            if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {//ScrollView不动 TableView动
                self.canTableViewScroll =YES;
                self.canScrollViewScroll = NO;
 //                NSLogg(@"2 TableViewScroll =YES;ScrollViewScroll = NO");
            }
            if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){//原来不能拉 现在能拉
  //               NSLogg(@"_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView");
                if (!self.canScrollViewScroll) {
  //                   NSLogg(@"2 ScrollViewScroll = NO  SetscrollMainView");
                    self.scrollMainView.contentOffset = CGPointMake(0, tabTopY + 0.2);
                }
            }
        }
        
        
    }
    
    
    
    self.scrollMainView.scrollEnabled = YES;
    
}






@end
