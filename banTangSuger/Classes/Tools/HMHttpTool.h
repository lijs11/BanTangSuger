//
//  HMHttpTool.h
//  真的是微博
//
//  Created by Kenny.li on 16/1/18.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HMHttpTool : NSObject

/**
 *
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */



/**发送一个GET请求*/
+ (void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id ))success failure: (void(^)(NSError *error))failure;
/**发送一个POST请求*/
+ (void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id ))success failure: (void(^)(NSError *error))failure;



@end
