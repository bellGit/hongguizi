//
//  NavigationView.m
//  linjingProduct
//
//  Created by Mac on 16/12/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "NavigationView.h"
#import "SearchViewController.h"
@interface NavigationView ()<UITextFieldDelegate>
/** 加号按钮 */


@end
@implementation NavigationView
- (instancetype)init {
    self = [super init];
    if (self){
        self.navigationController.navigationBar.barTintColor = COLOR_NA;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        //    标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"新阳街道";
        UIBarButtonItem *labelItem=[[UIBarButtonItem alloc]initWithCustomView:titleLabel];
        //   按钮
        UIButton *downButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,14 , 44)];
        downButton.backgroundColor = [UIColor clearColor];
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
        
        
        
        return self;
        }
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"s");
    SearchViewController *searchViewController=[[SearchViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:searchViewController];
    [self presentViewController:navigationController animated:YES completion:^{
    }];
    
}

@end
