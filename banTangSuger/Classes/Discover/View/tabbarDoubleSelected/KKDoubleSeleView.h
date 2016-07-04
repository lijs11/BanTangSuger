//
//  KKDoubleSeleView.h
//  banTangSuger
//
//  Created by Kenny.li on 16/7/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol doubleSeleViewDelegate <NSObject>

@optional

- (void)doubleSeleViewDidSelectedBtn:(UIButton *)button atIndex:(NSUInteger)index;

@end



@interface KKDoubleSeleView : UIView

@property (nonatomic,strong) id<doubleSeleViewDelegate> delegate ;
- (void)setBtnSelectedAtIndex:(NSUInteger)index;

@end
