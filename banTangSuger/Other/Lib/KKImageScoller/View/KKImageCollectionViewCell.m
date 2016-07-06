//
//  KKImageCollectionViewCell.m
//  KKImageScroller
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKImageCollectionViewCell.h"
#import "UIView+Extension.h"
#import "KKImageModel.h"
#import "UIImageView+WebCache.h"

@interface KKImageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end


@implementation KKImageCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        self.width = 300;
//        self.height = 300;
        
        self.backgroundColor = [UIColor redColor];
        [self setImageModel:self.imageModel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    if (!imageUrl) return;
     _imageUrl = imageUrl;
    
   // [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"8.png"]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}



- (void)setImageModel:(KKImageModel *)imageModel{
    _imageModel = imageModel;
    self.imageView.image = [UIImage imageNamed:@"8.png"];
    
    self.backgroundColor = [UIColor redColor];
    
    if (imageModel.image) {
        self.imageView.image = [UIImage imageNamed:imageModel.image];
    }
    if (imageModel.imageUrl) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.imageUrl] placeholderImage:[UIImage imageNamed:@"8.png"]];
    }
    if (imageModel.title) {
        self.titleLabel.text = [NSString stringWithFormat:@" %@",imageModel.title];
    }
    
}


@end
