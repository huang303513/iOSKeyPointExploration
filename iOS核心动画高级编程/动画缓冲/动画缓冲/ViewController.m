//
//  ViewController.m
//  动画缓冲
//
//  Created by 黄成都 on 15/6/28.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "AnimationType.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
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
    animationType = [[AnimationType alloc]initWithTitle:@"使用缓冲函数" detailTitle:@"使用CAMediaTimingFunction缓冲函数firstVC第十章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"UIKit动画的缓冲设置动画效果" detailTitle:@"UIKit动画的缓冲设置动画效果secondVC第10章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"给关键帧动画设置CAMediaTimingFunction属性" detailTitle:@"给关键帧动画设置CAMediaTimingFunction属性thirdVC第10章"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"使用UIBezierPath绘制CAMediaTimingFunction" detailTitle:@"使用UIBezierPath绘制CAMediaTimingFunction,fourVC第10章"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"使用关键帧实现反弹球的动画" detailTitle:@"使用关键帧实现反弹球的动画,fiveVC第10章"];
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
    }else if(indexPath.row == 3){
        FourViewController *fourVC = [[FourViewController alloc]init];
        [self.navigationController pushViewController:fourVC animated:YES];
    }else if(indexPath.row == 4){
        FiveViewController *fiveVC = [[FiveViewController alloc]init];
        [self.navigationController pushViewController:fiveVC animated:YES];
    }

    
}

@end
