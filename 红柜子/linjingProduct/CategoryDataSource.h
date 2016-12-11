//
//  CategoryDataSource.h
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void(^CompleteBlock)(id data,NSError *error);
//分类数据
@class CategoryData;
//产品分类
@class ProductCategory;
//产品
@class Products;
//商品数据
@class GoodsDataSource;
//分级商品数据
@class Commodity;
@class CommodityCategory;

@interface CategoryDataSource : NSObject
//
@property (nonatomic, copy) NSString *code;
//信息
@property (nonatomic, copy) NSString *msg;
//数据
@property (nonatomic,strong)CategoryData *data;
//完成导入分组商品数据
+ (void)loadCategoryData:(CompleteBlock)complete;
@end


@interface CategoryData:NSObject

@property (nonatomic,strong)NSArray<ProductCategory *> *categories;
@property (nonatomic,strong)NSArray<CommodityCategory *> *categories2;

@property (nonatomic,strong)id products;

@property(nonatomic,strong)id res;

@end


@interface ProductCategory:NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *products;

@end
@interface CommodityCategory:NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *res;

@end


