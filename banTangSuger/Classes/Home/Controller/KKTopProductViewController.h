//
//  KKTopProductViewController.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKBannerModel.h"
#import "KKTopicModel.h"
@interface KKTopProductViewController : UITableViewController

@property (nonatomic,strong) NSArray *topics;

@property (nonatomic,strong)KKBannerModel *bamodel;
@end
