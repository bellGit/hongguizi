//
//  CategoryTableViewController.h
//  linjingProduct
//
//  Created by Mac on 16/12/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDataSource.h"
@protocol CategoryTableViewDelagate <NSObject>
- (void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath*)indexPath;
@end
@interface CategoryTableViewController : UITableViewController
@property (nonatomic,strong) CategoryData * categoryData;
@property (nonatomic,weak) id<CategoryTableViewDelagate>delegate;
@end
