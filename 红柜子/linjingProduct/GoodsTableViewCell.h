//
//  GoodsTableViewCell.h
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyView.h"
@class GoodsDataSource;
@interface GoodsTableViewCell : UITableViewCell
+ (instancetype)cellWithTable:(UITableView *)tableView;

@property (nonatomic,strong)GoodsDataSource * goods;
@property (nonatomic,strong) BuyView *buyView;
@property (copy, nonatomic) void (^plusBlock)(NSInteger count,BOOL animated);
@property (assign, nonatomic) NSUInteger amount;
@end
