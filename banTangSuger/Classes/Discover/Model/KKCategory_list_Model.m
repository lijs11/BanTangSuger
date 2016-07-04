//
//  KKCategory_list_Model.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKCategory_list_Model.h"


@implementation KKCategory_list_Model
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}


@end
