//
//  GoodsDataSource.h
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GoodsDataSource : NSObject

//**************商品模型默认属性***************
/// 商品ID
@property (nonatomic,copy) NSString *gid;
/// 商品姓名
@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *brand_id;
/// 超市价格
@property (nonatomic,copy) NSString *market_price;
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,copy) NSString *category_id;

@property (nonatomic,copy) NSString *partner_price;
@property (nonatomic,copy) NSString *brand_name;
@property (nonatomic,copy) NSString *pre_img;
@property (nonatomic,copy) NSString *pre_imgs;
/// 参数
@property (nonatomic,copy) NSString *specifics;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *dealer_id;
/// 当前价格
@property (nonatomic,copy) NSString *price;
/// 库存
@property (nonatomic,assign) NSInteger number;
/// 买一赠一
@property (nonatomic,copy) NSString *pm_desc;
@property (nonatomic,assign) NSInteger had_pm;
@property (nonatomic,copy) NSString *img;
/// 是不是精选 0 : 不是, 1 : 是
@property (nonatomic,assign) NSInteger is_xf;
//是否展开
@property (nonatomic, assign, getter=isSpread) BOOL spread;


//**************商品模型辅助属性***************
// 记录用户对商品添加次数
@property (nonatomic,assign) NSInteger userBuyNumber;

@end

