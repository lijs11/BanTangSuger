//
//  KKTitleScrollView.h
//  banTangSuger
//
//  Created by Kenny.li on 16/5/30.
//  Copyright © 2016年 KK. All rights reserved.
//  TableView 等HeaderView 可以滑动

#import <Foundation/Foundation.h>
@class KKTitleScrollView;
@protocol KKTitleScrollViewDelegate <NSObject>
@optional
- (void)titleScrollViewDidClicked:(KKTitleScrollView *)titleScrollView atIndex:(NSInteger)index;
@end


@interface KKTitleScrollView : UIView

/**外部设置选中哪个标签*/
- (void)selectItemAtIndex:(NSInteger)index;

/**初始化方法*/
- (instancetype)initWithTitleArray:(NSArray *)titleArray titleSubWidth:(CGFloat)subWidth;

@property (nonatomic,weak) id<KKTitleScrollViewDelegate> delegate;

@end
