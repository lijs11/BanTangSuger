//
//  KKBannerModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKBannerModel : NSObject

/** 活动链接 */
@property (nonatomic , copy) NSString              * extend;
@property (nonatomic , copy) NSString              * sub_title;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * topic_type;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * photo;
@property (nonatomic , strong) NSNumber              * index;

@end


/**
 "id": "798",
 "title": "收纳能手",
 "sub_title": "",
 "type": "topic_list",
 "topic_type": "",
 "photo": "http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201605/48545554.jpg?v=1464335872",
 "extend": "2145,2077,2098,1968,1914,1642,1470",
 "index": 46
 
 
 */