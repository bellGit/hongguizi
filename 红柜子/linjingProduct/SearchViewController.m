//
//  SearchViewController.m
//  linjingProduct
//
//  Created by Mac on 16/12/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property(nonatomic,strong)UITextField *searchTextField;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationView];
}
-(void)navigationView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = COLOR_Gray;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
//    左边按钮
    UIButton *downButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,11.0 , 20.0)];
    downButton.backgroundColor = [UIColor clearColor];
    [downButton setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(returnDetailView) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftBar=[[UIBarButtonItem alloc]initWithCustomView:downButton];
    self.navigationItem.leftBarButtonItem=leftBar;
//
    UITextField *searchTextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 230, 28)];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;

    searchTextField.font=[UIFont boldSystemFontOfSize:14];
    searchTextField.textColor=[UIColor whiteColor];

    searchTextField.layer.cornerRadius = 2;
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search@2x.png"]];
    img.frame=CGRectMake(0, 0, 30, 10);
    //    [view addSubview:img];
    img.contentMode= UIViewContentModeRight;
    searchTextField.leftView=img;
    searchTextField.leftViewMode=UITextFieldViewModeAlways;
    searchTextField.clearButtonMode=UITextFieldViewModeAlways;
//    UISearchBar *searchBar=[[UISearchBar alloc]init];
//       searchBar.frame = CGRectMake(0, 0, 230, 44.0);
//   searchBar.layer.masksToBounds = YES;
  
    self.navigationItem.titleView = searchTextField;
//    右边
    UIButton *searchButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,44 , 30)];
    searchButton.backgroundColor =COLOR_NA;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.userInteractionEnabled=YES;
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:searchButton];
   
    self.navigationItem.rightBarButtonItem=rightBar;
}
-(void)search{
    NSLog(@"搜索");
}
-(void)returnDetailView{
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击Cancel按钮，关闭模态视图");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
