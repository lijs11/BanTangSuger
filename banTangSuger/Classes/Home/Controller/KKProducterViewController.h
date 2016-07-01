//
//  KKProducterViewController.h
//  banTangSuger
//
//  Created by Kenny.li on 16/6/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTopicModel.h"
#import "KKSubDataModel.h"
@interface KKProducterViewController : UIViewController

@property (nonatomic,strong)KKTopicModel *topic;

@property (nonatomic,strong)KKSubDataModel *subDataModel;

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UITableView *tableView;

@end
