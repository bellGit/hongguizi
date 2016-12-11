//
//  BuyView.m
//  linjingProduct
//
//  Created by Mac on 16/11/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "BuyView.h"

@interface BuyView ()
/** 加号按钮 */

/** 数量label */

@end
@implementation BuyView

- (instancetype)init {
    self = [super init];
    if (self)
    {
        _addButton = [[UIButton alloc]init];
        [_addButton setImage:[UIImage imageNamed:@"Plus.png"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
        
        _countLabel = [[UILabel alloc]init];
        _countLabel.text = @"0";
        _countLabel.font = kFont(14);
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
        
        _reduceButton = [[UIButton alloc]init];
        [_reduceButton setImage:[UIImage imageNamed:@"Minus.png"] forState:UIControlStateNormal];
        [_reduceButton addTarget:self action:@selector(reduceButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reduceButton];
        
        [_reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(self.mas_height);
        }];
        
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_reduceButton.mas_trailing).offset(3);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.trailing.equalTo(_addButton.mas_leading).offset(-2);
        }];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(self.mas_height);
        }];
    }
    
    return self;
}
-(void)setGoodNum:(NSInteger)goodNum
{
    _goodNum = goodNum;
    self.buyNumber = goodNum;
}
-(void)setBuyNumber:(NSInteger)buyNumber
{
    _buyNumber = buyNumber;
    if (buyNumber == 0)
    {
        self.reduceButton.hidden = YES;
        self.countLabel.hidden = YES ;
         [_addButton setImage:[UIImage imageNamed:@"Plus.png"] forState:UIControlStateNormal];
    }else
    {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)buyNumber];
        self.reduceButton.hidden = NO;
        self.countLabel.hidden = NO;
    }
}

-(void)addButtonCliked:(UIButton*)btn
{
//    self.buyNumber++;
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.buyNumber];
}
-(void)reduceButtonCliked:(UIButton*)btn
{
//    if (self.buyNumber<=0)
//    {
//        return;
//    }
//    
//    self.buyNumber--;
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.buyNumber];

}


@end

