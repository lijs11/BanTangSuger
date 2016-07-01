//
//  KKHomeTableViewCell.h
//  banTangSuger
//
//  Created by Kenny.li on 16/6/2.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTopicModel.h"
@interface KKHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (nonatomic,strong) KKTopicModel *topic;

@end
