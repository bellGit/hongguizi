//
//  GoodsDataSource.m
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "GoodsDataSource.h"


@implementation GoodsDataSource

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"gid":@"id"};
}
@end

