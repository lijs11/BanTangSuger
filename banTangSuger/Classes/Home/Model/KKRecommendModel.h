//
//  KKRecommendModel.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKRecommendModel : NSObject

@property (nonatomic , strong) NSNumber              * status;
@property (nonatomic , strong) NSNumber              * ts;
@property (nonatomic , strong) NSDictionary         * data;
@property (nonatomic , copy) NSString              * msg;

@end
