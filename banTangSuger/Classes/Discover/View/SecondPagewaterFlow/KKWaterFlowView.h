//
//  KKWaterFlowView.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKWaterFlowView : UIView
@property (nonatomic,strong)UICollectionView *collectView;

/**头部分类*/
@property (nonatomic,strong)NSMutableArray *category_lists;
/**waterFlow分类*/
@property (nonatomic,strong)NSMutableArray *hotRecommends;

@property (nonatomic,strong)UINavigationController *navgationCC;

@end
