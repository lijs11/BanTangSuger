//
//  KKImageScroller.h
//  KKImageScroller
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKImageScroller;
@protocol KKImageScrollerDelegate <NSObject>

@optional
/** 监听用户点击 */
- (void)imageScroller:(KKImageScroller *)imageScroller didClickedAtIndex:(NSInteger)index;

@end


@interface KKImageScroller : UIView

#pragma mark - init

/**可以是本地imageName或者网络imageUrl数组*/
- (void)setImageScrollerWithImages:(NSMutableArray *)images;
/**可以是本地imageName或者网络imageUrl数组*/
- (void)setImageScrollerWithImages:(NSMutableArray *)images time:(NSTimeInterval)timeInterval;

@property (nonatomic,weak) id<KKImageScrollerDelegate>delegate;

@end
