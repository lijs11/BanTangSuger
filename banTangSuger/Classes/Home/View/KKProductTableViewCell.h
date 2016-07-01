//
//  KKProductTableViewCell.h
//  banTangSuger
//
//  Created by Kenny.li on 16/6/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKProductModel.h"

@interface KKProductTableViewCell : UITableViewCell

/**用于传递头像前缀*/
@property (nonatomic,copy) NSString *user_avatr_host;
/**用于传递图片前缀*/
@property (nonatomic,copy) NSString *product_pic_host;
/**商品模型*/
@property (nonatomic,strong)KKProductModel *productModel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


//我们最后得到cell的高度的方法
-(CGFloat)rowHeightWithCellModel:(KKProductModel *)productModel;

@end
