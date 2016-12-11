//
//  RefreshHead.m
//  linjingProduct
//
//  Created by Mac on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RefreshHead.h"

@implementation RefreshHead
- (void)prepare {
    [super prepare];
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
    
    [self setImages:@[[UIImage imageNamed:@"1-1.png"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"1-3.png"]] forState:MJRefreshStatePulling];
    [self setImages:@[[UIImage imageNamed:@"1-1.png"],[UIImage imageNamed:@"1-2.png"],[UIImage imageNamed:@"1-3.png"]] forState:MJRefreshStateRefreshing];
    
//    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
}

@end
