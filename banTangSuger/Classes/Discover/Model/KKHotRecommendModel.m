//
//  KKHotRecommendModel.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKHotRecommendModel.h"

@implementation KKHotRecommendModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}





@end
