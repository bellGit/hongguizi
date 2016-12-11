//
//  ProductHeadTableViewCell.m
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ProductHeadTableView.h"
@interface ProductHeadTableView()
@property (nonatomic,strong) UILabel *titleView;
@end

@implementation ProductHeadTableView
+ (instancetype)headerCellWith:(UITableView *)tableView {
    ProductHeadTableView *headerCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerCell == nil) {
        headerCell = [[ProductHeadTableView alloc]initWithReuseIdentifier:@"header"];
    }
    return headerCell;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
//        背景颜色跟分类一个颜色
        self.contentView.backgroundColor = COLOR_BG;
//        标题名
        _titleView = [[UILabel alloc]init];
//        标题背景虚化
        _titleView.backgroundColor = [UIColor clearColor];
//        标题颜色
        _titleView.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
//        标题字体大小
        _titleView.font = kFont(13);
        [self.contentView addSubview:_titleView];
//        标题位置
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.leading.equalTo(self).offset(10);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleView.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
