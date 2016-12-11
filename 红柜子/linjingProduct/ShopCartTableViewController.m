//
//  ShopCartTableViewController.m
//  linjingProduct
//
//  Created by Mac on 16/12/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

//
//  ViewController.m
//  ZFShoppingCart
//
//  Created by macOne on 15/11/3.
//  Copyright © 2015年 WZF. All rights reserved.
//

#import "ShopCartTableViewController.h"
#import "OverlayView.h"
#import "ShoppingCartView.h"
#import "BadgeView.h"

#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ShopCartTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZFReOrderTableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *ordersArray;

@property (nonatomic,strong) CALayer *dotLayer;

@property (nonatomic,assign) CGFloat endPointX;

@property (nonatomic,assign) CGFloat endPointY;

@property (nonatomic,assign) NSUInteger totalOrders;

@property BOOL up;

@property (nonatomic,strong) ShoppingCartView *ShopCartView;


@end

@implementation ShopCartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpShoppingCartView];
   
    
    
    
}
-(void)setUpShoppingCartView{
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, CGRectGetWidth(self.view.bounds), 50) inView:self.view withObjects:nil];
    _ShopCartView.parentView = self.view;
    _ShopCartView.OrderList.delegate = self;
    _ShopCartView.OrderList.tableView.delegate = self;
    _ShopCartView.OrderList.tableView.dataSource = self;
    _ShopCartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ShopCartView];
    
    
    CGRect rect = [self.view convertRect:_ShopCartView.shoppingCartBtn.frame fromView:_ShopCartView];
    
    _endPointX = rect.origin.x + 15;
    _endPointY = rect.origin.y + 35;

}

#pragma mark - setter and getter

-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray array];
    }
    return _ordersArray;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.ordersArray[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return [self.ordersArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        static NSString *cellID = @"ShoppingCartCell";
        
        ShoppingCartCell *cell = (ShoppingCartCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
        }
        NSMutableArray *sectionArray =[NSMutableArray array];
        sectionArray = [self.ordersArray objectAtIndex:indexPath.section];
        
        //
        cell.id = [sectionArray[indexPath.row][@"id"] integerValue];
        cell.nameLabel.text = sectionArray[indexPath.row][@"name"];
        
        float price = [sectionArray[indexPath.row][@"min_price"] floatValue];
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%.0f",price] ;
        
        NSInteger count = [sectionArray[indexPath.row][@"orderCount"] integerValue];
        cell.number = count;
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",count];
        
        cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section % 3 == 0) {
            cell.dotLabel.textColor = [UIColor greenColor];
        }
        else if (indexPath.section % 3 == 1)
        {
            cell.dotLabel.textColor = [UIColor yellowColor];
        }
        else if (indexPath.section % 3 == 2)
        {
            cell.dotLabel.textColor = [UIColor redColor];
        }
        
        cell.operationBlock = ^(NSUInteger nCount,BOOL plus)
        {
            NSMutableDictionary * dic = sectionArray[indexPath.row];
            
            //更新订单列表中的数量
            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            
            //获取当前id的所有数量
            NSInteger nTotal = [self CountAllSections:[NSString stringWithFormat:@"%ld",[dic[@"id"] integerValue]]];
            [dict setObject:[NSNumber numberWithInteger:nTotal] forKey:@"orderCount"];
            
            [self storeOrders:dict isAdded:plus withSectionIndex:indexPath.section withRowIndex:indexPath.row];
            
            
            _totalOrders = plus ? ++_totalOrders : --_totalOrders;
            
            _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
            //刷新tableView
            [self.tableView reloadData];
            [self setCartImage];
            [self setTotalMoney];
            if (_totalOrders <=0) {
                [_ShopCartView dismissAnimated:YES];
            }
            
          }
    return cell;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView])
    {
        return 90;
    }
    else if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        return 50;
    }
    return 90;
}

