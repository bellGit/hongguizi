//
//  TableViewController.h
//  linjingProduct
//
//  Created by Mac on 16/12/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDataSource.h"
#import "CategoryTableViewController.h"
@protocol ProductsDelegate<NSObject>

- (void)willDislayHeaderView:(NSInteger)section;
- (void)didEndDislayHeaderView:(NSInteger)section;
@end
@interface TableViewController :UIViewController <CategoryTableViewDelagate>
@property (nonatomic,strong) CategoryData * categoryData;
@property (nonatomic,weak) id<ProductsDelegate>delegate;
@end
