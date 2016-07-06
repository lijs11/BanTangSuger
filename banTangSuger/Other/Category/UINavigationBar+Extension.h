//
//  UINavigationBar+Extension.h
//  BanTang
//
//  Created by 江科 on 16/4/5.
//  Copyright © 2016年 天空之城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extension)
- (void)zz_setBackgroundColor:(UIColor *)color ;
- (void)zz_setElementAlpha:(CGFloat)alpha withIsNav:(BOOL)is;
- (void)zz_reset;
- (void)zz_setTitleViewAlpha:(CGFloat)alpha;
@end
