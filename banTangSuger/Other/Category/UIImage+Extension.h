//
//  UIImage+Extension.h
//  网易新闻瀑布流
//
//  Created by Kenny.li on 16/3/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/*加载图片自动匹配ios6，7*/
+ (UIImage *)imageWithName:(NSString *)name;
/*拉伸图片*/
+ (UIImage *)resizedImageWithName:(NSString *)name;
/*拉伸图片*/
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/*拉伸图片*/
- (UIImage *)imageToSize:(CGSize) size;

//返回纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withWidthHeight:(CGFloat)wh;
@end
