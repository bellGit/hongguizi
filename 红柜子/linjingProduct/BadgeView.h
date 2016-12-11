//
//  BadgeView.h
//  ZFShoppingCart
//
//  Created by macOne on 15/11/6.
//  Copyright © 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string;

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string withTextColor:(UIColor *)textColor;

@property (nonatomic,strong) NSString *badgeValue;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com