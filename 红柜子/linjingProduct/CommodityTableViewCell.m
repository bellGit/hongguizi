//
//  CommodityTableViewCell.m
//  linjingProduct
//
//  Created by Mac on 16/12/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CommodityTableViewCell.h"

@interface CommodityTableViewCell ()

// 商品名字
@property (nonatomic,strong) UILabel *nameLabel2;
//商品价格
@property (nonatomic,strong) UILabel *goodsPrices2;
@property (nonatomic,strong) UILabel *nameLabel3;
//商品价格
@property (nonatomic,strong) UILabel *goodsPrices3;
@property (nonatomic,strong) UILabel *nameLabel4;
//商品价格
@property (nonatomic,strong) UILabel *goodsPrices4;
@property (nonatomic,strong) UILabel *nameLabel5;
//商品价格
@property (nonatomic,strong) UILabel *goodsPrices5;
//线
@property (nonatomic,strong) UIView *lineView;
@end
@implementation CommodityTableViewCell
+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *cellId = @"CommodityCellID";
    CommodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CommodityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.nameLabel.text=@"黑人牙膏";
        cell.goodsPrices.text=@"¥ 8 元";
        cell.nameLabel2.text=@"黑妹牙膏";
        cell.goodsPrices2.text=@"¥ 8 元";
        cell.nameLabel3.text=@"中华牙膏";
        cell.goodsPrices3.text=@"¥ 8 元";
        cell.nameLabel4.text=@"舒适达牙膏";
        cell.goodsPrices4.text=@"¥ 8 元";
        cell.nameLabel5.text=@"佳洁士牙膏";
        cell.goodsPrices5.text=@"¥ 8 元";
     
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        背景颜色：白
        self.backgroundColor = [UIColor whiteColor];
      
       
        // 商品名字初始化
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kBoldFont(15);
        [self.contentView addSubview:_nameLabel];
   
        _nameLabel2 = [[UILabel alloc]init];
        _nameLabel2.font = kBoldFont(15);
        [self.contentView addSubview:_nameLabel2];
        _nameLabel3 = [[UILabel alloc]init];
        _nameLabel3.font = kBoldFont(15);
        [self.contentView addSubview:_nameLabel3];
        _nameLabel4 = [[UILabel alloc]init];
        _nameLabel4.font = kBoldFont(15);
        [self.contentView addSubview:_nameLabel4];
        _nameLabel5 = [[UILabel alloc]init];
        _nameLabel5.font = kBoldFont(15);
        [self.contentView addSubview:_nameLabel5];
        
               //        商品价格
        _goodsPrices = [[UILabel alloc]init];
        _goodsPrices.font=kBoldFont(15);
        _goodsPrices.textColor=PRICE_COLOR;
        [self.contentView addSubview:_goodsPrices];
        _goodsPrices2 = [[UILabel alloc]init];
        _goodsPrices2.font=kBoldFont(15);
        _goodsPrices2.textColor=PRICE_COLOR;
        [self.contentView addSubview:_goodsPrices2];
        _goodsPrices3 = [[UILabel alloc]init];
        _goodsPrices3.font=kBoldFont(15);
        _goodsPrices3.textColor=PRICE_COLOR;
        [self.contentView addSubview:_goodsPrices3];
        _goodsPrices4 = [[UILabel alloc]init];
        _goodsPrices4.font=kBoldFont(15);
        _goodsPrices4.textColor=PRICE_COLOR;
        [self.contentView addSubview:_goodsPrices4];
        _goodsPrices5 = [[UILabel alloc]init];
        _goodsPrices5.font=kBoldFont(15);
        _goodsPrices5.textColor=PRICE_COLOR;
        [self.contentView addSubview:_goodsPrices5];
        
        //   数量初始化
        _buyView = [[BuyView alloc]init];
        [self.contentView addSubview:_buyView];
        [_buyView.addButton addTarget:self action:@selector(addButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [_buyView.reduceButton addTarget:self action:@selector(reduceButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        _buyView2 = [[BuyView alloc]init];
        [self.contentView addSubview:_buyView2];
        [_buyView2.addButton addTarget:self action:@selector(addButtonCliked2:) forControlEvents:UIControlEventTouchUpInside];
        [_buyView2.reduceButton addTarget:self action:@selector(reduceButtonCliked2:) forControlEvents:UIControlEventTouchUpInside];
        
        _buyView3 = [[BuyView alloc]init];
        [self.contentView addSubview:_buyView3];
        [_buyView3.addButton addTarget:self action:@selector(addButtonCliked3:) forControlEvents:UIControlEventTouchUpInside];
        [_buyView3.reduceButton addTarget:self action:@selector(reduceButtonCliked3:) forControlEvents:UIControlEventTouchUpInside];

        _buyView4 = [[BuyView alloc]init];
        [self.contentView addSubview:_buyView4];
        [_buyView4.addButton addTarget:self action:@selector(addButtonCliked4:) forControlEvents:UIControlEventTouchUpInside];
        [_buyView4.reduceButton addTarget:self action:@selector(reduceButtonCliked4:) forControlEvents:UIControlEventTouchUpInside];

        _buyView5 = [[BuyView alloc]init];
        [self.contentView addSubview:_buyView5];
        [_buyView5.addButton addTarget:self action:@selector(addButtonCliked5:) forControlEvents:UIControlEventTouchUpInside];
        [_buyView5.reduceButton addTarget:self action:@selector(reduceButtonCliked5:) forControlEvents:UIControlEventTouchUpInside];
        //线初始化
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = COLOR_Line;
        [self.contentView addSubview:_lineView];
               [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                   物品上侧跟view相靠
           make.top.equalTo(self).offset(2);
            //          物品名字左侧跟精选右边相靠
            make.leading.equalTo(self).offset(10);
            //            物品右侧跟view相靠（超出不显示）
//            make.trailing.equalTo(self);
            //            高度20
            make.height.mas_equalTo(20);
        }];
        [_nameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            //                   物品上侧跟view相靠
            make.top.equalTo(self.nameLabel.mas_bottom).offset(2);
            //          物品名字左侧跟精选右边相靠
            make.leading.equalTo(self).offset(10);
            //            物品右侧跟view相靠（超出不显示）
            //            make.trailing.equalTo(self);
            //            高度20
            make.height.mas_equalTo(20);
        }];
        [_nameLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            //                   物品上侧跟view相靠
            make.top.equalTo(self.nameLabel2.mas_bottom).offset(2);
            //          物品名字左侧跟精选右边相靠
            make.leading.equalTo(self).offset(10);
            
            make.height.mas_equalTo(20);
        }];
        [_nameLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            //                   物品上侧跟view相靠
            make.top.equalTo(self.nameLabel3.mas_bottom).offset(2);
            //          物品名字左侧跟精选右边相靠
            make.leading.equalTo(self).offset(10);
         
            make.height.mas_equalTo(20);
        }];
        [_nameLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            //                   物品上侧跟view相靠
            make.top.equalTo(self.nameLabel4.mas_bottom).offset(2);
            //          物品名字左侧跟精选右边相靠
            make.leading.equalTo(self).offset(10);
         
            make.height.mas_equalTo(20);
        }];



        //
        [_goodsPrices mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLabel.mas_bottom).offset(100);
            make.centerY.equalTo(_nameLabel);
       
            make.height.mas_equalTo(20);
        }];
        [_goodsPrices2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_goodsPrices);
            make.centerY.equalTo(_nameLabel2);
            
            make.height.mas_equalTo(20);
        }];
        [_goodsPrices3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_goodsPrices);
            make.centerY.equalTo(_nameLabel3);
            
            make.height.mas_equalTo(20);
        }];
        [_goodsPrices4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_goodsPrices);
            make.centerY.equalTo(_nameLabel4);
            
            make.height.mas_equalTo(20);
        }];
        [_goodsPrices5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_goodsPrices);
            make.centerY.equalTo(_nameLabel5);
            make.height.mas_equalTo(20);
        }];
        
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_nameLabel);
            make.trailing.equalTo(self).offset(-5);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];
        [_buyView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_buyView);
            make.centerY.equalTo(_nameLabel2);
        
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];
        [_buyView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_buyView);
            make.centerY.equalTo(_nameLabel3);
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];
        [_buyView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_buyView);
            make.centerY.equalTo(_nameLabel4);
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];
        [_buyView5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_buyView);
            make.centerY.equalTo(_nameLabel5);
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
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
-(void)addButtonCliked2:(UIButton*)btn
{
    _buyView2.buyNumber++;
     [_buyView2.addButton setImage:[UIImage imageNamed:@"Plus_2.png"] forState:UIControlStateNormal];
    self.plusBlock(self.amount,YES);
    _buyView2.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView2.buyNumber];
}
-(void)reduceButtonCliked2:(UIButton*)btn
{
    if (_buyView2.buyNumber<=0)
    {
        return;
    }
    self.plusBlock(self.amount,NO);
    _buyView2.buyNumber--;
    _buyView2.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView2.buyNumber];
    
}
-(void)addButtonCliked3:(UIButton*)btn
{
    _buyView3.buyNumber++;
    [_buyView3.addButton setImage:[UIImage imageNamed:@"Plus_2.png"] forState:UIControlStateNormal];
    self.plusBlock(self.amount,YES);
    _buyView3.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView3.buyNumber];
}
-(void)reduceButtonCliked3:(UIButton*)btn
{
    if (_buyView3.buyNumber<=0)
    {
        return;
    }
    self.plusBlock(self.amount,NO);
    _buyView3.buyNumber--;
    _buyView3.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView3.buyNumber];
    
}
-(void)addButtonCliked4:(UIButton*)btn
{
    _buyView4.buyNumber++;
    [_buyView4.addButton setImage:[UIImage imageNamed:@"Plus_2.png"] forState:UIControlStateNormal];
    self.plusBlock(self.amount,YES);
    _buyView4.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView4.buyNumber];
}
-(void)reduceButtonCliked4:(UIButton*)btn
{
    if (_buyView4.buyNumber<=0)
    {
        return;
    }
    
    self.plusBlock(self.amount,NO);
    _buyView4.buyNumber--;
    _buyView4.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView4.buyNumber];
    
}
-(void)addButtonCliked5:(UIButton*)btn
{
    _buyView5.buyNumber++;
    [_buyView5.addButton setImage:[UIImage imageNamed:@"Plus_2.png"] forState:UIControlStateNormal];
    self.plusBlock(self.amount,YES);
    _buyView5.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView5.buyNumber];
}
-(void)reduceButtonCliked5:(UIButton*)btn
{
    if (_buyView5.buyNumber<=0)
    {
        return;
    }
    self.plusBlock(self.amount,NO);
    _buyView5.buyNumber--;
    _buyView5.countLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyView5.buyNumber];
    
}
-(void)addButtonCliked:(UIButton*)btn
{
    _buyView.buyNumber++;
     [_buyView.addButton setImage:[UIImage imageNamed:@"Plus_2.png"] forState:UIControlStateNormal];
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
-(void)setGoodsCategory:(Commodity *)goodsCategory{
// 
//    self.nameLabel.text = goodsCategory.name;
 self.nameLabel.text=@"黑人牙膏";
    self.goodsPrices.text=@"¥ 8 元";
//    self.goodsPrices.text=[NSString stringWithFormat:@"¥%@", goodsCategory.market_price];
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