#define SECTION_HEIGHT 30.0
// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        return SECTION_HEIGHT;
    }
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SECTION_HEIGHT)];
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, SECTION_HEIGHT)];
    [view addSubview:leftLine];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, SECTION_HEIGHT)];
    headerTitle.text = [NSString stringWithFormat:@"%ld号口袋",section +1];
    headerTitle.font = [UIFont systemFontOfSize:12];
    [view addSubview:headerTitle];
    
    if (section == 0) {
        
        leftLine.backgroundColor = [UIColor greenColor];
        UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
        clear.frame= CGRectMake(self.view.bounds.size.width - 100, 0, 100, SECTION_HEIGHT);
        [clear setTitle:@"清空购物车" forState:UIControlStateNormal];
        [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        clear.titleLabel.textAlignment = NSTextAlignmentCenter;
        clear.titleLabel.font = [UIFont systemFontOfSize:12];
        [clear addTarget:self action:@selector(clearShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:clear];
    }
    else{
        
        if (section % 3 == 0) {
            leftLine.backgroundColor = [UIColor greenColor];
        }
        else if (section % 3 == 1)
        {
            leftLine.backgroundColor = [UIColor yellowColor];
        }
        else if (section % 3 == 2)
        {
            leftLine.backgroundColor = [UIColor redColor];
        }
        
    }
    
    //    view.backgroundColor = kUIColorFromRGB(0x9BCB3D);
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([tableView isEqual:self.tableView]) {
        NSLog(@"选中FoodCell");
    }
}


#pragma mark - private method

-(void)clearShoppingCart:(UIButton *)sender
{
    [self.ordersArray removeAllObjects];
    
    
    _totalOrders = 0;
    _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
    
    
    [self setTotalMoney];
    [self setCartImage];
    [self.ShopCartView dismissAnimated:YES];
    
    for (NSMutableDictionary *dic in self.dataArray) {
        
        [dic setObject:@"0" forKey:@"orderCount"];
        
    }
    [self.tableView reloadData];
}

-(void)setCartImage
{
    if (_totalOrders) {
        [_ShopCartView setCartImage:@"cart_1"];
    }
    else{
        [_ShopCartView setCartImage:@"cart"];
    }
    
}

-(void)setTotalMoney
{
    NSInteger nTotal = 0;
    for (NSMutableArray *array in self.ordersArray) {
        for (NSMutableDictionary *dic in array) {
            nTotal += [dic[@"orderCount"] integerValue] * [dic[@"min_price"] integerValue];
        }
    }
    
    [_ShopCartView setTotalMoney:nTotal];
    
}
#pragma mark - store orders 存放订单

-(void)storeOrders:(NSMutableDictionary *)dictionary isAdded:(BOOL)added withSectionIndex:(NSInteger)sectionID withRowIndex:(NSInteger)rowID
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    if (added) {
        //如果订单数组是空（无商品） 则需创建两个section (1号口袋，2号口袋（被添加）)
        if ([self.ordersArray count] <=0) {
            [self.ordersArray addObject:[NSMutableArray array]];
            [self.ordersArray addObject:[NSMutableArray array]];
        }
        //如果是从商品列表中添加，传人的sectionID为0
        //如果是从订单列表中添加，传人的sectionID是订单中实际的section
        
        for (NSMutableDictionary *dic in self.ordersArray[sectionID]) {
            if (dic[@"id"] == dict[@"id"]){
                
                NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
                NSInteger nCount = [dict[@"orderCount"] integerValue] - count;
                
                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                
                self.ShopCartView.OrderList.objects = self.ordersArray;
                [self.ShopCartView.OrderList.tableView reloadData];
                
                return;
            }
        }
        
        NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
        count = [dictionary[@"orderCount"] integerValue] - count;
        [dictionary setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
        [self.ordersArray[sectionID] addObject:dictionary];
        
        self.ShopCartView.OrderList.objects = self.ordersArray;
        [self.ShopCartView.OrderList.tableView reloadData];
    }
    else{
        //从商品列表删除，传人的section =0;优先section：0移除商品，然后再从其他section移除商品
        //从订单列表删除，就从指定的section移除相同的商品
        
        //block 代码段
        void(^block)(NSInteger,NSInteger) = ^(NSInteger section,NSInteger row){
            
            NSDictionary *dic = self.ordersArray[section][row];
            NSInteger count = [dic[@"orderCount"] integerValue];
            if (count <= 0) {
                
                [self.ordersArray[section] removeObjectAtIndex:row];
                self.ShopCartView.OrderList.objects = self.ordersArray;
                [self.ShopCartView.OrderList.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]]  withRowAnimation:UITableViewRowAnimationBottom];
                
                //section
                if ([self.ordersArray[section] count] <=0) {
                    [self.ordersArray removeObjectAtIndex:section];
                    [self.ShopCartView.OrderList.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationBottom];
                }
                
                [self.ShopCartView.OrderList.tableView reloadData];
                [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
            }
            else{
                
            }
        };
        
        
        if (!sectionID && !rowID) {
            NSMutableDictionary *dic = self.ordersArray[sectionID][rowID];
            
            if (dic[@"id"] == dict[@"id"]) {
                NSInteger nCount = [dic[@"orderCount"] integerValue];
                //                nCount -= 1;
                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                block(sectionID,rowID);
                
                self.ShopCartView.OrderList.objects = self.ordersArray;
                
                [self.ShopCartView.OrderList.tableView reloadData];
            }
            else{
                //section:0 有该商品
                NSMutableArray *sectionArray = self.ordersArray[sectionID];
                NSInteger row = 0;
                for (NSMutableDictionary *dic in sectionArray)
                {
                    if (dict[@"id"] == dic[@"id"]) {
                        NSInteger nCount = [dic[@"orderCount"] integerValue];
                        nCount -= 1;
                        [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                        block(sectionID,row);
                        
                        self.ShopCartView.OrderList.objects = self.ordersArray;
                        
                        [self.ShopCartView.OrderList.tableView reloadData];
                        
                        return;
                    }
                    row ++;
                }
                
                //section:0 没有该商品
                for (NSInteger i = sectionID + 1; i < [self.ordersArray count]; i ++) {
                    
                    sectionArray = self.ordersArray[i];
                    row = 0;
                    for (NSMutableDictionary *dic in sectionArray) {
                        if (dict[@"id"] == dic[@"id"]) {
                            NSInteger nCount = [dic[@"orderCount"] integerValue];
                            nCount -= 1;
                            [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                            
                            if (nCount <= 0) {
                                
                                block(i,row);
                                self.ShopCartView.OrderList.objects = self.ordersArray;
                                
                                [self.ShopCartView.OrderList.tableView reloadData];
                                return;
                            }
                            
                            //刷新当前row
                            [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:i],nil] withRowAnimation:UITableViewRowAnimationNone];
                            
                            self.ShopCartView.OrderList.objects = self.ordersArray;
                            
                        }
                        row ++;
                    }
                }
            }
        }
        else{
            
            block(sectionID,rowID);
            
        }
        
        
    }
    
}

