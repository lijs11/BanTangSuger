//
//  KKSavingTool.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/4.
//  Copyright © 2016年 KK. All rights reserved.
//

//自定义路径 用户浏览历史
#define KKHistoryTopicsFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]



#import "KKSavingTool.h"

@interface KKSavingTool()
@property (nonatomic,strong)NSMutableArray *historyTopicsArray;
@end


@implementation KKSavingTool

- (NSMutableArray *)historyTopicsArray{
    if (_historyTopicsArray == nil) {
        self.historyTopicsArray = [NSMutableArray array];
    }
    return _historyTopicsArray;
}



- (NSMutableArray *)readHistoryTopicWithRow:(NSInteger)row{
    //路径
    NSString *str = [NSString stringWithFormat:@"historyTopics%ld.plist",(long)row];
    NSString *filePath = [KKHistoryTopicsFilePath stringByAppendingPathComponent:str];
    //解档
    self.historyTopicsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return self.historyTopicsArray;
}

- (void)saveHistoryTopic:(NSArray *)historyTopics WithRow:(NSInteger)row{
    
    [self unsaveHistoryTopicAtRow:row];
    //路径
    NSString *str = [NSString stringWithFormat:@"historyTopics%ld.plist",(long)row];
    NSString *filePath = [KKHistoryTopicsFilePath stringByAppendingPathComponent:str];
    
    //存储
    [NSKeyedArchiver archiveRootObject:historyTopics toFile:filePath];
    
}


- (void)unsaveHistoryTopicAtRow:(NSInteger)row{
    //路径
    NSString *str = [NSString stringWithFormat:@"historyTopics%ld.plist",(long)row];
    NSString *filePath = [KKHistoryTopicsFilePath stringByAppendingPathComponent:str];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:filePath error:nil];
    
    
}











#pragma mark - 唯一性 --- 单例
static id _instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedSavingTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
    
}

//拷贝默认只返回一个。Zone是内存空间
- (id)copyWithZone:(NSZone *)zone{
    
    return _instance;//instance之前肯定创建好的，有对象才能拷贝，所以返回单例。要准守NSCopying
}



@end
