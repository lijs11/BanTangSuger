//
//  KKHotRecommendModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKUser.h"
@interface KKHotRecommendModel : NSObject
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * author_id;
@property (nonatomic , copy) NSString              * relation_id;
@property (nonatomic , copy) NSString              * share_url;
@property (nonatomic , copy) NSString              * is_recommend;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * publish_time;
@property (nonatomic , copy) NSString              * datetime;
@property (nonatomic , copy) NSString              * datestr;
@property (nonatomic , copy) NSString              * mini_pic_url;
@property (nonatomic , copy) NSString              * middle_pic_url;
@property (nonatomic , strong) NSArray               * tags;
@property (nonatomic , strong) KKUser                * author;
@property (nonatomic , strong) NSArray               * pics;
@property (nonatomic , strong) NSDictionary          * dynamic;
@property (nonatomic , strong) NSArray               * product;
@property (nonatomic , strong) NSArray               * comments;
@end

/**
 
 [{
 "id": "137065",
 "content": "\u770b\u5230\u5305\u88c5\u4e0a\u76848\u5c31\u77e5\u9053\u6709\u591a\u6c34\u6da6\u4fdd\u6e7f\u5566\uff5e\u6c34\u6da6\u516b\u5c0f\u65f6 \u6ca1\u6709\u989c\u8272 \u4e5f\u6ca1\u6709\u4ec0\u4e48\u9999\u5473 \u5c31\u662f\u4e13\u4e00\u4fdd\u6e7f\u7684\u4e00\u6b3e\u5507\u818f(=\uff9f\u03c9\uff9f)\uff89\u753b\u5507\u5986\u4e4b\u524d\u7528\u6765\u6253\u5e95\u5f88\u597d \u5634\u5507\u4e0d\u4f1a\u5e72\u76ae\u8d77\u76ae \u597d\u50cf\u662f\u6709\u51e1\u58eb\u6797\u7684\u6210\u5206 \u7761\u524d\u62b9\u7b2c\u4e8c\u5929\u8d77\u6765\u89c9\u5f97\u5f88\u6da6 \u5e73\u65f6\u51fa\u95e8\u7528\u4e5f\u5f88\u597d",
 "author_id": "292930",
 "relation_id": "",
 "share_url": "http:\/\/m.ibantang.com\/post\/detail\/137065\/",
 "is_recommend": "1",
 "create_time": "1467252596",
 "publish_time": "1467252730",
 "datetime": "1467252730",
 "datestr": "06-30 10:12",
 "mini_pic_url": "http:\/\/pic1.bantangapp.com\/post\/201606\/30\/511001018512_292930_1.jpg!w200",
 "middle_pic_url": "http:\/\/pic1.bantangapp.com\/post\/201606\/30\/511001018512_292930_1.jpg!w300",
 "tags": [{
 "id": "541",
 "name": "\u6742\u8d27"
 }, {
 "id": "1389",
 "name": "\u7f8e\u5986"
 }, {
 "id": "13693",
 "name": "\u5507\u90e8\u5f69\u5986"
 }, {
 "id": "1916",
 "name": "\u6da6\u5507\u818f"
 }],
 "author": {
 "user_id": "292930",
 "nickname": "Doppelgangersssss",
 "avatar": "http:\/\/7te7t9.com2.z0.glb.qiniucdn.com\/000\/29\/29\/30.jpg?v=10",
 "is_official": 0
 },
 "pics": [{
 "url": "http:\/\/pic1.bantangapp.com\/post\/201606\/30\/511001018512_292930_1.jpg!w600",
 "tags": "[{\"y\":0.3706667,\"text1\":\"\\u4f0a\\u4e3d\\u838e\\u767d\\u96c5\\u987f\\u6da6\\u5507\\u818f\",\"tagType\":9,\"x\":0.4426667}]",
 "width": 900,
 "height": 900
 }],
 "dynamic": {
 "comments": "0",
 "likes": "9",
 "is_collect": false,
 "is_like": false,
 "is_comment": false
 },
 "product": [],
 "comments": []
	},
 */