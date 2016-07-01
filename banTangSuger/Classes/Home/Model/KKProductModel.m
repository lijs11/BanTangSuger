//
//  KKProductModel.m
//  banTangSuger
//
//  Created by Kenny.li on 16/6/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKProductModel.h"
#import "KKProductTableViewCell.h"


@interface KKProductModel()

@end

@implementation KKProductModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}


-(CGFloat)cellHeight

{
    
    //只在初始化的时候调用一次就Ok
    
    CGFloat cellH = 0.0;
    if(!_cellHeight){
        
//        KKProductTableViewCell *cell=[[KKProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"productTableViewCell"];
//        
        NSLog(@"我要计算高度");
        
        // 调用cell的方法计算出高度
//        _cellHeight=[self rowHeightWithCellModel:self];
        
        
        CGSize textSize2 = [self sizeWithText:self.desc font:[UIFont fontWithName:KKThinFont size:15] maxSize:CGSizeMake(HMScreenW - 20, MAXFLOAT)];
        
        CGFloat picW = HMScreenW - 20;
        CGFloat wholeH = 0.0;
        NSArray *picArray = self.pic;
        NSUInteger picCount = picArray.count;
        
        for (NSUInteger i = 0 ; i < picCount; i++) {
            NSDictionary *picDict = picArray[i];
            CGFloat picH = [picDict[@"h"] floatValue] / [picDict[@"w"] floatValue] * picW;
            wholeH += picH;
        }
        
        cellH = 20 + textSize2.height + wholeH + 10 * (picCount - 1) + 140;
    }
    
    return cellH;
    
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}









MJCodingImplementation
@end
