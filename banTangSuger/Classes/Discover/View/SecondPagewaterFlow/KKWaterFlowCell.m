//
//  KKWaterFlowCell.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKWaterFlowCell.h"

@interface KKWaterFlowCell()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@end

@implementation KKWaterFlowCell




- (void)setRecommendModel:(KKHotRecommendModel *)recommendModel{
    
    _recommendModel = recommendModel;
    if (recommendModel.mini_pic_url) {
        [self.ImageView sd_setImageWithURL:[NSURL URLWithString:recommendModel.mini_pic_url]];

    }
   }








- (void)awakeFromNib {
    // Initialization code
}

@end
