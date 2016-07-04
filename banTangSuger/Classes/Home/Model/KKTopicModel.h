//
//  KKTopicModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKUser.h"
@interface KKTopicModel : NSObject

@property (nonatomic , strong) NSNumber              * is_show_like;
@property (nonatomic , strong) NSNumber              * islike;
@property (nonatomic , copy) NSString              * update_time;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * title;

/**存放的是图片URL*/
@property (nonatomic , strong) NSArray              * pics;

@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * likes;
@property (nonatomic , copy) NSString              * views;
@property (nonatomic , strong) KKUser              * user;


@property (nonatomic,copy) NSString *type_id;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *create_time_str;
/**多少分钟前*/
@property (nonatomic,copy) NSString *order_time_str;


@end

/**
 
 "id": "3391",
 "title": "爆好吃的超人气韩国零食TOP10",
 "type": "",
 "pic": "http://bt.img.17gwx.com/topic/0/33/cVJXZQ/730x389",
 "is_show_like": true,
 "islike": false,
 "likes": "5350",
 "views": "",
 "update_time": "1464354002",
 "user": {},
 "pics": []
 
 */

/**
 
 "user": {
 "user_id": "2140001",
 "nickname": "pauiovelena-七七",
 "avatar": "http://7te7t9.com2.z0.glb.qiniucdn.com/002/14/00/01.jpg?v=1",
 "is_official": 0
 },
 
 
 
 "pics": [
 {
 "url": "http://pic1.bantangapp.com/topic/201605/27/49989750_2140001_0.jpg!300x300"
 },
 {
 "url": "http://pic1.bantangapp.com/topic/201605/27/49485050_2140001_0.jpg!300x300"
 },
 {
 "url": "http://pic1.bantangapp.com/topic/201605/27/97989898_2140001_0.jpg!300x300"
 }
 ]
 
 */