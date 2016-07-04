//
//  KKPageCollectionView.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//  button 70 pading 6  228 + 30;

#import <UIKit/UIKit.h>

@interface KKPageCollectionView : UIView
@property (nonatomic,strong)UICollectionView *collectView;
@property (nonatomic,strong)UIPageControl *pageControlView;



/**头部分类*/
@property (nonatomic,strong)NSMutableArray *category_lists;

@end
