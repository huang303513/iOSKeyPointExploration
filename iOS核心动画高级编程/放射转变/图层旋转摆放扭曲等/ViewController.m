//
//  ViewController.m
//  图层旋转摆放扭曲等
//
//  Created by maiyun on 15/6/15.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "AnimationType.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

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
    animationType = [[AnimationType alloc]initWithTitle:@"旋转/缩小/移动" detailTitle:@"旋转/缩小/移动FirstVC第五章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"3D旋转" detailTitle:@"围绕Y轴做45度角的旋转FirstVC第五章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"子视图有相同的灭点" detailTitle:@"子视图有相同的灭点SecondVC第五章"];
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
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//旋转45度
        FirstViewController *firstVC = [[FirstViewController alloc]init];
        firstVC.type = 1;
        [self.navigationController pushViewController:firstVC animated:YES];
    }else if(indexPath.row == 1){
        FirstViewController *firstVC = [[FirstViewController alloc]init];
        firstVC.type = 2;
        [self.navigationController pushViewController:firstVC animated:YES];
    }else if(indexPath.row == 2){
        SecondViewController *secondVC = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:secondVC animated:YES];
    }
}
@end
