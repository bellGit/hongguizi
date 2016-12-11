//
//  CommodityTableViewCell.h
//  linjingProduct
//
//  Created by Mac on 16/12/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyView.h"
@class Commodity;
@interface CommodityTableViewCell : UITableViewCell
+ (instancetype)cellWithTable:(UITableView *)tableView;

@property (nonatomic,strong)Commodity * goodsCategory;
@property (nonatomic,strong) UILabel *nameLabel;
//商品价格
@property (nonatomic,strong) UILabel *goodsPrices;
@property (nonatomic,strong) BuyView *buyView;
@property (nonatomic,strong) BuyView *buyView2;
@property (nonatomic,strong) BuyView *buyView3;
@property (nonatomic,strong) BuyView *buyView4;
@property (nonatomic,strong) BuyView *buyView5;
@property (copy, nonatomic) void (^plusBlock)(NSInteger count,BOOL animated);
@property (assign, nonatomic) NSUInteger amount;
@end
