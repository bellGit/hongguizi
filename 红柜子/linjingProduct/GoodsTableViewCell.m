//
//  GoodsTableViewCell.m
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "GoodsTableViewCell.h"

#import "GoodsDataSource.h"
@interface GoodsTableViewCell ()
// 商品的图片
@property (nonatomic,strong) UIImageView *goodsImageView;
// 商品名字
@property (nonatomic,strong) UILabel *nameLabel;
// 精选的图片
@property (nonatomic,strong) UIImageView *fineImageView;
// 买一赠一的图片
@property (nonatomic,strong) UIImageView *giveImageView;
// 商品单位
@property (nonatomic,strong) UILabel *specificsLabel;
//商品价格
@property (nonatomic,strong) UILabel *goodsPrices;
// 选择数量

//线
@property (nonatomic,strong) UIView *lineView;
@end
@implementation GoodsTableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *cellId = @"ProductsCellID";
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[GoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        背景颜色：白
        self.backgroundColor = [UIColor whiteColor];
//      商品图片
        _goodsImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_goodsImageView];
// 商品名字初始化
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kBoldFont(15);
        [self.contentView addSubview:_nameLabel];
//    精选图片初始化
        _fineImageView = [[UIImageView alloc]init];
//        精选图片
        [_fineImageView setImage:[UIImage imageNamed:@"jingxuan.png"]];
        [self.contentView addSubview:_fineImageView];
//       买一赠一
        _giveImageView = [[UIImageView alloc]init];
        [_giveImageView setImage:[UIImage imageNamed:@"buyOne.png"]];
        [self.contentView addSubview:_giveImageView];
//     商品单位
        _specificsLabel = [[UILabel alloc]init];
        _specificsLabel.font = kFont(10);
        _specificsLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_specificsLabel];
//        商品价格
        _goodsPrices = [[UILabel alloc]init];
        _goodsPrices.font=kBoldFont(15);
        _goodsPrices.textColor=PRICE_COLOR;
        [self.contentView addSubview:_goodsPrices];
        
//   数量初始化
        _buyView = [[BuyView alloc]init];
        [self.contentView addSubview:_buyView];
        [_buyView.addButton addTarget:self action:@selector(addButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [_buyView.reduceButton addTarget:self action:@selector(reduceButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
//线初始化
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = COLOR_Line;
        [self.contentView addSubview:_lineView];
//位置定义
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
//            图片的首部跟view的首部相等，等于左侧置顶
            make.leading.equalTo(self).offset(18);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        
        [_fineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            精选的图片首部跟物品图片尾部相等，等于精选左侧跟物品图片右边相靠
            make.leading.equalTo(_goodsImageView.mas_trailing).offset(10);
            make.top.equalTo(self).offset(10);
//            高度15，宽度30
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(15);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            y中心跟精选中心相等
            make.centerY.equalTo(_fineImageView);
//          物品名字左侧跟精选右边相靠
            make.leading.equalTo(_fineImageView.mas_trailing);
//            物品右侧跟view相靠（超出不显示）
            make.trailing.equalTo(self);
//            高度20
            make.height.mas_equalTo(20);
        }];
//        [_giveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(_fineImageView);
//            make.top.equalTo(_fineImageView.mas_bottom).offset(2);
//            make.width.mas_equalTo(30);
//            make.height.mas_equalTo(15);
//        }];
        [_specificsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_fineImageView);
           make.top.equalTo(_fineImageView.mas_bottom).offset(2);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(20);
        }];
//
        [_goodsPrices mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_fineImageView);
            make.top.equalTo(_specificsLabel.mas_bottom);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-5);
            make.trailing.equalTo(self).offset(-5);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(25);
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
-(void)addButtonCliked:(UIButton*)btn
{
    _buyView.buyNumber++;
        self.plusBlock(self.amount,YES);
    _buyView.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView.buyNumber];
}
-(void)reduceButtonCliked:(UIButton*)btn
{
    if (_buyView.buyNumber<=0)
    {
        return;
    }
     self.plusBlock(self.amount,NO);
    _buyView.buyNumber--;
    _buyView.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView.buyNumber];
    
}
-(void)setGoods:(GoodsDataSource *)goods
{
    //    NSLog(@"%@",goods.img);
    [self.goodsImageView setImageWithURLStr:goods.img placeholderImage:[UIImage imageNamed:@"1209_2.jpg"]];
//    根据相同名字来取
    self.nameLabel.text = goods.name;
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        self.giveImageView.hidden = YES;
    }else{
        self.giveImageView.hidden = YES;
    }
    self.specificsLabel.text = goods.specifics;
    self.goodsPrices.text=[NSString stringWithFormat:@"¥%@", goods.market_price];
    self.buyView.goodNum = 0 ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}




@end
