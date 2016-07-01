//
//  KKImageScroller.m
//  KKImageScroller
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//
#define  HMCellIdentifier  @"news"
#define HMMAXSections 3

#import "KKImageScroller.h"
#import "KKImageModel.h"
#import "MJExtension.h"
#import "KKImageCollectionViewCell.h"
#import "UIView+Extension.h"
#import "KKBannerModel.h"

@interface KKImageScroller()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSArray *newses;

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSTimeInterval timeInterval;



@end



@implementation KKImageScroller

#pragma mark - 初始化


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//    [self setupViews];
//    }
//    return self;
//}
//


- (instancetype)init{
    
    if (self = [super init]) {
    [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout = layout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;//这个属性自动page
    
    
    self.collectionView = collectionView;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.hidesForSinglePage = YES;
//    pageControl.tintColor = [UIColor redColor];
    
    [self addSubview:collectionView];
    [self insertSubview:pageControl aboveSubview:collectionView];
//    self.pageControl.backgroundColor = [UIColor grayColor];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HMCellIdentifier];
    
    
    self.timeInterval = 2.5;
    
    
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    self.pageControl.frame = CGRectMake(10, 10, 100, 27);
    self.pageControl.centerX = self.centerX;
    self.pageControl.y = self.height - self.pageControl.height - 10;
    
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.sectionInset = UIEdgeInsetsZero;
    
    self.layout.itemSize = CGSizeMake(self.width, self.height);
    
    NSLog(@"self.layout.itemSize-----------%f,%f",self.layout.itemSize.width,self.layout.itemSize.height);
}




- (void)removeTimer{
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
  
    
}



- (void)addTimer{
    
    [self removeTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
    
}


/**回到中间*/
- (NSIndexPath *)returnToMidSection{
    //当前组的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    //每次返回中间组
    NSIndexPath *midIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:HMMAXSections / 2];
    [self.collectionView scrollToItemAtIndexPath:midIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    NSLog(@"midIndexPath %@",midIndexPath);
    return midIndexPath;
    
}


- (void)nextPage{
    
    NSIndexPath *midIndexPath = [self returnToMidSection];
    
    //计算下一组的位置
    NSInteger nextItem = midIndexPath.item + 1;
    NSInteger nextSection = midIndexPath.section;
    if (nextItem == self.newses.count) {//如果这个section满了，跳到下一个
        nextItem = 0;
        nextSection++;
    }
    
    
    NSIndexPath *nextPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    //移动的下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.newses.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return HMMAXSections;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HMCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageUrl = self.newses[indexPath.item];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.newses.count == 0) return;
    if ([self.delegate respondsToSelector:@selector(imageScroller:didClickedAtIndex:)]) {
        [self.delegate imageScroller:self didClickedAtIndex:indexPath.row];
    }
    
    
}



#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.newses.count == 0) return;
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.newses.count == 0) return;
    
        int currentPage = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
        self.pageControl.currentPage = currentPage;
    
    
    //NSLog(@"%d",currentPage);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    int currentPage = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentPage inSection:HMMAXSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    if (self.newses.count == 0) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];//刚拖完不加 1s后再加动画
    });
    
    
}

//可以把section放大 没有必要用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.newses.count == 0) return;
    //松开减速--没有动画 最后一个会返回中间第一个 有动画很突兀
   [self returnToMidSection];
    
}




#pragma mark - 设置方法
- (void)setImageScrollerWithImages:(NSMutableArray *)images{
   
        self.newses = images;
        if (images.count == 0 ) return;
        self.pageControl.numberOfPages = self.newses.count;
        [self.collectionView reloadData];
    
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:HMMAXSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self addTimer];
}

- (void)setImageScrollerWithImages:(NSMutableArray *)images time:(NSTimeInterval)timeInterval{
    
        self.newses = images;
     if (images.count == 0 ) return;
    
        self.timeInterval = timeInterval;
        if (timeInterval < 0.1) {
             self.timeInterval = 2.5;
         }
    
        self.pageControl.numberOfPages = self.newses.count;
        [self.collectionView reloadData];
    

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:HMMAXSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self addTimer];
    
}







@end
