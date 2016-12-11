//
//  CategoryTableViewController.m
//  linjingProduct
//
//  Created by Mac on 16/12/4.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryTableViewCell.h"


@interface CategoryTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * categoriesTableView;

@end

@implementation CategoryTableViewController
-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 239, SCREEN_W * 0.25, SCREEN_H )];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpcategoriesTableView];
    
}
-(void)setUpcategoriesTableView
{
    self.categoriesTableView = ({
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
    [self.view addSubview:self.categoriesTableView];
    [self.categoriesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//左侧 分组 数据的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.categoryData.categories.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
//左侧 分组 tableview cell数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *cell = [CategoryTableViewCell cellWithTable:tableView];
    cell.categroies = self.categoryData.categories[indexPath.row];
    return cell;
}
//左侧 分组 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didTableView:clickedAtIndexPath:)]) {
        [self.delegate didTableView:self.categoriesTableView clickedAtIndexPath:indexPath];
    }
}
- (void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath*)indexPath;
{
    [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
@end
