//
//  KKDiscTableViewCell.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTopicModel.h"
@interface KKDiscTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *headerV;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *dateL;


@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UILabel *viewsV;
@property (weak, nonatomic) IBOutlet UILabel *likesV;


@property (nonatomic,strong) KKTopicModel *topic;

@end
