//
//  KKSubDataModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/6/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKSubDataModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , strong) NSNumber              *category;
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *desc;
@property (nonatomic , copy) NSNumber              * type;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * likes;
@property (nonatomic , copy) NSString              * islike;
@property (nonatomic , copy) NSString              * tag_ids;
@property (nonatomic , copy) NSString              * tags;
@property (nonatomic , copy) NSString              * share_url;
@property (nonatomic , copy) NSString              * share_pic;
@property (nonatomic , copy) NSString              * product_pic_host;
@property (nonatomic , copy) NSString              * user_avatr_host;
@property (nonatomic , strong) NSDictionary        * activity;


@property (nonatomic , strong) NSArray             *product;

@end


/**
 "id": 3870,
 "category": 14,
 "title": "最适合夏季使用的高人气面膜",
 "desc": "夏日里肌肤要经受更多的伤害，不管是紫外线的照射，还是每天出汗后混着化妆品对面部的刺激，有必要每周1~2次的面膜舒缓一下肌肤。那么夏季面膜怎么选呢？小糖君为大家挑选适合夏天使用的面膜，每款都是高人气好口碑！",
 "type": "0",
 "pic": "http:\/\/bt.img.17gwx.com\/topic\/0\/38\/cVlZZA\/600x330?v=2",
 "likes": "26700",
 "islike": false,
 "tag_ids": "45,238,1389",
 "tags": "面膜,美白,美妆",
 "share_url": "http:\/\/m.ibantang.com\/topic\/detail\/3870\/",
 "share_pic": "http:\/\/bt.img.17gwx.com\/topic\/0\/38\/cVlZZA\/600x330?v=2",
 "product_pic_host": "http:\/\/bt.img.17gwx.com\/",
 "user_avatr_host": "http:\/\/7te7t9.com2.z0.glb.qiniucdn.com\/",
 "activity": {},
 "product": [{
 */