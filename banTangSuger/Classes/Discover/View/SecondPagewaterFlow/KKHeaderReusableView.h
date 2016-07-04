//
//  KKHeaderReusableView.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPageCollectionView.h"


@interface KKHeaderReusableView : UICollectionReusableView

@property (nonatomic,strong)UILabel *pageHeadLabel;
@property (nonatomic,strong)UIView *pageHeaderView;
@property (nonatomic,strong)UIImageView *pageImageV;
@property (nonatomic,strong)KKPageCollectionView *pageCollView;


@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UIImageView *imageV;



@end
