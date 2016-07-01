//
//  KKUser.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKUser : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *nickname;
/**头像*/
@property (nonatomic,copy) NSString *avatar;

@property (nonatomic,assign) BOOL is_official;

@end

/**
 
 "user": {
 "user_id": "2140001",
 "nickname": "pauiovelena-七七",
 "avatar": "http://7te7t9.com2.z0.glb.qiniucdn.com/002/14/00/01.jpg?v=1",
 "is_official": 0
 },

*/