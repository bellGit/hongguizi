//
//  TableViewController.m
//  linjingProduct
//
//  Created by Mac on 16/12/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "TableViewController.h"
#import "CommodityTableViewCell.h"
#import "BuyView.h"
#import "GoodsTableViewCell.h"
#import "RefreshHead.h"
#import "MakeSureOderTableViewController.h"
#import "ProductHeadTableView.h"
#import "CategoryTableViewCell.h"
#import "CategoryDataSource.h"
#import "SearchViewController.h"
#import "ShoppingCartView.h"
#import "NavigationView.h"
#import "BadgeView.h"
//#import "BuyView.h"
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource,CategoryTableViewDelagate,UITextFieldDelegate,ZFReOrderTableViewDelegate>
@property (nonatomic,strong) UITableView * categoriesTableView;
@property (nonatomic,strong) CategoryTableViewController *categoryController;
@property (nonatomic,strong) UITableView *productsTableView;

@property (nonatomic,strong) ShoppingCartView *ShopCartView;
//判断是否从下往上滑
@property (nonatomic) BOOL isScrollDown;
//记录上次滑动位置
@property (nonatomic) CGFloat lastOffsetY;
@property (nonatomic,strong) BuyView *buyView;

@property (nonatomic,assign) CGFloat endPointX;
@property (nonatomic,assign) CGFloat endPointY;
@property (nonatomic,strong) CALayer *dotLayer;
@property (nonatomic,assign) NSUInteger totalOrders;
@property (nonatomic,strong) UIBezierPath *path;
//@property(nonatomic,strong)NavigationView *navigationView;

@end

@implementation TableViewController{
    NSIndexPath *selectIndex;
    BOOL isOpen;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationView];
//    _navigationView=[[NavigationView alloc]init];
  
//    [self.view addSubview:_navigationView];
    [self scrollView];
    //  建立左侧分组tableView
    [self setUpcategoriesTableView];
    //   建立右侧产品tableView
    [self setUpProductsTableView];
    ////    建立下方购物车
    [self setUpShoppingCartView];
    //加载数据
    [self loadData];

    
}
-(void)navigationView{
    self.navigationController.navigationBar.barTintColor = COLOR_NA;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"红柜子";
    UIBarButtonItem *labelItem=[[UIBarButtonItem alloc]initWithCustomView:titleLabel];
    //   按钮
    UIButton *downButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,14 , 44)];
    downButton.backgroundColor = [UIColor clearColor];
    
