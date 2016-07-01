//
//  KKHomeTableViewCell.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/2.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKHomeTableViewCell.h"
#import "UIImageView+WebCache.m"
@implementation KKHomeTableViewCell

- (void)awakeFromNib {
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

- (void)setTopic:(KKTopicModel *)topic
{
    _topic = topic;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:topic.pic] placeholderImage:nil];
    self.title.text = self.topic.title;
    self.likeLabel.text = self.topic.likes;
    
    
}




@end
