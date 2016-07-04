//
//  KKPageCollectionView.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//  

#import "KKPageCollectionView.h"
#import "KKPageCollectionViewCell.h"

@interface KKPageCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end


@implementation KKPageCollectionView


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
        self.collectView.showsHorizontalScrollIndicator = NO;        
        
        //        [self.collectView registerNib:[UINib nibWithNibName:@"KKHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKHomeCollectionViewCellID"];
        [self.collectView registerNib:[UINib nibWithNibName:@"KKPageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"kkpageCollID"];
        
    }
    
    return _collectView;
}

- (UIPageControl *)pageControlView{
    
    if (_pageControlView == nil) {
        self.pageControlView = [[UIPageControl alloc] init];
        self.pageControlView.numberOfPages = 2;
        self.pageControlView.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageControlView.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControlView.userInteractionEnabled = NO;
    }
    return _pageControlView;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       // self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.collectView];
        [self addSubview:self.pageControlView];
        
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
           // make.edges.equalTo(self);
        }];
        [self.pageControlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.collectView.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self.collectView.centerX);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

#pragma mark - UICollectionView--Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KKPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kkpageCollID" forIndexPath:indexPath];
    
    NSMutableArray *lists = [NSMutableArray array];
    NSUInteger count = self.category_lists.count;
    
    for (NSUInteger i = 0; i < 6; i++) {
        
        NSUInteger j = i + indexPath.item * 6 ;
        if (j< count) {
            KKCategory_list_Model *model = self.category_lists[j];
            [lists addObject:model];
          //  NSLog(@"i %lu j %lu",(unsigned long)(i),(unsigned long)(j));
        }
        
        
    }
    
    cell.category_lists = lists;
    
    
        return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectView.bounds.size;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
     if ([scrollView isKindOfClass:[UICollectionView class]]) {
    
    int currentPage = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width  + 0.5);
   // NSLogg(@"scrollView.contentOffset.x %lf scrollView.bounds.size.width  %lf",scrollView.contentOffset.x,scrollView.bounds.size.width);
    self.pageControlView.currentPage = currentPage;
    
  //  NSLogg(@"index %d",currentPage);
    
      }
    
    
}



- (void)setCategory_lists:(NSMutableArray *)category_lists{
    
    _category_lists = category_lists;
    
    [self.collectView reloadData];
    
}







@end
