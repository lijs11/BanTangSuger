//
//  KKCoverView.m
//  banTangSuger
//
//  Created by Kenny.li on 16/5/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKCoverView.h"
#import "UIImageView+WebCache.h"

@interface KKCoverView()

@property (nonatomic,strong)UIImageView *imageView;
@end


@implementation KKCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = HMColor(0, 0, 0, 0.5);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"sign_alert_close_btn"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setImage:[UIImage imageNamed:@"sign_share_btn"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:bgView];
        [self addSubview:closeBtn];
        
        [bgView addSubview:imageView];
        [bgView addSubview:shareBtn];
        
        //设置自动布局
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.trailing.equalTo(self).offset(-10);
            make.center.equalTo(self);
        }];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.equalTo(bgView).offset(10);
            make.trailing.equalTo(bgView).offset(-10);
            make.top.equalTo(bgView).offset(10);
            make.height.mas_equalTo(HMScreenW - 40);//最高是 335
            
        }];
        
//        NSLogg(@"imageView %lf %lf",imageView.height,HMScreenW - 40);
        
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView);
            make.top.equalTo(imageView.mas_bottom).offset(15);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(120);
            make.bottom.equalTo(bgView).offset(-15);
        }];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView.mas_top);
            make.trailing.equalTo(bgView);            
            make.size.mas_equalTo(CGSizeMake(28, 40));
            
        }];
        
       
        
    }
    return self;
}


- (void)close{
    
    [self removeFromSuperview];
    
}

- (void)share{
    
    [self removeFromSuperview];
    
}





- (void)setUrl:(NSString *)url{
    _url = url;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:nil];
   
}





@end
