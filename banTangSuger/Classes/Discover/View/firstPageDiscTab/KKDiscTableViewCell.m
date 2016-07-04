//
//  KKDiscTableViewCell.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKDiscTableViewCell.h"
#import "KKUser.h"

@interface KKDiscTableViewCell()

@end

@implementation KKDiscTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setTopic:(KKTopicModel *)topic
{
    _topic = topic;
    
    self.titleL.text = self.topic.title;
    
    
    KKUser *user = topic.user;
    
//    [self.headerV sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:nil];
    [self.headerV sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"AppIcon60x60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIImage *newImage = [self circleImage:self.headerV.image withParam:1.0];
        self.headerV.image = newImage;
        
    }];
    
    
    
    self.username.text = user.nickname;
    self.dateL.text = topic.order_time_str;
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:topic.pics[0][@"url"]] placeholderImage:nil];
    [self.image2 sd_setImageWithURL:[NSURL URLWithString:topic.pics[1][@"url"]] placeholderImage:nil];
    [self.image3 sd_setImageWithURL:[NSURL URLWithString:topic.pics[2][@"url"]] placeholderImage:nil];
    
//    [self.image1 sd_setImageWithURL:topic.pics[0][@"url"] placeholderImage:[UIImage imageNamed:@"AppIcon60x60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        UIImage *newImage = [self circleImage:self.image1.image withParam:1.0];
//        self.image1.image = newImage;
//        
//    }];
//    [self.image2 sd_setImageWithURL:topic.pics[1][@"url"] placeholderImage:[UIImage imageNamed:@"AppIcon60x60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        UIImage *newImage = [self circleImage:self.image2.image withParam:1.0];
//        self.image2.image = newImage;
//        
//    }];
//    [self.image3 sd_setImageWithURL:topic.pics[2][@"url"] placeholderImage:[UIImage imageNamed:@"AppIcon60x60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        UIImage *newImage = [self circleImage:self.image3.image withParam:1.0];
//        self.image3.image = newImage;
//        
//    }];
//    
    
    self.viewsV.text = topic.views;
    self.likesV.text = topic.likes;
    
    
}


//
//@property (weak, nonatomic) IBOutlet UILabel *title;
//@property (weak, nonatomic) IBOutlet UIImageView *headerV;
//@property (weak, nonatomic) IBOutlet UILabel *username;
//@property (weak, nonatomic) IBOutlet UILabel *data;
//
//
//@property (weak, nonatomic) IBOutlet UIImageView *image1;
//@property (weak, nonatomic) IBOutlet UIImageView *image2;
//@property (weak, nonatomic) IBOutlet UIImageView *image3;
//
//@property (weak, nonatomic) IBOutlet UILabel *viewsV;
//@property (weak, nonatomic) IBOutlet UIImageView *likesV;
//


-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
    
}

@end
