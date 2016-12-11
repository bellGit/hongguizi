//
//  BuyView.h
//  linjingProduct
//
//  Created by Mac on 16/11/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyView : UIView
@property(nonatomic,assign) NSInteger goodNum;
@property (nonatomic,strong) UIButton *addButton;
/** 减号按钮 */
@property (nonatomic,strong) UIButton *reduceButton;
@property (nonatomic,strong) UILabel *countLabel;
/** 购买商品的数量  */
@property (nonatomic,assign) NSInteger buyNumber;
@end
