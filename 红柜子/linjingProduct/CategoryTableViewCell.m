//
//  CategoryTableViewCell.m
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CategoryTableViewCell.h"
@interface CategoryTableViewCell()
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView *categoryImageView;
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UIView *blueView;
@property (nonatomic,strong) UIView *lineView;
@end
@implementation CategoryTableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *cellId = @"CategoryCellID";
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//分组cell的设定
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//背景图片视图
        self.backgroundImageView = [[UIImageView alloc]init];
//        创造颜色
         self.backgroundImageView .image = [UIImage createImageWithColor:COLOR_BG];
//        选中时的颜色：白色
         self.backgroundImageView .highlightedImage = [UIImage createImageWithColor:[UIColor whiteColor]];
//        加入主视图
        [self.contentView addSubview: self.backgroundImageView ];
// 选中的蓝色显示
        _blueView = [[UIView alloc]init];
        _blueView.backgroundColor = COLOR_NA;
        [self.contentView addSubview:_blueView];
//线
        _lineView = [[UIView alloc]init];
//        线色
        _lineView.backgroundColor = COLOR_Line;
        [self.contentView addSubview:_lineView];
//         分组图片
        
        _categoryImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_categoryImageView];
// 分组名
        _nameLabel = [[UILabel alloc]init];
//        名字背景虚化
        _nameLabel.backgroundColor = [UIColor clearColor];
//        对中
        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        14字号
        _nameLabel.font = kBoldFont(13);
//        字色灰
        _nameLabel.textColor = [UIColor grayColor];
        
//        选中字色黑
        _nameLabel.highlightedTextColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        
//   Masonry使用
//        图片
        [_categoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
            //            图片的首部跟view的首部相等，等于左侧置顶
            make.leading.mas_offset(10);
            make.centerY.equalTo(_nameLabel);
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(18);
        }];

//        定义背景view
        [ self.backgroundImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(_categoryImageView.mas_trailing).mas_offset(10);
//           
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 25, 0, 0));
//             make.leading.equalTo(_categoryImageView.mas_trailing);
        }];
//        
        [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
//            equalTo后面跟的是view（self） mas——equal后面跟的是数量，是大小
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.width.mas_equalTo(5);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.nameLabel.highlighted = selected;
    self.blueView.hidden = !selected;
    self.backgroundImageView.highlighted = selected;
}

-(void)setCategroies:(ProductCategory *)categroies
{
    self.nameLabel.text = categroies.name;
    
    self.categoryImageView.image=[UIImage imageNamed:categroies.icon];
}
@end
