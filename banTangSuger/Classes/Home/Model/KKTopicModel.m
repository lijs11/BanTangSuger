//
//  KKTopicModel.m
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKTopicModel.h"

@implementation KKTopicModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
   
}

	
MJCodingImplementation

@end


