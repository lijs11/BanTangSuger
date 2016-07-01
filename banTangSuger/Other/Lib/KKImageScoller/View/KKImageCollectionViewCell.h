//
//  KKImageCollectionViewCell.h
//  KKImageScroller
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKImageModel;
@interface KKImageCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,strong)KKImageModel *imageModel;
@end
