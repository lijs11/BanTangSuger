//
//  KKSubDataModel.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKSubDataModel.h"
#import "KKProductModel.h"
@implementation KKSubDataModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"product" : [KKProductModel class]};
}

MJCodingImplementation
@end
