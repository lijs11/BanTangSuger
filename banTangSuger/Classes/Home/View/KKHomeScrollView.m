//
//  KKHomeScrollView.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKHomeScrollView.h"

@implementation KKHomeScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
