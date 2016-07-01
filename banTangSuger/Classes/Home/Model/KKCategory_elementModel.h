//
//  KKCategory_elementModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKCategory_elementModel : NSObject

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
 {
 "id": "612",
 "title": "一周最热",
 "sub_title": "",
 "type": "topic_list",
 "topic_type": "",
 "photo": "",
 "extend": "3142,3299,3138,3254,3177,3149,3216,3191,3144,3171,3233",
 "index": 144
 },
 
 */