//
//  ProductHeadTableViewCell.h
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductHeadTableView : UITableViewHeaderFooterView
+ (instancetype)headerCellWith:(UITableView *)tableView;

@property (nonatomic,copy) NSString *title;
@end
