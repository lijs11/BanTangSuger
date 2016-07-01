//
//  KKTopic_recModel.m
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKTopic_recModel.h"

@implementation KKTopic_recModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}




@end
