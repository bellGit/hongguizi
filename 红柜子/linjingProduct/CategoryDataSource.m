//
//  CategoryDataSource.m
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//


#import "CategoryDataSource.h"
#import "GoodsDataSource.h"

@implementation CategoryDataSource

+(void)loadCategoryData:(CompleteBlock)complete
{
//    路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType:nil];
    NSLog(@"%@",path);
//    转化为二进制数据
    NSData *data = [NSData dataWithContentsOfFile:path];
//    json定义
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//  json解析，使用mj方法
    CategoryDataSource *source = [CategoryDataSource mj_objectWithKeyValues:json];
//    解析数据
    CategoryData *categoryData = source.data;
    for (NSInteger i = 0; i < categoryData.categories.count; i++) {
//        分类信息提取
        ProductCategory *catgeory = categoryData.categories[i];
//        通过分组id：分类的id
        NSArray *productsArr = categoryData.products[catgeory.id];
//        通过字典数组来创建一个模型数组
        catgeory.products = [GoodsDataSource mj_objectArrayWithKeyValuesArray:productsArr];
    }
//    完成数据读取并解析
    complete(categoryData,nil);
}
@end

@implementation CategoryData
//数组中需要转换的模型类
+(NSDictionary*)mj_objectClassInArray
{
//    categories为 json文件里的分组的总名称
    return @{@"categories":NSStringFromClass([ProductCategory class])};
}
@end


@implementation ProductCategory
//数组中需要转换的模型类
+ (NSDictionary *)mj_objectClassInArray {
//   products 为json文件里的商品的总名称
    return @{@"products":NSStringFromClass([GoodsDataSource class])};
}



@end

