//
//  KKTopic_recModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKUser.h"
@interface KKTopic_recModel : NSObject

@property (nonatomic , strong) NSNumber              * is_show_like;
@property (nonatomic , strong) NSNumber              * islike;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * likes;
@property (nonatomic , copy) NSString              * trace_id;
@property (nonatomic , strong) KKUser              * user;

@end


/**
 
 {
 "id": "421",
 "title": "10款靠谱的电吹风",
 "type": "",
 "pic": "http://bt.img.17gwx.com/topic/0/4/dlNf",
 "is_show_like": true,
 "islike": false,
 "likes": "21570",
 "user": {},
 "trace_id": "main_rec#main#c1248ad0-242b-11e6-a480-afae987bd0ea"
 },
 
 */