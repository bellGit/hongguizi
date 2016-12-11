//
//  MakeSureOderTableViewController.m
//  linjingProduct
//
//  Created by Mac on 16/12/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MakeSureOderTableViewController.h"
#import "ShoppingCartView.h"

#import "TableViewController.h"
@interface MakeSureOderTableViewController ()<ZFReOrderTableViewDelegate>
@property (nonatomic,strong) ShoppingCartView *ShopCartView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation MakeSureOderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self navigationView];
  
    [self setUpShoppingCartView];
//    NSDictionary *dic1 = @{@"id": @9323283,
//                           @"name": @"黑人牙膏",
//                           @"min_price": @8.0,
//                           @"praise_num": @1,
//                          
//                    };
//    
//    NSDictionary *dic2 = @{@"id": @9323284,
//                           @"name": @"黑妹牙膏",
//                           @"min_price": @8.0,
//                           @"praise_num": @1,
//                           };
//    NSDictionary *dic3 = @{@"id": @9323285,
//                           @"name": @"中华牙膏",
//                           @"min_price": @8.0,
//                           @"praise_num": @1,
//                           
//                           };
//    _listTableView.delegate=self;
//    _listTableView.dataSource=self;
//    _dataArray = [@[[dic1 mutableCopy],[dic2 mutableCopy],[dic3 mutableCopy],] mutableCopy];

  
}
-(void)navigationView{
//    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = COLOR_NA;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    左边按钮
    UIButton *downButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,11.0 , 20.0)];
    downButton.backgroundColor = [UIColor clearColor];
    [downButton setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(returnDetailView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBar=[[UIBarButtonItem alloc]initWithCustomView:downButton];
    self.navigationItem.leftBarButtonItem=leftBar;
    //    标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"确认订单";
    self.navigationItem.titleView = titleLabel;
}
-(void)setUpShoppingCartView{
      NSLog(@"111");
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-112, CGRectGetWidth(self.view.bounds), 50) inView:self.view withObjects:nil];
    _ShopCartView.backgroundColor=COLOR_SC;
    _ShopCartView.parentView = self.view;
    _ShopCartView.OrderList.delegate = self;
    _ShopCartView.OrderList.tableView.delegate = self;
    _ShopCartView.OrderList.tableView.dataSource = self;
    [_ShopCartView.shoppingCartBtn setBackgroundImage:[UIImage imageNamed:@"carblue@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:_ShopCartView];
    [_ShopCartView.money setText:@"¥ 32"];
    _ShopCartView.accountBtn.backgroundColor = COLOR_Pay2;
    [_ShopCartView.accountBtn setTitle:[NSString stringWithFormat:@"提交订单"] forState:UIControlStateNormal];
    [_ShopCartView.accountBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    _ShopCartView.accountBtn.enabled = YES;
//    CGRect rect = [self.view convertRect:_ShopCartView.shoppingCartBtn.frame fromView:_ShopCartView];
    
  
}
-(void)pay:(id)sender{
    TableViewController *tackOutviewController=[[TableViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:tackOutviewController];
    [self presentViewController:navigationController animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)returnDetailView{
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击Cancel按钮，关闭模态视图");
    }];
}


@end
