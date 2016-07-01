//
//  HomeCollectionCell.h
//  BanTang
//

#import <UIKit/UIKit.h>
#import "KKTopicModel.h"
#import "KKCategory_elementModel.h"
@interface HomeCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UITableView *tableView;

//row == 0,直接从首页加载中提取topics传入
@property (nonatomic,strong) NSArray *topics;

//当不是第一个cell，即row 不是0，传入此模型
@property (nonatomic,strong)KKCategory_elementModel *camodel;

//记录是第几个row,用于存储
@property (nonatomic,assign) NSInteger row;



@property (nonatomic,strong)UINavigationController *navCC;


@end
