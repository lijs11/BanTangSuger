//
//  KKHeaderReusableView.m
//  banTangSuger
//
//  Created by Kenny.li on 16/7/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKHeaderReusableView.h"


@implementation KKHeaderReusableView


- (KKPageCollectionView *)pageCollView{
    if (_pageCollView == nil) {
        self.pageCollView = [[KKPageCollectionView alloc] init];
        //   self.pageCollView.frame = CGRectMake(0, 64, HMScreenW, 250);
        self.pageCollView.backgroundColor = [UIColor whiteColor];
    }
    return _pageCollView;
}





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = HMColor(235, 235, 235, 1);
        
        
        
        
        //1.pageview头部
        UIView *pageHeaderView = [[UIView alloc] init];
        pageHeaderView.backgroundColor = [UIColor whiteColor];
        self.pageHeaderView = pageHeaderView;
        
        UIImageView *pageImageV = [[UIImageView alloc] init];
        self.pageImageV = pageImageV;
        pageImageV.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *pageHeadLabel = [[UILabel alloc] init];
        self.pageHeadLabel = pageHeadLabel;
        pageHeadLabel.font = [UIFont systemFontOfSize:11];
        pageHeadLabel.text = @"分类";
        
        
        [pageHeaderView addSubview:pageImageV];
        [pageHeaderView addSubview:pageHeadLabel];
        [self addSubview:pageHeaderView];
        
        [self.pageImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pageHeaderView).offset(16);
            make.leading.mas_equalTo(self.pageHeaderView).offset(7);
            make.height.width.mas_equalTo(10);
        }];
        
        [self.pageHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pageHeaderView).offset(15);
            make.leading.mas_equalTo(self.pageImageV).offset(15);
            make.trailing.mas_equalTo(self.pageHeaderView);
            make.height.mas_equalTo(12);
        }];
        
        
        [self.pageHeaderView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.leading.trailing.mas_equalTo(self);
            make.height.mas_equalTo(30);
        }];
        
        
        
        //2.pageview
        [self addSubview:self.pageCollView];
        
        
         //3.waterflow 头部
        UIView *headerV = [[UIView alloc] init];
        headerV.backgroundColor = [UIColor whiteColor];
        self.headerView = headerV;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageV = imageV;
        imageV.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *textLabel = [[UILabel alloc] init];
        self.textLabel = textLabel;
        textLabel.font = [UIFont systemFontOfSize:11];
        textLabel.text = @"热门推荐";
        
        [headerV addSubview:imageV];
        [headerV addSubview:textLabel];
        [self addSubview:headerV];
        
        
        
        [self.pageCollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pageHeaderView.mas_bottom);
            make.leading.trailing.mas_equalTo(self);
            make.height.mas_equalTo(250);
        }];
        
        
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView).offset(16);
            make.leading.mas_equalTo(self.headerView).offset(12);
            make.height.width.mas_equalTo(10);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView).offset(15);
            make.leading.mas_equalTo(self.imageV).offset(15);
            make.trailing.mas_equalTo(self.headerView);
            make.height.mas_equalTo(12);
        }];
        
        
        [self.headerView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pageCollView.mas_bottom).offset(10);
            make.leading.trailing.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        
        
        
    }
    return self;
}











@end
