//
//  KKSavingTool.h
//  banTangSuger
//
//  Created by Kenny.li on 16/6/4.
//  Copyright © 2016年 KK. All rights reserved.
//  存储的是模型

#import <Foundation/Foundation.h>
#import "KKTopicModel.h"

@interface KKSavingTool : NSObject

//加载历史
- (NSMutableArray *)readHistoryTopicWithRow:(NSInteger)row;

- (void)saveHistoryTopic:(NSArray *)historyTopics WithRow:(NSInteger)row;
- (void)unsaveHistoryTopic:(NSArray *)historyTopics WithRow:(NSInteger)row;//这个功能暂时不需要

+ (instancetype)sharedSavingTool;

@end
