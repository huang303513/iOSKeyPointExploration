//
//  ViewController.m
//  隐式动画
//
//  Created by maiyun on 15/6/24.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "AnimationType.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataSourceList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc]init];
    self.tableview.frame = self.view.frame;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:self.tableview];
    
    self.dataSourceList = [NSMutableArray array];
    
    AnimationType *animationType;
    animationType = [[AnimationType alloc]initWithTitle:@"通过CATransaction做动画" detailTitle:@"通过CATransaction做动画FirstVC第七章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"为CALayer添加自定义行为实现从左侧切入效果" detailTitle:@"为CALayer添加自定义行为secondVC第七章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"通过hitTest来测试是否点中呈现图层" detailTitle:@"通过hitTest来测试是否点中呈现图层thirdVC第七章"];
    [self.dataSourceList addObject:animationType];

    
    
    [self.tableview reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaaaa"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"aaaaa"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AnimationType *currentType = self.dataSourceList[indexPath.row];
    cell.textLabel.text = currentType.title;
    cell.detailTextLabel.text = currentType.detailTitle;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FirstViewController *firstVC = [[FirstViewController alloc]init];
        [self.navigationController pushViewController:firstVC animated:YES];
    }else if(indexPath.row == 1){
        SecondViewController *secondVC = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:secondVC animated:YES];
    }else if(indexPath.row == 2){
        ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
        [self.navigationController pushViewController:thirdVC animated:YES];
    }
        
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
