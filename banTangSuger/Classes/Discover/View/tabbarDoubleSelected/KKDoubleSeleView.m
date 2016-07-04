//
//  KKDoubleSeleView.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKDoubleSeleView.h"


@interface KKDoubleSeleView()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation KKDoubleSeleView

- (void)awakeFromNib{
    

   
}



- (void)setBtnSelectedAtIndex:(NSUInteger)index{
    
    if (index == 0) {
         [self leftBtnClick:self.leftBtn];
    }else{
         [self rightBtnClick:self.leftBtn];
    }
    
    
}




- (IBAction)leftBtnClick:(UIButton *)sender {
    
    self.rightBtn.selected = NO;
    self.leftBtn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(doubleSeleViewDidSelectedBtn:atIndex:)]) {
        [self.delegate doubleSeleViewDidSelectedBtn:sender atIndex:0];
    }
    
    
    
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    
    self.leftBtn.selected = NO;
    self.rightBtn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(doubleSeleViewDidSelectedBtn:atIndex:)]) {
        [self.delegate doubleSeleViewDidSelectedBtn:sender atIndex:1];
    }
}




@end
