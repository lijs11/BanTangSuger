//
//  KKPageCollectionViewCell.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKCategory_list_Model.h"

@interface KKPageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIButton *btn5;

@property (weak, nonatomic) IBOutlet UIButton *btn6;


@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;
@property (weak, nonatomic) IBOutlet UIImageView *imageV4;
@property (weak, nonatomic) IBOutlet UIImageView *imageV5;
@property (weak, nonatomic) IBOutlet UIImageView *imageV6;






/**头部分类*/
@property (nonatomic,strong)NSMutableArray *category_lists;

@end
