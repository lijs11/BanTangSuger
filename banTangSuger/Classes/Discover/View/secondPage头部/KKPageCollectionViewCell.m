//
//  KKPageCollectionViewCell.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKPageCollectionViewCell.h"

@interface KKPageCollectionViewCell()
@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,strong)NSMutableArray *imageViews;
@end

@implementation KKPageCollectionViewCell

- (NSMutableArray *)btns{
    
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
    }
    
    return _btns;
}

- (NSMutableArray *)imageViews{
    if (_imageViews == nil) {
        self.imageViews = [NSMutableArray array];
    }
    return _imageViews;
}



- (void)awakeFromNib {
    
    self.btn1.tag = 1000 + 1;
    self.btn2.tag = 1000 + 2;
    self.btn3.tag = 1000 + 3;
    self.btn4.tag = 1000 + 4;
    self.btn5.tag = 1000 + 5;
    self.btn6.tag = 1000 + 6;
    
    [self.btns addObject:self.btn1];
    [self.btns addObject:self.btn2];
    [self.btns addObject:self.btn3];
    [self.btns addObject:self.btn4];
    [self.btns addObject:self.btn5];
    [self.btns addObject:self.btn6];
    
    [self.imageViews addObject:self.imageV1];
    [self.imageViews addObject:self.imageV2];
    [self.imageViews addObject:self.imageV3];
    [self.imageViews addObject:self.imageV4];
    [self.imageViews addObject:self.imageV5];
    [self.imageViews addObject:self.imageV6];

    
    
}

	

- (void)setCategory_lists:(NSMutableArray *)category_lists{
    
    _category_lists = category_lists;
    
    if (category_lists.count == 0) return;
            
    NSUInteger count = category_lists.count;
    for (int i = 0; i < count; i++) {
        
        KKCategory_list_Model *model = self.category_lists[i];
//        UIButton *btn = self.btns[i];
//        [btn setTitle:model.name forState:UIControlStateNormal] ;
        if (model.pic) {
            UIImageView *imageV = self.imageViews[i];
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.pic]];

        }
        
        
    }
    
    
}



@end
