//
//  KKRecDataModel.m
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKRecDataModel.h"

@implementation KKRecDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
    
    
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"category_element" : [KKCategory_elementModel class],@"topic_rec" : [KKTopic_recModel class],@"topic" : [KKTopicModel class],@"banner" : [KKBannerModel class]};
}

//#import "KKTopic_recModel.h"
//#import "KKCategory_elementModel.h"
//#import "KKTopicModel.h"
//#import "KKBannerModel.h"

//@property (nonatomic , strong) NSArray              * category_element;
//@property (nonatomic , strong) NSArray              * topic_rec;
//@property (nonatomic , strong) NSArray              * topic;
//@property (nonatomic , strong) NSArray              * firstpage_element;
//@property (nonatomic , strong) NSDictionary         * append_extend;
//@property (nonatomic , strong) NSArray              * banner;


@end