//计算在其他section中的指定fooid的个数
-(NSInteger)CountOthersWithoutSection:(NSInteger)sectionID foodID:(NSString *)foodID
{
    NSInteger count = 0;
    for (int i = 0; i< self.ordersArray.count; i++) {
        if (sectionID == i) {
            continue;
        }
        NSMutableArray *array = self.ordersArray[i];
        for (NSMutableDictionary *dic in array) {
            if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                count += [dic[@"orderCount"] integerValue];
            }
        }
    }
    
    return count;
}
//计算所有section中指定fooid的个数
-(NSInteger)CountAllSections:(NSString *)foodID
{
    int nCount = 0;
    for (NSMutableArray *array in self.ordersArray) {
        for (NSMutableDictionary *dic in array)
        {
            if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                nCount += [dic[@"orderCount"] integerValue];
            }
        }
    }
    NSMutableDictionary *dic = [self GetDictionaryFromID:[foodID integerValue]];
    
    [dic setObject:[NSNumber numberWithInt:nCount] forKey:@"orderCount"];
    return nCount;
}

//foodid 获取其模型model 或者字典

-(NSMutableDictionary *)GetDictionaryFromID:(NSInteger)foodID
{
    for (NSMutableDictionary *dic in self.dataArray) {
        if ([dic[@"id"] integerValue] == foodID) {
            return dic;
        }
    }
    return nil;
}


#pragma mark - ZFOrderListsViewDelegate

-(void) updateDataSource:(NSMutableArray *)dataArrays
{
    if ([self.ShopCartView.OrderList.delegate respondsToSelector:@selector(updateDataSource:)]) {
        
        
        self.ordersArray = dataArrays;
        
        //        [self.delegate updateDataSource:dataArrays];
        [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
        [self.ShopCartView.OrderList.tableView reloadData];
        
    }
}

//合并相同的row
-(void) mergeRowsInSection:(NSInteger)section splitRowIdentifier:(NSString *)identifier
{
    if ([self.ShopCartView.OrderList.delegate respondsToSelector:@selector(mergeRowsInSection:splitRowIdentifier:)]) {
        
        NSMutableArray *array = [self.ordersArray objectAtIndex:section];
        
        if (identifier) {
            int index = 0;
            
            for (NSMutableDictionary *dic in array) {
                if ([dic[@"id"] integerValue] == [identifier integerValue]){
                    NSInteger count = [dic[@"orderCount"] integerValue] + 1;
                    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"orderCount"];
                    
                    [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
                    return;
                }
                index ++;
            }
            
            //快速获取当前foodid的详情
            
            for (NSDictionary *dictionary in self.dataArray) {
                if ([dictionary[@"id"] integerValue]== [identifier integerValue]) {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
                    [dict setObject:@1 forKey:@"orderCount"];
                    [array addObject:dict];
                    
                    
                    if (array.count > 1) {
                        [self.ShopCartView.OrderList.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:array.count-1 inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    }
                    else{
                        [self.ShopCartView.OrderList.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    }
                    
                    //更新购物清单的frame
                    [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
                }
            }
        }
        
        int sameIndex = -1;
        for(int i = 0; i< array.count; i++){
            for (int j = i + 1; j < array.count; j++) {
                
                if ([array[i][@"id"] integerValue] == [array[j][@"id"] integerValue]) {
                    
                    NSInteger count = [array[i][@"orderCount"] integerValue] + [array[j][@"orderCount"] integerValue];
                    [array[i] setObject:[NSNumber numberWithInteger:count] forKey:@"orderCount"];
                    sameIndex = j;
                    [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    
                    break;
                }
            }
            
            if (sameIndex > 0) {
                //合并相同的数据
                
                [array removeObjectAtIndex:sameIndex];
                
                [self.ShopCartView.OrderList.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sameIndex inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                
                
                //更新购物清单的frame
                [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
                
                break;
            }
        }
        
    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com