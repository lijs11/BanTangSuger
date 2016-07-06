//
//  KKProductTableViewCell.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKProductTableViewCell.h"



@interface KKProductTableViewCell()

@property (nonatomic,strong)UIView     *mainContentView;
@property (nonatomic,strong)UILabel    *labelView;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,assign)CGSize     textSize;
//@property (nonatomic,strong)UITextView *textView;

@end





@implementation KKProductTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
   // NSLoggg(@"self--cellWithTableView");
    static NSString *identifier = @"productTableViewCell";
  //  KKProductTableViewCell *cell = [[KKProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     // 1.缓存中取
     KKProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
    //清楚cell的缓存
     NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
      for (UIView *subview in subviews) {
          if ([subview isKindOfClass:[UIImageView class]]) {
              [subview removeFromSuperview];
          }
       }
     // 2.创建
     if (cell == nil) {
             cell = [[KKProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
         }
    return cell;
    
}

/**
   *  构造方法(在初始化对象的时候会调用)
   *  一般在这个方法中添加需要显示的子控件
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
      //  NSLoggg(@"self--initWithStyle");
        
//        self.mainContentView = [[UIView alloc] init];
        
        
        
        //1.文本框
        UILabel *labelView = [[UILabel alloc] init];
        self.labelView = labelView;
        labelView.backgroundColor = [UIColor whiteColor];
        labelView.textAlignment = NSTextAlignmentLeft;
        labelView.font = [UIFont fontWithName:KKLightFont size:17];
        [self.contentView addSubview:labelView];
        
        //2.des
        UITextView *textView = [[UITextView alloc] init];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.selectable = NO;
        self.textView = textView;
        textView.font = [UIFont fontWithName:KKThinFont size:13];
        textView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:textView];
        
      
       
        
        
        //3.图片
//        self.topImageView = [[UIImageView alloc] init];
//        [self.contentMainView addSubview:self.topImageView];
//        
//        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.top.trailing.equalTo(self.headerMainView);
//            make.height.mas_equalTo(HMScreenW * 0.55);
//        }];
//        
        
        
        
    }
    
    return self;
    
    
}

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}


-(float)heightForString1:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    
    return deSize.height;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (void)setProductModel:(KKProductModel *)productModel{
    
    _productModel = productModel;
    
   //  NSLogg(@"self--setProductModel");
    
   // NSLogg(@"setProductModel--productModel--%@",self.productModel.mj_keyValues);
    
    // 1.labelView labelView
    self.labelView.text = self.productModel.title;
    self.textView.text = self.productModel.desc;

    
 //   CGSize textSize1 = [self.textView sizeThatFits:CGSizeMake(self.width - 20, MAXFLOAT)];
    
//    CGSize textSize2 = [self sizeWithText:self.productModel.desc font:[UIFont fontWithName:KKThinFont size:15] maxSize:CGSizeMake(self.width - 20, MAXFLOAT)];
//    self.textSize = textSize;
    

    
    
    //获取当前文本的属性
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.textView.text];
//    
//    NSRange range = NSMakeRange(0, attrStr.length);
//    // 获取该段attributedString的属性字典
//    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
//    // 计算文本的大小
//    CGSize textSize3 = [self.textView.text boundingRectWithSize:CGSizeMake(self.width - 20.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
//                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
//                                        attributes:dic        // 文字的属性
//                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    
  //  NSLog(@"'%lf  %lf %lf",textSize1.height,textSize2.height,textSize3.height + 16);
    
    
    //自动布局
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.leading.mas_equalTo(self.contentView).offset(13);
        make.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelView.mas_bottom);
        make.leading.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
      //    make.height.mas_equalTo(textSize2.height);
    }];
    
    
    
   
   

    
    
    //2. 添加图片 "product_pic_host": "http:\/\/bt.img.17gwx.com\/",
    //高度宽度计算
    CGFloat picW = self.width - 20;
    
    NSArray *picArray = productModel.pic;
    NSUInteger picCount = picArray.count;
    CGFloat wholeH = 0.0;
    UIImageView *lastImageView;
    for (NSUInteger i = 0 ; i < picCount; i++) {
        NSDictionary *picDict = picArray[i];
        UIImageView *picImageV = [[UIImageView alloc] init];
        picImageV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:picImageV];
        CGFloat picH = [picDict[@"h"] floatValue] / [picDict[@"w"] floatValue] * picW;
       //  NSLog(@" picH %lf ",picH);
//        picImageV.width = picW;
//        picImageV.height = picH;
        
//        if (i == picCount - 1) {//最后一个图片
//            if (lastImageView == nil) {//只有一张图片
//                [picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.mas_equalTo(self.textView.mas_bottom);
//                    make.width.mas_equalTo(picW);
//                    make.centerX.mas_equalTo(self.contentView.mas_centerX);
//                //    make.bottom.mas_equalTo(self.contentView.mas_bottom);
//                    make.height.mas_equalTo(picH);
//                }];
//            
//            }else if (lastImageView){//不止一张图片
//            
//                [picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.mas_equalTo(lastImageView.mas_bottom).offset(10);
//                    make.width.mas_equalTo(picW);
//                    make.centerX.mas_equalTo(self.contentView.mas_centerX);
//                 //   make.bottom.mas_equalTo(self.contentView.mas_bottom);
//                    make.height.mas_equalTo(picH);
//                }];
//           }
//            
//                        
//        
//         }else
             if (lastImageView) {//上面还有其他图片
            [picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastImageView.mas_bottom).offset(10);
                make.width.mas_equalTo(picW);
                make.centerX.mas_equalTo(self.contentView.mas_centerX);
                make.height.mas_equalTo(picH);
            }];
        }else{//第一个图片
            [picImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textView.mas_bottom);
                make.width.mas_equalTo(picW);
                make.centerX.mas_equalTo(self.contentView.mas_centerX);
                make.height.mas_equalTo(picH);
            }];
        }
        
      
        
        
        
        NSURL *picUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.product_pic_host,picDict[@"p"]]];
        [picImageV sd_setImageWithURL:picUrl];
        
        lastImageView = picImageV;
        wholeH = picH + wholeH;
    }
    
    
    //3.添加底层
    UIImageView *bottowView = [[UIImageView alloc] init];
    bottowView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottowView];
    
    //3.1 头像
    NSArray *likesArray = productModel.likes_list;
    NSUInteger likesCount = likesArray.count;
   
    UIImageView *lastHeaderV;
    for (NSUInteger j = 0 ; j < (likesCount > 8 ? 8 : likesCount) ; j++) {

      
        UIImageView *userHeaderV = [[UIImageView alloc] init];
        userHeaderV.userInteractionEnabled = YES;
        [bottowView addSubview:userHeaderV];
        NSDictionary *userHeaderDict = likesArray[j];
 
//        if (lastImageView) {
//            [userHeaderV mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(bottowView.mas_top).offset(10);
//                make.leading.mas_equalTo(lastImageView.mas_trailing).offset(5);
//                make.height.width.mas_equalTo(30);
//            }];
//        }else{
//            
//            [userHeaderV mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(bottowView.mas_top).offset(10);
//                make.leading.mas_equalTo(bottowView.mas_leading).offset(5);
//                make.height.width.mas_equalTo(30);
//            }];
//            
//        }
             userHeaderV.frame = CGRectMake(40 * j + 10, 15, 30, 30);
    
        
        
        
        
        NSURL *headerUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.user_avatr_host,userHeaderDict[@"a"]]];
        [userHeaderV sd_setImageWithURL:headerUrl placeholderImage:[UIImage imageNamed:@"AppIcon60x60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            UIImage *newImage = [self circleImage:userHeaderV.image withParam:1.0];
            userHeaderV.image = newImage;
            
        }];
        
        lastHeaderV = userHeaderV;
        
       }
    
    //3.2 分割线
    UIView *splView = [[UIView alloc] init];
    splView.backgroundColor = [UIColor grayColor];
    splView.alpha = 0.35;
    [bottowView addSubview:splView];
    
    [splView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastHeaderV.mas_bottom).offset(15);
        make.width.mas_equalTo(bottowView.mas_width);
        make.leading.trailing.mas_equalTo(bottowView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    //3.2 3个按钮
    
    
    for (int x = 0; x < 3; x++) {
        
        UIButton *commtBtn = [[UIButton alloc] init];
        commtBtn.backgroundColor = [UIColor whiteColor];
        [bottowView addSubview:commtBtn];
        
//        [splView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(splView.mas_bottom).offset(15);
//            make.width.mas_equalTo(50);
//            make.height.mas_equalTo(35);
//            make.leading.mas_equalTo(bottowView.mas_leading).offset(15 + x * 100);
//        }];
//
        
        commtBtn.frame = CGRectMake(25 + x * 130, 80, 65, 25);
        commtBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [commtBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        commtBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //NO USE
//        commtBtn.titleLabel.text = @"评论";
//        commtBtn.titleLabel.textColor = [UIColor purpleColor];

        
        
        
        if (x == 0) {
            [commtBtn setTitle:@"评论" forState:UIControlStateNormal];
            [commtBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
           
        }else if (x == 1){
            [commtBtn setTitle:@"喜欢" forState:UIControlStateNormal];
            [commtBtn setTitle:@"已喜欢" forState:UIControlStateSelected];
            [commtBtn setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateNormal];
            [commtBtn setImage:[UIImage imageNamed:@"community_like"] forState:UIControlStateSelected];
            
        }else{
            [commtBtn setTitle:@"购买" forState:UIControlStateNormal];
            [commtBtn setImage:[UIImage imageNamed:@"iconfont-shop"] forState:UIControlStateNormal];
           
        }
        
        
        
        
    }
    
    
    
    [bottowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(120);
    }];
    
    
    //底层布局
    
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(lastImageView.mas_bottom).offset(-10);
//    }];
//    
    
    
    
}


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









//在表格cell中 计算出高度   NO USE
-(CGFloat)rowHeightWithCellModel:(KKProductModel *)productModel
{
    _productModel = productModel;
  
    
 CGSize textSize2 = [self sizeWithText:productModel.desc font:[UIFont fontWithName:KKThinFont size:15] maxSize:CGSizeMake(self.width - 20, MAXFLOAT)];
    
    CGFloat picW = self.width - 20;
    
    NSArray *picArray = productModel.pic;
    NSUInteger picCount = picArray.count;
    CGFloat wholeH = 0.0;
    for (NSUInteger i = 0 ; i < picCount; i++) {
        NSDictionary *picDict = picArray[i];
        CGFloat picH = [picDict[@"h"] floatValue] / [picDict[@"w"] floatValue] * picW;
        wholeH += picH;
    }
    
    return 20 + textSize2.height + wholeH + 10 * (picCount - 1) ;
}





@end
