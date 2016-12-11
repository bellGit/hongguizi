//
//  CategoryTableViewCell.h
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDataSource.h"
@interface CategoryTableViewCell : UITableViewCell
+ (instancetype)cellWithTable:(UITableView *)tableView;

@property (nonatomic,strong)ProductCategory *categroies;

@end
