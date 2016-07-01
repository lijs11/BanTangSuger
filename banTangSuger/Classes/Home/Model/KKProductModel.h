//
//  KKProductModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/6/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKProductModel : NSObject

@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              *topic_id;
@property (nonatomic , strong) NSNumber              *category;
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *desc;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              *iscomments;
@property (nonatomic , copy) NSString              *comments;

@property (nonatomic , copy) NSString              * likes;
@property (nonatomic , copy) NSString              * islike;

@property (nonatomic , copy) NSArray          * pic;
@property (nonatomic , copy) NSArray          * likes_list;

//单元格的高度
@property(nonatomic,assign) CGFloat cellHeight;

@end


/**
 "id": "178520",
 "topic_id": "3870",
 "category": 1,
 "title": "SK-II “前男友”护肤面膜",
 "desc": "大名鼎鼎的前男友面膜，遇到前男友甩他一脸嫩嫩肌肤，老娘过的好着呢！一次就能给足肌肤10倍Pitera的滋润，保湿补水、提亮肤色，同时细致毛孔和紧致。面膜纸则是采用柔软的棉质质地，如果需要应急补救连敷两天或者晚早一片绝对能让你嫩到爆。",
 "price": "42.5",
 "url": "http:\/\/s.click.taobao.com\/t?e=m%3D2%26s%3DVRw5T3WuaM9w4vFB6t2Z2ueEDrYVVa64XoO8tOebS%2BdRAdhuF14FMatApUVq6bp5xq3IhSJN6GQSCaKErieudzDk0PPeYwvvyUPcP7QvvKoJYf%2Fg8IP1YmPJLBziAmVvWeJ9HtN6q5JVvIW9BvrxNcFYPL%2BbxJbgL%2BjF7ADwwNxF455t14CDeHyoKieWtMz3Xvxzv%2BPHfnRxKmPmpIKZsA%3D%3D&unid=bantangapp",
 "iscomments": false,
 "comments": "4",
 "islike": false,
 "likes": "3764",
 "item_id": "2598704720",
 "platform": "1",
 "pic": [{
 "p": "product1\/17\/85\/c1ZWYVNe\/w600",
 "w": 900,
 "h": 900
 }],
 "likes_list": [{
 "u": 1691465,
 "a": "001\/69\/14\/65.jpg"
 }, {
 "u": 221927,
 "a": "000\/22\/19\/27.jpg"
 }, {
 "u": 2273480,
 "a": "002\/27\/34\/80.jpg"
 }, {
 "u": 453785,
 "a": "000\/45\/37\/85.jpg"
 }, {
 "u": 2005908,
 "a": "002\/00\/59\/08.jpg"
 }, {
 "u": 1873431,
 "a": "001\/87\/34\/31.jpg"
 }, {
 "u": 1727433,
 "a": "001\/72\/74\/33.jpg"
 }, {
 "u": 2251511,
 "a": "002\/25\/15\/11.jpg"
 }, {
 "u": 1930146,
 "a": "001\/93\/01\/46.jpg"
 }, {
 "u": 1895571,
 "a": "001\/89\/55\/71.jpg"
 }]
 },
 
 
 
 */