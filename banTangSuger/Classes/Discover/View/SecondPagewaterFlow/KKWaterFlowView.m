//
//  KKWaterFlowView.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKWaterFlowView.h"
#import "KKWaterFlowCell.h"
#import "KKPageCollectionView.h"
#import "KKHeaderReusableView.h"
#import "KKWebViewController.h"
@interface KKWaterFlowView()<UICollectionViewDataSource,UICollectionViewDelegate>

/**头部*/
@property (nonatomic,strong) KKHeaderReusableView *headerView;
@end

@implementation KKWaterFlowView



/*UIcollectionView 懒加载**/
- (UICollectionView *)collectView{
    if (_collectView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake(120,120);
        //        layout.itemSize = CGSizeMake(self.view.width, 5 * 250);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //        layout.headerReferenceSize = CGSizeZero;
        //        layout.footerReferenceSize = CGSizeZero;
        
        self.collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectView.pagingEnabled = NO;
        self.collectView.backgroundColor = [UIColor whiteColor];
        self.collectView.delegate = self;
        self.collectView.dataSource = self;
        self.collectView.bounces = NO;//默认YES
        self.collectView.showsHorizontalScrollIndicator = NO;
        //self.collectView.scrollEnabled = NO;
        //注册cell
        [self.collectView registerNib:[UINib nibWithNibName:@"KKWaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"KKWaterFlowID"];
        //注册Header
        [self.collectView registerClass:[KKHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        
    }
    
    return _collectView;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectView];
        
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
     
        
    }
    return self;
}

#pragma mark - UICollectionView--Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hotRecommends.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KKWaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKWaterFlowID" forIndexPath:indexPath];
    KKHotRecommendModel *recommendModel = self.hotRecommends[indexPath.item];
    cell.recommendModel = recommendModel;
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return self.collectView.bounds.size;
//}


//分组标题
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        KKHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        self.headerView = headerView;
        reusableview = headerView;
    }
    
    return reusableview;
}
//分组标题
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(HMScreenW,330);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    KKWebViewController *wbeVc = [[KKWebViewController alloc] init];
    [self.navgationCC pushViewController:wbeVc animated:YES];
    
    KKHotRecommendModel *recommendModel = self.hotRecommends[indexPath.item];
    wbeVc.urlStr = recommendModel.share_url;
    
    
    
    }









- (void)setCategory_lists:(NSMutableArray *)category_lists{
    
    _category_lists = category_lists;
    
    self.headerView.pageCollView.category_lists = category_lists;
    
}

- (void)setHotRecommends:(NSMutableArray *)hotRecommends{
    
    _hotRecommends = hotRecommends;
    [self.collectView reloadData];
    
}



@end