//    [downButton setImage:[UIImage imageNamed:@"1209_2.jpg"] forState:UIControlStateNormal];
    [downButton setImage:[UIImage imageNamed:@"down@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *midBar=[[UIBarButtonItem alloc]initWithCustomView:downButton];
    UIBarButtonItem* fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 8;
    
    NSArray *buttonArray = [[NSArray alloc]
                            initWithObjects:fixedSpace,labelItem,midBar, nil];
    self.navigationItem.leftBarButtonItems=buttonArray;
    //    textfield
    UITextField *searchTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 230, 28)];
    //    searchTextField.backgroundColor=[UIColor clearColor];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.placeholder=@"输入您喜欢的商品";
    searchTextField.font=[UIFont boldSystemFontOfSize:14];
    searchTextField.textColor=[UIColor whiteColor];
    searchTextField.delegate=self;
    searchTextField.layer.cornerRadius = 14;
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search@2x.png"]];
    img.frame=CGRectMake(0, 0, 30, 10);
    //    [view addSubview:img];
    img.contentMode= UIViewContentModeRight;
    searchTextField.leftView=img;
    searchTextField.leftViewMode=UITextFieldViewModeAlways;
    UIBarButtonItem *searchBar=[[UIBarButtonItem alloc]initWithCustomView:searchTextField];
    self.navigationItem.rightBarButtonItem=searchBar;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
   
    SearchViewController *searchViewController=[[SearchViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:searchViewController];
    [self presentViewController:navigationController animated:YES completion:^{
    }];
    
}
-(void)loadData
{
    WEAKSELf
    [CategoryDataSource loadCategoryData:^(id data, NSError *error) {
        //
        weakSelf.categoryData = data;
        [weakSelf.categoriesTableView reloadData];
        [weakSelf.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

        
        self.categoryController.categoryData =data;
    }];
}
//    建立下方购物车
-(void)setUpShoppingCartView{
    
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, CGRectGetWidth(self.view.bounds), 50) inView:self.view withObjects:nil];
    _ShopCartView.backgroundColor=COLOR_SC;
    _ShopCartView.parentView = self.view;
    _ShopCartView.OrderList.delegate = self;
    _ShopCartView.OrderList.tableView.delegate = self;
    _ShopCartView.OrderList.tableView.dataSource = self;
    
    [self.view addSubview:_ShopCartView];
    
    [_ShopCartView.accountBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    _ShopCartView.accountBtn.enabled = YES;
    _ShopCartView.accountBtn.backgroundColor = COLOR_Pay;
    [_ShopCartView.accountBtn setTitle:[NSString stringWithFormat:@"提交订单"] forState:UIControlStateNormal];
    CGRect rect = [self.view convertRect:_ShopCartView.shoppingCartBtn.frame fromView:_ShopCartView];
    
    _endPointX = rect.origin.x + 15;
    _endPointY = rect.origin.y + 35;
}
-(void)pay:(id)sender{
    MakeSureOderTableViewController *viewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"123"];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:^{
    }];
}
-(void)scrollView{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height+20,SCREEN_W , 175)];
    imageView.image=[UIImage imageNamed:@"1209_1.jpg.png"];
    [self.view addSubview:imageView];
}
//  建立左侧分组tableView
-(void)setUpcategoriesTableView
{
    self.categoryController = [[CategoryTableViewController alloc]init];
    [self addChildViewController:self.categoryController];
    [self.view addSubview:self.categoryController.view];
//    self.delegate = self.categoryController;
    self.categoryController.delegate =self;

 
}
-(void)setUpProductsTableView
{
   
    self.productsTableView = ({
        //        左侧框架置顶左侧
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        //        代理
        tabView.delegate = self;
        tabView.dataSource = self;
        //        分隔线无
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        背景颜色
        tabView.backgroundColor = COLOR_BG;
        //        显示滑动条
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
     self.productsTableView.frame=CGRectMake(SCREEN_W * 0.25, 239, SCREEN_W * 0.75, SCREEN_H - 239);
    [self.view addSubview:self.productsTableView];


    
    
}


//标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
//头部标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProductHeadTableView * head =[ProductHeadTableView headerCellWith:tableView];
    //    头部标题名字
    head.title =self.categoryData.categories[section].name ;
    return head;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (!self.isScrollDown && [self.delegate respondsToSelector:@selector(willDislayHeaderView:)])
    {
        [self.delegate willDislayHeaderView:section];
    }
}
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.isScrollDown && [self.delegate respondsToSelector:@selector(didEndDislayHeaderView:)])
    {
        [self.delegate didEndDislayHeaderView:section];
    }
}
- (void)willDislayHeaderView:(NSInteger)section
{
    [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section+1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
//结束显示头
- (void)didEndDislayHeaderView:(NSInteger)section
{
    [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section+2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


#pragma scorllView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.isScrollDown = self.lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
    
}

#pragma mark CategoryTableViewDelagate
- (void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath*)indexPath;
{
    
    [self.productsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}
- (void)setCategoryData:(CategoryData *)categoryData {
    _categoryData = categoryData;
    [self.productsTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
        
        return 120;
    }
   

    return 90;
}
//section数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//   return 1;
    return self.categoryData.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isOpen && selectIndex.section == section) {
        
       return self.categoryData.categories[section].products.count+1;
    }
  
    return self.categoryData.categories[section].products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
                  CommodityTableViewCell *cell=[CommodityTableViewCell cellWithTable:tableView];

        __weak __typeof(&*cell)weakCell =cell;
        cell.plusBlock = ^(NSInteger nCount,BOOL animated)
        {
//            NSMutableDictionary * dic = _dataArray[indexPath.row];
//            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            CGRect parentRect = [weakCell convertRect:weakCell.buyView.addButton.frame toView:self.view];
            
            if (animated) {
                [self JoinCartAnimationWithRect:parentRect];
                _totalOrders ++;
            }
            else
            {
                _totalOrders --;
            }
            [self setCartImage];
            
            
           
            [self setMoney];
             _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
            int intString = [_ShopCartView.badge.badgeValue intValue];
            NSInteger total;
            total=intString*8;
             _ShopCartView.money.text=[NSString stringWithFormat:@"¥ %ld",(long)total];
        };
        return cell;
        
    }else{
        GoodsTableViewCell * cell = [GoodsTableViewCell cellWithTable:tableView];

      
//    NSObject *obj = self.categoryData.categories[indexPath.section].products[indexPath.row];

       cell.goods = self.categoryData.categories[indexPath.section].products[indexPath.row];
      
        
    
    
    __weak __typeof(&*cell)weakCell =cell;
    cell.plusBlock = ^(NSInteger nCount,BOOL animated)
    {
//                    NSMutableDictionary * dic = self.categoryData.categories[indexPath.section].products[indexPath.row];
//                    [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
//        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
        
//        [self storeOrders:dict isAdded:animated withSectionIndex:0 withRowIndex:0];


        CGRect parentRect = [weakCell convertRect:weakCell.buyView.addButton.frame toView:self.view];
        
         if (animated) {
            [self JoinCartAnimationWithRect:parentRect];
            _totalOrders ++;
        }
        else
        {
            _totalOrders --;
        }
           _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
        [self setCartImage];
        

        
    };
return cell;
    }

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        /**
         *  expand cell select method
         */
        if ([indexPath isEqual:selectIndex]) {
            isOpen = NO;
          
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            selectIndex = nil;
        }else{
            if (!selectIndex) {

                selectIndex = indexPath;
//                [self setModel];
               
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else{
        /**
         *  no reaction
         */
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    isOpen = firstDoInsert;

    
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:selectIndex.section];
    [rowToInsert addObject:indexPathToInsert];
    
    [self.productsTableView beginUpdates];
    if (firstDoInsert)
    {
        [self.productsTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.productsTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.productsTableView endUpdates];
    
    if (nextDoInsert) {
        isOpen = YES;
        selectIndex = [self.productsTableView indexPathForSelectedRow];
        [self setModel];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    if (isOpen){
        [self.productsTableView scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}
-(void)setModel{
    
    
}

#pragma mark - 组合动画
-(void) JoinCartAnimationWithRect:(CGRect)rect
{
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
  
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPointX, _endPointY)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor redColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 15, 15);
    _dotLayer.cornerRadius = (15 + 15) /4;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
    
}
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
    
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        [_ShopCartView.shoppingCartBtn.layer addAnimation:shakeAnimation forKey:nil];
    }
    
}
//-(void)clearShoppingCart:(UIButton *)sender
//{
//    [self.ordersArray removeAllObjects];
//    
//    
//    _totalOrders = 0;
//    _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
//    
//    
//    [self setTotalMoney];
//    [self setCartImage];
//    [self.ShopCartView dismissAnimated:YES];
//    
//    for (NSMutableDictionary *dic in self.dataArray) {
//        
//        [dic setObject:@"0" forKey:@"orderCount"];
//        
//    }
//    [self.productsTableView reloadData];
//}
-(void)setMoney{
    NSInteger nTotal=0;
    nTotal+=_buyView.buyNumber*8;
    _ShopCartView.money.text=[NSString stringWithFormat:@"¥ %ld",(long)nTotal];
}
-(void)setCartImage
{
    if (_totalOrders) {
        [_ShopCartView setCartImage:@"carblue@2x.png"];
    }
    else{
        [_ShopCartView setCartImage:@"carwhite@2x.png"];
    }
    
}

//-(void)setTotalMoney
//{
//    NSInteger nTotal = 0;
//    for (NSMutableArray *array in self.ordersArray) {
//        for (NSMutableDictionary *dic in array) {
//            nTotal += [dic[@"orderCount"] integerValue] * [dic[@"min_price"] integerValue];
//        }
//    }
//    
//    [_ShopCartView setTotalMoney:nTotal];
//    
//}
#pragma mark - store orders 存放订单

//-(void)storeOrders:(NSMutableDictionary *)dictionary isAdded:(BOOL)added withSectionIndex:(NSInteger)sectionID withRowIndex:(NSInteger)rowID
//{
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
//    
//    if (added) {
//        //如果订单数组是空（无商品） 则需创建两个section (1号口袋，2号口袋（被添加）)
//        if ([self.ordersArray count] <=0) {
//            [self.ordersArray addObject:[NSMutableArray array]];
//            [self.ordersArray addObject:[NSMutableArray array]];
//        }
//        //如果是从商品列表中添加，传人的sectionID为0
//        //如果是从订单列表中添加，传人的sectionID是订单中实际的section
//        
//        for (NSMutableDictionary *dic in self.ordersArray[sectionID]) {
//            if (dic[@"id"] == dict[@"id"]){
//                
//                NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
//                NSInteger nCount = [dict[@"orderCount"] integerValue] - count;
//                
//                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
//                
//                self.ShopCartView.OrderList.objects = self.ordersArray;
//                [self.ShopCartView.OrderList.tableView reloadData];
//                
//                return;
//            }
//        }
//        
//        NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
//        count = [dictionary[@"orderCount"] integerValue] - count;
//        [dictionary setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
//        [self.ordersArray[sectionID] addObject:dictionary];
//        
//        self.ShopCartView.OrderList.objects = self.ordersArray;
//        [self.ShopCartView.OrderList.tableView reloadData];
//    }
//    else{
//        //从商品列表删除，传人的section =0;优先section：0移除商品，然后再从其他section移除商品
//        //从订单列表删除，就从指定的section移除相同的商品
//        
//        //block 代码段
//        void(^block)(NSInteger,NSInteger) = ^(NSInteger section,NSInteger row){
//            
//            NSDictionary *dic = self.ordersArray[section][row];
//            NSInteger count = [dic[@"orderCount"] integerValue];
//            if (count <= 0) {
//                
//                [self.ordersArray[section] removeObjectAtIndex:row];
//                self.ShopCartView.OrderList.objects = self.ordersArray;
//                [self.ShopCartView.OrderList.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]]  withRowAnimation:UITableViewRowAnimationBottom];
//                
//                //section
//                if ([self.ordersArray[section] count] <=0) {
//                    [self.ordersArray removeObjectAtIndex:section];
//                    [self.ShopCartView.OrderList.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationBottom];
//                }
//                
//                [self.ShopCartView.OrderList.tableView reloadData];
//                [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
//            }
//            else{
//                
//            }
//        };
//        
//        
//        if (!sectionID && !rowID) {
//            NSMutableDictionary *dic = self.ordersArray[sectionID][rowID];
//            
//            if (dic[@"id"] == dict[@"id"]) {
//                NSInteger nCount = [dic[@"orderCount"] integerValue];
//                //                nCount -= 1;
//                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
//                block(sectionID,rowID);
//                
//                self.ShopCartView.OrderList.objects = self.ordersArray;
//                
//                [self.ShopCartView.OrderList.tableView reloadData];
//            }
//            else{
//                //section:0 有该商品
//                NSMutableArray *sectionArray = self.ordersArray[sectionID];
//                NSInteger row = 0;
//                for (NSMutableDictionary *dic in sectionArray)
//                {
//                    if (dict[@"id"] == dic[@"id"]) {
//                        NSInteger nCount = [dic[@"orderCount"] integerValue];
//                        nCount -= 1;
//                        [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
//                        block(sectionID,row);
//                        
//                        self.ShopCartView.OrderList.objects = self.ordersArray;
//                        
//                        [self.ShopCartView.OrderList.tableView reloadData];
//                        
//                        return;
//                    }
//                    row ++;
//                }
//                
//                //section:0 没有该商品
//                for (NSInteger i = sectionID + 1; i < [self.ordersArray count]; i ++) {
//                    
//                    sectionArray = self.ordersArray[i];
//                    row = 0;
//                    for (NSMutableDictionary *dic in sectionArray) {
//                        if (dict[@"id"] == dic[@"id"]) {
//                            NSInteger nCount = [dic[@"orderCount"] integerValue];
//                            nCount -= 1;
//                            [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
//                            
//                            if (nCount <= 0) {
//                                
//                                block(i,row);
//                                self.ShopCartView.OrderList.objects = self.ordersArray;
//                                
//                                [self.ShopCartView.OrderList.tableView reloadData];
//                                return;
//                            }
//                            
//                            //刷新当前row
//                            [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:i],nil] withRowAnimation:UITableViewRowAnimationNone];
//                            
//                            self.ShopCartView.OrderList.objects = self.ordersArray;
//                            
//                        }
//                        row ++;
//                    }
//                }
//            }
//        }
//        else{
//            
//            block(sectionID,rowID);
//            
//        }
//        
//        
//    }
//    
//}
//


@end
