//
//  KKRecDataModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKTopic_recModel.h"
#import "KKCategory_elementModel.h"
#import "KKTopicModel.h"
#import "KKBannerModel.h"

@interface KKRecDataModel : NSObject

@property (nonatomic , strong) NSArray              * category_element;
@property (nonatomic , strong) NSArray              * topic_rec;
@property (nonatomic , strong) NSArray              * topic;
@property (nonatomic , strong) NSArray              * firstpage_element;
@property (nonatomic , strong) NSDictionary         * append_extend;
@property (nonatomic , strong) NSArray              * banner;

@end

/**
 "append_extend": {
 "update_topic_count": "0"
 },
 
 */